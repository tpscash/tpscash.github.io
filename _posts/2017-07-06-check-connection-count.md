---
title: Check DB Connection Count for Processes on Linux
date: 2017-06-29 23:30:00 +0800
categories: [technologies]
tags: [linux]
author: Kevin
---

Do you know how many DB connections does your process obtain? How to locate the culprit process if your database server reaches its max connections limit unexpectly? It is easy to find it out on Linux just by a few commands


## Get Total Connection Count for All Processes

```
netstat -ap | grep [database_host] | awk '{print $7}' | awk -F '/' '{print $1}' | grep -v '-' | sort -n | uniq -c | awk '{s+=$1} END {print s}'
```

##  List All Processes Connect to Database

```
netstat -ap | grep [database_host] | awk '{print $7}' | awk -F '/' '{print $1}' | grep -v '-' | sort -n | uniq | xargs ps wwp
```

## List Connection Count for Each Process

```
paste -d ':' <(netstat -ap | grep [database_host] | awk '{print $7}' | awk -F '/' '{print $1}' | grep -v '-' | sort -n | uniq -c | awk '{print $1}') <(netstat -ap | grep [database_host] | awk '{print $7}' | awk -F '/' '{print $1}' | grep -v '-' | sort -n | uniq | xargs ps --no-headers wwp)
```

## List Connection Count for Each Process (Simplified)

```
paste  <(netstat -ap | grep [database_host] | awk '{print $7}' | awk -F '/' '{print $1}' | grep -v '-' | sort -n | uniq -c | awk 'BEGIN {print "COUNT"} {printf "%5s\n", $1}') <(netstat -ap | grep [database_host] | awk '{print $7}' | awk -F '/' '{print $1}' | grep -v '-' | sort -n | uniq | xargs ps wwp |  awk '{printf "%-8s", $1; print $NF}')
```





