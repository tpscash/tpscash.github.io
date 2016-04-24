---
title: Git Basics
date: 2016-04-21 22:25:00 +0800
categories: [technologies]
tags: [git]
author: [Kevin]
---

From this article you can get some basic usage of Git.

## Getting a Git Repository

### Initialize a Repository and Import a Project to Git

    $ cd [path_of_your_project]
    $ git init
    $ git add -all
    $ git commit -m "Initial commit"
    
### Cloning an Existing Repository

    git clone [repository_url] [local_dir_name]
    
## Recording Changes to the Repository

As you edit files, the states of your files will change like below:

![lifecycle.png](/images/posts/git/lifecycle.png)

### Checking the Status of Your Files

    $ git status
    On branch master
    Your branch is up-to-date with 'origin/master'.
    nothing to commit, working directory clean
    
### Add a New File to Your Project

    $ echo 'READ ME' > README.md
    $ git status
    On branch master
    Your branch is up-to-date with 'origin/master'.
    Untracked files:
        (use "git add <file>..." to include in what will be committed)
        
            README.md
            
    nothing added to commit but untracked files present (use "git add" to track)
    
### Tracking New Files

    $ git add README.md
    $ git status
    On branch master
    Your branch is up-to-date with 'origin/master'.
    Changes to be committed:
        (use "git reset HEAD <file>..." to unstage)
        
        new file:   README.md

### Staging Modified Files

Let's say you modified a file alreay tracked which is named FAQ.md

    $ git status
    On branch master
    Your branch is up-to-date with 'origin/master'.
    Changes to be committed:
        (use "git reset HEAD <file>..." to unstage)

        new file:   README.md

    Changes not staged for commit:
        (use "git add <file>..." to update what will be committed)
        (use "git checkout -- <file>..." to discard changes in working directory)

                modified:   FAQ.md
    $ git add FAQ.md
    $ git status
    On branch master
    Your branch is up-to-date with 'origin/master'.
    Changes to be committed:
        (use "git reset HEAD <file>..." to unstage)
    
            new file:   README.md
            modified:   FAQ.md
             
If you modified FAQ.md again, FAQ would be listed as both staged and unstaged:

    $ git status
    On branch master
    Your branch is up-to-date with 'origin/master'.
    Changes to be committed:
        (use "git reset HEAD <file>..." to unstage)
    
            new file:   README.md
            modified:   FAQ.md   
    Changes not staged for commit:
        (use "git add <file>..." to update what will be committed)
        (use "git checkout -- <file>..." to discard changes in working directory)
   
        modified:   FAQ.md
        
Use `git diff` to compare what is in your working directory with what is in your staging area. The result tells you the changes you've made that you haven't staged.

If you want to see what you've staged that will go into your next commit, you can use `git diff --staged`. This command compares you staged changes to your last commit.

### Committing Your Changes

    $ git commit -m "Some brief note of the change"
    
You can add `-a` option to `git commit` command makes Git automatically stage every file that is already tracked before doing the commit, letting you skip the `git add` part.

### Removing Files

`git rm` will remove a file from both your working directory and staging area. If you want to keep the file in your working directory but remove it from you staging area, use `git rm --cached`

### Moving Files

If you want to rename a file use `git mv [file_from] [file_to]`. It is equivalent to running something like:

    $ mv [file_from] [file_to]
    $ git rm [file_from]
    $ git add [file_to]
    
## Viewing the Commit History

View the commit history using `git log` in your project.

One helpful option is `-p`, which shows the difference introduced in each commit. You can also use `-2`, which limits the output to only the last two entries. 
    
        $git log -p -2
        
If you want to see some abbreviated stats for each commit, you can use `--stat` option. Another really useful option is `--pretty`. If you are looking at a lot of commits, use `oneline` option prints each commit on a single line. Also `format` option allows you to specify your own log output format.

    $ git log --stat
    $ git log --pretty=oneline
    $ git log --pretty=format:"%h - %an, %ar : %s"
    
### Limiting Log Output

Limit log by time-limiting options such a `--since` and `--until`, e.g.

    $ git log --since=2.weeks
    
You can also filter the commits by search criteria. 

The `--author` option allows you to filter on a specific author .

And the `--grep` option lets you search for keywords in the commit messages. 

Also you can add more than one options but you have to add --all-match or the command will match commits with either. Another really helpful filter is the `-S` option which takes a string and only shows the commits that introduced a change to the code that added or removed that string. An example with multiple options:

    $ git log --pretty="%h - %s" --author=gitster --since="2008-10-01" --before="2008-11-01" --no-merges -- t/

## Undoing Changes

### Amend a commit

You can run commit with `--amend` option

    $ git commit -m "some unwanted commit"
    $ git add some_fix
    $ git commit --amend
    
    
### Unstaging a Staged File

    $ git add -all
    $ git reset HEAD some_unwanted_file
    
### Unmodifying a Modified File

    $ git checkout -- some_file_you_modified
    
## Working with Remotes

### Showing Your Remotes

    $ git remote
    $ git remote -v
    
### Adding Remote Repositories

    $git remote add [url_of_remote_respository]
    
### Fetching and Pulling from Your Remotes

    $ git fetch [remote-name]
    $ git pull

### Pushing to Your Remotes

Use `git push [remote-name] [branch-name]` to push your commits to upstream, the command means you want to push your master branch to your origin server

    $ git push origin master
    
### Inspecting a Remote

If you want to see more information about a particular remote, you can use the `git remote show [remote-name]` command.

    $ git remote show origin

### Removing and Renaming Remotes

    $ git remote rename [name_from] [name_to]
    $ git remote rm [remote_name]
    
## Tagging

### Listing Your Tags

    $ git tag
    
You can also search for tags with a particular pattern:

    $ git tag -l "v1.8.5*"
    
### Creating Tags

Git uses two main types of tags: lightweight and annotated. 

A lightweight tag is very much like a branch that doesn't change - it's just a pointer to a specific commit.

A annotated tag is stored as full objects in the Git database. It is checksummed; contains the tagger name, email, and date; has a tagging message; and can be signed and verified with GNU Privacy Guard (GPG). **It is generally recommended that you create annotated tags so you can have all these information**; but if you want a temporary tag or for some reason don't want to keep the other information, lightweight tags are available too.

### Annotated Tags

    $ git tag -a v1.4 -m "my version 1.4"
    $ git show v1.4
 
### Lightweight Tags

    $ git tag v1.4
    $ git show v1.4

### Sharing Tags

By default, the `git push` command doesn't transfer tags to remote servers. You will have to explicitly push tags to a shared server after you have created them. 

    $ git push origin v1.4
    $ git push origin --tags
    
### Checking out Tags

    $ git checkout -b [branch_name] [tag_name]
    
## Git Aliases

    $ git config --global alias.co checkout
    $ git config --global alias.br branch
    $ git config --global alias.ci commit
    $ git config --global alias.st status
    $ git config --global alias.unstage 'reset HEAD --'
    $ git config --global alias.last 'log -l HEAD'