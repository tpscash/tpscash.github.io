---
title: SED - Substitute Multiple Lines
date: 2016-09-16 16:00:00 +0800
categories: [technologies]
tags: [linux,sed]
author: Kevin
---

Ususally we use SED for stream processing which process text line by line (SED reads line by line, removes any trailing new lines, places a line in a pattern space buffer, process as per the given commands and prints the pattern space.) Sometimes we need to substitute multiple lines. SED can handle such case as well.

For example, if we want to replace some text like below with a single word "SINGLEWORD":

	START
	Line 1
	Line 2
	Line 3
	END

We can use below command to achieve the purpose:

	sed -i ':begin; N; $! b begin; s~START.*END~SINGLEWORD~g' filename

* `:begin` create a label 'begin'

* `N` append the next line to the pattern space

* `$!` if it is not the last line, branch to label begin

* `s` substitute

Commands to manipulate pattern space:

	:  # label
	=  # line_number
	a  # append_text_to_stdout_after_flush
	b  # branch_unconditional             
	c  # range_change                     
	d  # pattern_delete_top/cycle          
	D  # pattern_ltrunc(line+nl)_top/cycle 
	g  # pattern=hold                      
	G  # pattern+=nl+hold                  
	h  # hold=pattern                      
	H  # hold+=nl+pattern                  
	i  # insert_text_to_stdout_now         
	l  # pattern_list                       
	n  # pattern_flush=nextline_continue   
	N  # pattern+=nl+nextline              
	p  # pattern_print                     
	P  # pattern_first_line_print          
	q  # flush_quit                        
	r  # append_file_to_stdout_after_flush 
	s  # substitute                                          
	t  # branch_on_substitute              
	w  # append_pattern_to_file_now         
	x  # swap_pattern_and_hold             
	y  # transform_chars

If we don't want to read the whole file into pattern space when the file you are operating on is very large, we can limit the lines read into pattern space by below:

	sed -i ':begin /START/, /END/ { /END/! { $! { N; b begin;} }; s~START.*END~SINGLEWORD~g};' filename


