---
title: Clone a database in MySQL
date: 2016-08-18 22:30:00 +0800
categories: [technologies]
tags: [mysql]
author: Kevin
---

There are different ways to clone a database in MySQL.

## Using mysqldbcopy

The MySQL Utilities contain the nice tool `mysqldbcopy` which by default copies a DB including all related objects (tables, views, triggers, events, procedures, functions, and database-level grants) and data from one DB server to the same or to another DB server. There are lots of options available to customize what is actually copied

    mysqldbcopy \
        --source=root:password@localhost \
        --destination=root:password@localhost \
        db1:db2


## Using mysqldump

    mysqladmin create db2 -uroot -ppassword && \
        mysqldump -uroot -ppassword db1 | mysql -uroot -ppassword -h db_host db2




