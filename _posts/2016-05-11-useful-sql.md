---
title: Useful SQL
date: 2016-05-11 11:10:00 +0800
categories: [technologies]
tags: [sql,oracle]
author: Kevin
---

A handful SQL which can help you to diagnose your oracle database.

### Find SQL That is Currently Running

	SELECT A.USERNAME, A.SID, B.SQL_TEXT, B.SQL_FULLTEXT
	  FROM V$SESSION A, V$SQLAREA B
	 WHERE A.SQL_ADDRESS = B.ADDRESS;
	 
### Find Executed SQL History

	SELECT S.SAMPLE_TIME,
		   SQ.SQL_TEXT,
		   SQ.DISK_READS,
		   SQ.BUFFER_GETS,
		   SQ.CPU_TIME,
		   SQ.ROWS_PROCESSED,
		   SQ.SQL_FULLTEXT,
		   SQ.SQL_ID,
		   S.PROGRAM,
		   S.MACHINE
	  FROM V$SQL SQ, V$ACTIVE_SESSION_HISTORY S
	 WHERE S.SQL_ID = SQ.SQL_ID
	   AND SQ.SQL_FULLTEXT LIKE '%***%'
	 ORDER BY S.SAMPLE_TIME DESC;
	 
### Find Top 10 SQL with Bad Performance

    SELECT *
      FROM
           (SELECT PARSING_USER_ID,
                    EXECUTIONS,
                    SORTS,
                    COMMAND_TYPE,
                    DISK_READS,
                    SQL_TEXT
               FROM V$SQLAREA
           ORDER BY DISK_READS DESC
           )
     WHERE ROWNUM < 10;
	 
### Find SQL with Heavy IO

	SELECT SE.SID,
		   SE.SERIAL#,
		   PR.SPID,
		   SE.USERNAME,
		   SE.STATUS,
		   SE.TERMINAL,
		   SE.PROGRAM,
		   SE.MODULE,
		   SE.SQL_ADDRESS,
		   ST.EVENT,
		   ST. P1TEXT,
		   SI.PHYSICAL_READS,
		   SI.BLOCK_CHANGES
	  FROM V$SESSION SE, V$SESSION_WAIT ST, V$SESS_IO SI, V$PROCESS PR
	 WHERE ST.SID = SE.SID
	   AND ST. SID = SI.SID
	   AND SE.PADDR = PR.ADDR
	   AND SE.SID > 6
	   AND ST. WAIT_TIME = 0
	   AND ST.EVENT NOT LIKE '%SQL%'
	 ORDER BY PHYSICAL_READS DESC;
	 
### Find Blocks

	SELECT S1.USERNAME || '@' || S1.MACHINE || ' ( SID=' || S1.SID ||
		   ' )  is blocking ' || S2.USERNAME || '@' || S2.MACHINE || ' ( SID=' ||
		   S2.SID || ' ) ' AS BLOCKING_STATUS
	  FROM V$LOCK L1, V$SESSION S1, V$LOCK L2, V$SESSION S2
	 WHERE S1.SID = L1.SID
	   AND S2.SID = L2.SID
	   AND L1.BLOCK = 1
	   AND L2.REQUEST > 0
	   AND L1.ID1 = L2.ID1
	   AND L2.ID2 = L2.ID2;
	   
	SELECT 'blocker(' || LB.SID || ':' || SB.USERNAME || ')-sql:' ||
		   QB.SQL_TEXT BLOCKERS,
		   'waiter (' || LW.SID || ':' || SW.USERNAME || ')-sql:' ||
		   QW.SQL_TEXT WAITERS
	  FROM V$LOCK LB, V$LOCK LW, V$SESSION SB, V$SESSION SW, V$SQL QB, V$SQL QW
	 WHERE LB.SID = SB.SID
	   AND LW.SID = SW.SID
	   AND SB.PREV_SQL_ADDR = QB.ADDRESS
	   AND SW.SQL_ADDRESS = QW.ADDRESS
	   AND LB.ID1 = LW.ID1
	   AND SW.LOCKWAIT IS NOT NULL
	   AND SB.LOCKWAIT IS NULL
	   AND LB.BLOCK = 1;
	   
### Find Last SQL Executed By a Session

    SELECT
           /*+ ORDERED USE_NL(st) */
           SQL_TEXT  
      FROM V$SESSION SES,
           V$SQLTEXT ST
     WHERE ST.ADDRESS    = SES.SQL_ADDRESS
       AND ST.HASH_VALUE = SES.SQL_HASH_VALUE
       AND SES.USERNAME  = 'YOUR_USER_NAME'
    ORDER BY PIECE;
	
	
### Find Foreign Key Which is Not Indexed

	SELECT TABLE_NAME
		FROM USER_TAB_COLUMNS
	   WHERE COLUMN_NAME = 'FOREIGN_KEY_NAME'
		 AND TABLE_NAME NOT IN
			 (SELECT TABLE_NAME FROM USER_IND_COLUMNS WHERE COLUMN_NAME = 'FOREIGN_KEY_NAME') ;
			 
### Recompute Statistics

    SELECT 'analyze table '||TABLE_NAME||' delete statistics; ' FROM USER_TABLES;
    
    SELECT 'analyze table '||TABLE_NAME||' compute statistics;' FROM USER_TABLES;
    
    SELECT 'alter index '
           || INDEX_NAME
           ||' rebuild tablespace '
           || TABLESPACE_NAME
           ||' compute statistics;'
      FROM USER_INDEXES
     WHERE INDEX_NAME NOT LIKE 'SYS%';
     
    SELECT 'alter index '
           ||TABLE_OWNER
           ||'.'
           ||INDEX_NAME
           ||' compute statistics;'
      FROM USER_INDEXES
     WHERE INDEX_NAME NOT LIKE 'SYS%';
	 

### Test a String for a Numeric Value

	SELECT LENGTH(TRIM(TRANSLATE('string', ' +-.0123456789', ' '))) from dual;
