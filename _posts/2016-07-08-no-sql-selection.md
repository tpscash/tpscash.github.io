---
title: NOSQL Selection
date: 2016-07-08 10:30:00 +0800
categories: [technologies]
tags: [database,nosql]
author: Kevin
---

While SQL databases are insanely useful tools, their monopoly in the last decades is coming to an end. And it's just time: I can't even count the things that were forced into relational databases, but never really fitted them. (That being said, relational databases will always be the best for the stuff that has relations.)

But, the differences between NoSQL databases are much bigger than ever was between one SQL database and another. This means that it is a bigger responsibility on **software architects** to choose the appropriate one for a project right at the beginning.

In this light, here is a **comparison** of **Open Source** NOSQL databases.

![comparison.png](/images/posts/nosql/comparison.png)

NOSQL is sort of based on CAP theorem. Traditional RDBMS has high expectation on consistency, so it is weak on availability and partition tolerance. NOSQL is on the opposite, it scarifies consistency for AP.

Based on the CAP theorem, you can choose the NOSQL database accordingly based on your application needs:

* CA - RDBMS
* CP - Key-value database. Such as Google Big Table
* AP - Document-oriented database. Such as Amazon Dynamo.

A visual guide to NOSQL systems:

![cap.jpg](/images/posts/nosql/cap.jpg)