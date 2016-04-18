---
title: "Diagnose High CPU Java Process on Linux"
date: 2016-04-18 22:30:00 +0800
categories: [technologies]
tags: [java]
---

If you are running into issue with java process with high CPU utilization, just do below simple steps to get some clue:

1. Get the PID of the java process that has issue just by `top`

2. Get TID of the threads in the process that consumes a lot of CPU time

    `ps -Lf [PID]`
    
    or
    
    `ps H -eo user,pid,ppid,tid,time,%cpu --sort=%cpu | grep [PID]`
    
3. Get a thread dump by jstack

    `jstack PID > /var/tmp/thread_dump_[PID].txt`
    
4. Convert the TID found in step 2 to NID (Oct to Hex)
    
    `e.g. 9588 -> 0x2574`
    
5.  Find the NID in the thread dump file and check the stack to see what the thread does

    `grep [NID] /var/tmp/thread_dump_[PID].txt` 