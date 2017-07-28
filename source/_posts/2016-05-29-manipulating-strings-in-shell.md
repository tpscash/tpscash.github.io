title: Manipulating Strings in Shell
date: 2016-05-29 21:20:00 +0800
categories:
 - technologies
tags:
 - linux
 - shell
 - string
author: Kevin
---

Linux bash supports a number of string manipulation operations:

* [String Length](#string_length)
* [Substring Extraction](#substring_extraction)
* [Substring Removal](#substring_removal)
* [Substring Replacement](#substring_replacement)

<!-- more -->

## <a name="string_length"></a>String Length

### Get length of a string:

`${\#string}`

Example:

    binary="java"
    echo ${#binary}
    
Output is: `4`

### Get length of a matching substring at beginning of a string:

`expr match "$string" '$substring'`

 or
  
 `expr "$string" : '$substring'`

$substring is a regular expression

Example:

    string=abcABC123ABCabc
    
    echo `expr match "$string" 'abc[A-Z]*.2'`
    
    echo `expr "$string" : 'abc[A-Z]*.2'`
    
Output is: `8`

### Get index of a substring

Index is the numeric position in $string of first character in $substring that matches

Example:

    string=abcABC123ABCabc
    
    echo `expr index "$string" C12`
    
    echo `expr index "$string" 1c` # 'c' matches before '1'
    
Outputs are `6` and `3`

## <a name="substring_extraction"></a>Substring Extraction

### Extract substring from $string at $position

`${string:position}`

Example:

    string=abcABC123ABCabc
    
    echo ${string:7}
    
    echo ${string: -4} or echo ${string:(-4)}
    
Outputs are `23ABCabc` and `Cabc`

### Extract $length characters of substring from $string at $position

Example:

    string=abcABC123ABCabc
    
    echo ${string:7:3}
    
Output is `23A`

## <a name="substring_removal"></a>Substring Removal

### Delete shortest match of $substring from front of $string

`${string#substring}`

### Delete longtest match of $substring from front of $string

`${string##substring}`

Example:

    string=abcABC123ABCabc
    
    echo ${string#a*C}
    
    echo ${string##a*C}

Outputs are `123ABCabc` and `abc`

### Delete shortest match of $substring from back of $string

`${string%substring}`

### Delete longest match of $substring from back of $string

`${string%%substring}`

Example:

    string=abcABC123ABCabc
    
    echo ${string%b*c}
    
    echo ${string%%b*c}
    
Outputs are `abcABC123ABCa` and `a`

## <a name="substring_replacement"></a>Substring Replacement

### Replace first match of $substring with $replacement

`${string/substring/replacement}`

### Replace all matches of $substring with $replacement

`${string//substring/replacement}`

Examples:

    string=abcABC123ABCabc
    
    echo ${string/abc/xyz}
    
    echo ${string//abc/xyz}
    
Outputs are `xyzABC123ABCabc` and `xyzABC123ABCxyz`

### If $substring matches front end of $string, substitute $replacement for $substring

`${string/#substring/replacement}`

### If $substring matches back end of $string, substitute $replacement for $substring

`${string/%substring/replacement}`

Example:

    string=abcABC123ABCabc
    
    echo ${string/#abc/XYZ}
    
    echo ${string/%abc/XYZ}
    
Outputs are `XYZABC123ABCabc` and `abcABC123ABCXYZ`
