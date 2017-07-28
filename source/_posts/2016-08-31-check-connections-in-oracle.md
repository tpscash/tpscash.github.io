---
title: Check Connections in Oracle
date: 2016-08-31 15:00:00 +0800
categories:
 - technologies
tags:
 - oracle
author: Kevin
---

To monitor the connections used in Oracle, you can use below SQL to get the data.

<!-- more -->

Get current connections and percentage of used connection to max connections:

	SELECT I.INSTANCE_NAME,
		   I.HOST_NAME,
		   COUNT(*) CONNECTIONS,
		   ROUND((COUNT(*) / P.VALUE * 100),2) AS PERCENT_USED
	FROM GV$SESSION S, GV$INSTANCE I, GV$PARAMETER P
	WHERE S.INST_ID = I.INST_ID AND I.INST_ID = P.INST_ID
	  AND USERNAME = 'YOUR_USER'
	  AND P.NAME = 'sessions'
	GROUP BY I.HOST_NAME, I.INSTANCE_NAME, P.VALUE
	ORDER BY I.HOST_NAME;
	
Get connections count for each machine:

	SELECT MACHINE, COUNT(*)
	FROM GV$SESSION S, GV$INSTANCE I, GV$PARAMETER P
	WHERE S.INST_ID = I.INST_ID AND I.INST_ID = P.INST_ID
	  AND USERNAME = 'YOUR_USER'
	GROUP BY MACHINE;




