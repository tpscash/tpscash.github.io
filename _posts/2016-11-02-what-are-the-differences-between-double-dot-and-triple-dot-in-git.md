---
title: What are the Diffferences Between Double Dot and Triple Dot in Git
date: 2016-11-02 17:30:00 +0800
categories: [technologies]
tags: [git]
author: Kevin
---

The double dot and triple dot have different meanings when use them in `git diff` and `git log`.

The command `git diff` typically only shows you the difference between the states of the tree between exactly two points in the commit graph.

The `..` and `...` notations in `git diff` have the following meanings:

![git diff](/images/posts/git/git-diff-help.png)

`git diff foo..bar` is exactly the same as `git diff foo bar` - both will show you the difference between the tips of the two branches foo and bar. 

On the other hand, `git diff foo...bar` will show you the difference between the "merge base" of the two branches and the tip of bar. The "merge base" is usually the last commit in common between those two branches, so this command will show you the changes that your work on bar has introduced, while ignoring everything that has been done on foo in the mean time.

A common source of confusion here is that `..` and `...` mean subtly different things when used in a command such as `git log` that expects a set of commits as one or more arguments. (These commands all end up using `git rev-list` to parse a list of commits from their arguments).

The meaning of `..` and `...` for git log can be shown graphically as below:

![git log](/images/posts/git/git-log-help.png)

So, `git rev-list foo..bar` shows you everything on branch bar that isn't also on branch foo. 

On the other hand, `git rev-list foo...bar` shows you all the commits that are in either foo or bar, but not both. 

The third diagram just shows that if you list the two branches, you get the commits that are in either one or both of them
