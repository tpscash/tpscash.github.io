title: An Introduction to Git
date: 2016-04-19 21:55:00 +0800
categories:
 - technologies
tags:
 - git
author: Kevin
---

Here is a brief introduction to Git quotes from [Pro Git](https://git-scm.com/book/en/v2)

<!-- more -->

## What is Git

Created in 2005, as a replacement of BitKeeper which is the previous VCS of project Linux kernel. Goals of Git:

* Speed
* Simple design
* Strong support for non-linear development
* Fully distributed
* Able to handle large projects like Linux kernel efficiently

Git stores and thinks about information much differently than other VCSs.

### Snapshots, Not differences

The major differences between Git and any other VCS is the way Git think about data. Other VCS stores data as changes to a base version of each file while Git thinks of its data more like a set of snapshots of a miniature file system.

***Storing data as changes to a base version of each file:***

![deltas](/images/posts/git/deltas.png)

***Storing data as snapshots of the project over time:***

![snapshots](/images/posts/git/snapshots.png)

### Nearly Every Operation Is Local

Most operations in Git only need local files and resources to operate - generally no information is needed from another computer on your network. Because you have entire history of the project on your local disk. You can even browse project history and do commit offline.

### The Three States

Git has three main states that your files can reside in: **committed**, **modified** and **staged**.

* **Committed** means that the data is safely stored in your local database
* **Modified** means you have changed the file but have not committed it to your database
* **Staged** means you have marked a modified file in its current version to go into your next commit snapshot

![areas](/images/posts/git/areas.png)

## Get Started

### ~~Install Git~~

### First-time Git Setup

Git comes with a tool called git config and lets you get and set configuration variables that control all aspects of how Git looks and operates. These variables can be stored in three different places:

1. `/etc/gitconfig` : contains values for all users. If you use `git config --system`, it reads and writes from this file specifically

2. `~/.gitconfig` or `~/.config/git/config` : Specific to your user. You can use `git config --global` to read and write this file specifically

3. `.git/config` in your repository: Specific to that single repository

**Each level overrides values in the previous level**

### Your Identify

    $ git config --global user.name "Kevin He"
    $ git config --global user.email kevin_pro@163.com
    
### Your Editor

    $ git config --global core.editor "'C:/Program Files (x86)/Notepad++/notepad++.exe' -multiInst -nosession"

### Checking Your Settings

    $ git config --list
    user.name=Kevin He
    user.email=kevin_pro@163.com

    

