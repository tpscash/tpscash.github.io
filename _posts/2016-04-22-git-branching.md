---
title: Git Branching
date: 2016-04-22 10:50:00 +0800
categories: [technologies]
tags: [git]
author: [Kevin]
---

Git Branches in a Nutshell

## Branches in a Nutshell

What does Git do when you make a commit? Git stores a commit object that contains a pointer to the snapshot of the content you staged.

This commit object contains the author's name and email, the message that you typed and pointers to the commit or commits that directly came before this commit.

Let's take an example:

    $ git add REAME.md FAQ.md LICENSE
    $ git commit -m "The intial commit of my project"
    
After running `git commit`, Git checksums each subdirectory and stores those tree objects in the Git repository. Now your Git repository has 5 objects: one blob for each of your 3 files, one tree that lists the contents of the directory and specifies which file names are stored as which blob, and one commit with the pointer to that root tree and all the commit metadata.

![commit-and-tree](/images/posts/git/commit-and-tree.png)

If you make some changes and commit again, the next commit stores a pointer to the commit that came immediately before it.

![commits-and-parents](/images/posts/git/commits-and-parents.png)

**A branch in Git is simply a lightweight movable pointer to one of these commits.** The default branch name is `master`. Every time you commit, it moves forward automatically.

![branch-and-history](/images/posts/git/branch-and-history.png)

### Creating a New Branch

What happens if you create a new branch? Well, doing so **creates a new pointer** for you to move aournd. Let's say you create a new branch called testing. You do this with the `git branch` command:

    $ git branch testing
    
