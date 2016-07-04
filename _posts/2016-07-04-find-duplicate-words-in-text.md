---
title: Grep Duplicate Words in Text
date: 2016-07-04 10:30:00 +0800
categories: [technologies]
tags: [linux]
author: Kevin
---

To find duplicate words in a text by grep and support non-greedy search, you need to use `-P` which uses Perl regular expression to parse the pattern.

Example:

	$ echo 'This is a line of text text which has duplicate words words' | grep -Po '(\b.+)\1\b'
	
The output will be
	text text
	words words
	
`-o` means show only the part of a line matching pattern.

