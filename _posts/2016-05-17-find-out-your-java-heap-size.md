---
title: Find Out Your Java Heap Size
date: 2016-05-16 13:40:00 +0800
categories: [technologies]
tags: [jvm]
author: [Kevin]
---

In the [oracle memory management whitepaper] (http://www.oracle.com/technetwork/java/javase/memorymanagement-whitepaper-150215.pdf), it states:

>On a server-class machine running either JVM (client or server) with the parallel garbage collector, the default
>initial and maximum heap sizes are
>	* Initial heap size of 1/64th of the physical memory, up to 1GB. (Note that the minimum initial heap size
>is 32MB, since a server-class machine is defined to have at least 2GB of memory and 1/64th of 2GB is
>32MB.)
>	* Maximum heap size of 1/4th of the physical memory, up to 1GB.

But seems this statement doesn't hold any longer for modern JVMs.

To find out what is the default max heap size for JDK:

	java -XX:+PrintFlagsFinal -version | grep MaxHeapSize
	
To find out the max heap size for your running Java process:

	jinfo -flag MaxHeapSize [PID]
	
	jinfo -flags [PID]