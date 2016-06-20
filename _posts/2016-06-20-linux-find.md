---
title: Linux Find
date: 2016-06-20 10:30:00 +0800
categories: [technologies]
tags: [linux]
author: Kevin
---

Usage of find command.

	fine -name     # Find by file name, wild-card is supported
	find -amin n   # File was last accessed n minutes ago
	find -atime n  # File was last accessed n*24 hours ago
	find -mmin n   # File's data was last modified n minutes ago
	find -mtime n  # File's data was last modified n*24 hours ago
	find -cmin n   # File's status was last changed n minutes ago
	find -ctime n  # File's status was last changed n*24 hours ago
	find -type f / find -type d    # Find by file type
	find -size     # Find by file size
	find -user     # Find files are owned by user uname
	find -group gname  # Find files belongs to group gname

Find by modified time

	find -mtime n
	n:  current time - (n + 1) * 24 ~ current time - n * 24
	+n: -∞ ~ current time - (n + 1) * 24
	-n: current time - n * 24 ~ +∞
	