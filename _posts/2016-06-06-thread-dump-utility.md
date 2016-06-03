---
title: Thread Dump Utility
date: 2016-06-06 23:30:00 +0800
categories: [technologies]
tags: [linux,shell,thread]
author: Kevin
---

A useful script to dump thread information:

	#!/bin/sh

	if [ $# -ne 1 ]; then
	  echo "Usages: `basename $0` {PID}" 
	  exit -1
	else
	  RET=`expr match $1 "[0-9]*$"`
	  if [ "$RET" -gt 0 ]; then
		echo "Input PID: [$1]"
		PID=$1
	  else
		echo "Invalid number: [$1]"
		exit -1
	  fi
	fi

	PROCESS=`ps -p $PID -o args=`

	if [ "$PROCESS" = "" ]; then
	  echo "PID doesn't exist on this host!"
	  exit -1
	fi

	JAVA_PATH=`echo $PROCESS | awk '{print $1}'`

	if [[ "$JAVA_PATH" =~ ".*java.*" ]]; then
	  JDK_PATH=${JAVA_PATH%/*}
	else
	  echo "Not a java process!"
	  exit -1
	fi

	JSTACK_PATH=$JDK_PATH/jstack

	if [ -e $JSTACK_PATH ]; then
	  echo "jstack: $JSTACK_PATH"
	else
	  echo "jstack is not found at $JSTACK_PATH"
	  exit -1
	fi

	HOST=`hostname`

	DATETIME=`date "+%Y%m%d_%H%M%S"`

	FILE_PATH=/tmp/thread_dump_${HOST}_${PID}_${DATETIME}

	echo "Writing thread dump to file $FILE_PATH"

	ps H -eo user,pid,ppid,tid,time,%cpu --sort=%cpu | grep $PID > $FILE_PATH

	$JSTACK_PATH $PID >> $FILE_PATH

	if [ $? = 0 ];then
	  echo "Thread dump is done"
	else
	  echo "Thread dump is failed"
	fi