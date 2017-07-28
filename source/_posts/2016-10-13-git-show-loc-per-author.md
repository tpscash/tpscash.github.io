title: Show LOC per Author in Git
date: 2016-10-13 13:30:00 +0800
categories:
 - technologies
tags:
 - git
author: Kevin
---

If you want to check how many lines of code you've pushed to a Git repository, you can do it by `git log`.

Two ways to get the numbers, using `gawk` and `awk` repectively:

<!-- more -->

	git log --author="Kevin He" --pretty=tformat: --numstat | gawk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s removed lines: %s total lines: %s\n", add, subs, loc }'
	
	git log --numstat --pretty="%H" --author="Kevin He" | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("+%d, -%d, %d\n", plus, minus, plus-minus)}'
    
If you want check LOC of a specified time period, you can do:
	
	git log --numstat --pretty="%H" --author="Kevin He" --since 2weeks | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("+%d, -%d, %d\n", plus, minus, plus-minus)}'
	
Or you want to check LOC changed between two commits:

	git log --numstat --pretty="%H" --author="Kevin He" commit1..commit2 | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("+%d, -%d, %d\n", plus, minus, plus-minus)}'
