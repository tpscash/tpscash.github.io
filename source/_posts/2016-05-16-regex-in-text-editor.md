title: Regex in Text Editor
date: 2016-05-16 13:40:00 +0800
categories:
 - technologies
tags:
 - regex
author: Kevin
---

A few tips of Regex which can improve your efficiency on processing texts.

The Regex used here is PCRE.

<!-- more -->

### Delete Empty Lines

Replace `^[ \t]*\r\n` with empty string

### Remove Heading Spaces of Each Line

Replace `^[ \t]+` with empty String

### Remove Trailing Spaces of Each Line

Replace `[ \t]+$` with empty string

### Add Words to The Start of Each Line

Replace `^` with words you want to add

### Add Words to The End of Each Line

Replace `$` with words you want to add

### Replace Value for a Tag in XML

For example, If you want replace `<XMLTagName>Value</XMLTagName>` with `<XMLTagName>Value_New</XMLTagName>`

Replace `(<XMLTagName>)(.*)(</XMLTagName>)` with `$1$2_New$3`
