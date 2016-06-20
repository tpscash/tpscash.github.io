---
title: How to Split Files in Linux
date: 2016-06-24 10:30:00 +0800
categories: [technologies]
tags: [linux]
author: Kevin
---

There are many ways and many commands available to split a file in Linux - by size, by lines or by a certain pattern of the content. Here are some samples.

## SPLIT Command

### Usage of Split Command

    a suffix_length
        Use suffix_length letters to form the suffix of the file name.

    -b byte_count[k|m]
        Create smaller files byte_count bytes in length.  If ``k'' is appended to the number, the file is split into byte_count kilobyte pieces.  If ``m'' is appended to the number, the file is split into byte_count megabyte pieces.

    -l line_count
        Create smaller files n lines in length.

### Examples

#### Split File by Size

Take an image as example, its size is 28k and I want to split it into two files and specify the suffix length as 3:

    $ split -b 14k -a 3 IMG_0422.jpg
    
    $ ls
    
    IMG_0422.jpg xaaa xaab

The prefix of the splits is `x` by default, but you can designate your own prefix like below:

    $ split -b 14k -a 3 IMG_0422.jpg split_
    
    $ ls
    
    IMG_0422.jpg split_aaa split_aab
    
To put all the splits together to restore the original file:

    $ cat split_aa* > IMG_0422_copy.jpg
    
#### Split File by Lines   

Say I have a text file named text.txt which has 20 lines and I want to split it by every 10 lines:

    $ split -l 10 -a 1 text.txt split_
    
    $ ls
    
    text.txt split_a split_b
    
## AWK Command

### Split by Content

Say I have a text file named text.txt with below content:

    123 a   b
    123 c   d
    456 e   f
    456 g   h
    123 i   j
    
And I want to split the file into small pieces by the value of the first column of the file - lines with same value in first column goes into same split file:

    $ awk -F\t '{print > $1}' text.txt
    
    $ ls
    123 456 text.txt
    
    $ cat 123
    123 a   b
    123 c   d
    123 i   j
    
    $ cat 456
    456 e   f
    456 g   h
    
There are more samples of using awk command to split a file, which will be introduced by next post.
        

    