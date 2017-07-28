title: "An Introduction to Markdown"
date: 2016-04-17 15:20:00 +0800
categories:
 - technologies
tags:
 - markdown
author: Kevin
---

An introduction to Markdown (Chinese version)

<!-- more -->

# Markdown简介

---

## 什么是Markdown

**Markdown**是一种可以使用普通文本编辑器编写的**轻量级**的***标记语言***，通过类似HTML的标记语法，它可以使普通文本具有一定的格式。Markdown语法简洁明了，容易上手，而且比纯文本更强。

**Markdown**的目标是实现**易读易写**，Markdown的语法由一些精挑细选的符号组成，其作用一目了然。常用的Markdown符号不超过10种，非常易于学习。

**Markdown**语法的目标是成为一种**适用于网络的书写语言**。

由**Markdown**语法构成的普通文本可以通过**Markdown**的解释器转换为HTML文档，进而发布到网站或导出PDF文件。

Markdown的优点有：

* 专注你的文字内容而不是排版样式，安心写作。
* 兼容HTML，自动转换特殊字符。
* 轻松的导出HTML、PDF 和本身的 .md 文件。
* 纯文本内容，兼容所有的文本编辑器与字处理软件。
* 随时修改你的文章版本，不必像字处理软件生成若干文件版本导致混乱。
* 可读、直观、学习成本低。

## Markdown的语法汇总

### 区块元素 (Block Elements)

* [标题 (Headers)](#headers)
* [段落 (Paragraphs And Line Breaks)](#paragraphs)
* [列表 (Lists)](#lists)
* [区块引用 (Blockquotes)](#blockquotes)
* [代码区块 (Code Blocks)](#codeblocks)
* [分隔线 (Horizontal Rules)](#horizontalrules)

### 区段元素 (Span Elements)

* [强调 (Emphasis)](#emphasis)
* [代码 (Code)](#code)
* [链接 (Links)](#links)
* [图片 (Images)](#images)

### 其他 （Miscellaneous)

* [自动链接 (Automatic Links)](#automaticlinks)
* [反斜杠 (Backslash Escapes)](#backslash)

## Markdown的语法详解

### <a name="headers"></a>标题 (Headers)

在行首插入1到6个`#`，对应标题1到6阶，例如：

    ### This is H3
    #### This is H4
    ##### This is H5
    ###### This is H6
    
### This is H3

#### This is H4

##### This is H5

###### This is H6

### <a name="paragraphs"></a>段落和换行 （Paragraphs And Line Breaks）

一个Markdown段落是由一个或多个连续的文本组成，一个段落的前后要有一个或以上的空行。

在同一个段落内，Markdown允许段落内的强制换行，在需要换行的地方插入两个空格，然后回车。

    This is a paragraph,
    within the paragraph, link break will simply ignored.

This is a paragraph,
within the paragraph, link break will simply ignored.

    This is a paragraph,  
    within the paragraph, you can insert a line break by typing two spaces and a return.
This is a paragraph,  
within the paragraph, you can insert a line break by typing two spaces and a return.

### <a name="lists"></a>列表 (Lists)

#### 无序列表 (Unordered Lists)
无序列表使用星号、加号或减号作为列表标记：

    * Red
    * Green
    * Blue
    
    + Red
    + Green
    + Blue

    - Red
    - Green
    - Blue

* Red
* Green
* Blue

#### 有序列表 (Ordered Lists)

    1. First
    2. Second
    3. Third

1. First
2. Second
3. Third

### <a name="blockquotes"></a> 区块引用 (Blockquotes)

Markdown使用`>`建立一个区块引用，如果要把一个段落所有内容作为一个区块引用，你可以在这个段落的每一行最前面加上`>`或者在整个段落的第一行最前面加上`>`：

    > This is a blockquote
    
> This is a blockquote

区块引用可以嵌套，也可以在区块内使用其他的Markdown语法：

    > ### This is a header
    > This is the **first level** of quoting
    >
    >> This is the second level of quoting
    >
    > Back to the first level

> ### This is a header
> This is the first level of quoting
> 
> > This is the second level of quoting
> 
> Back to the first level

### <a name="codeblocks"></a> 代码区块 (Code Blocks)

在Markdown中建立代码区块只要简单的锁进4个空格或1个制表符即可：

    This is a code block
    
代码区块会一直持续到没有缩进的那一行，代码区块中，一般的Markdown语法不会被转换，像`#`会直接显示成警号而不会被转换成标题，而`&`、`<`、`>`会自动转换为HTML实体，不需要特意去转译：

    # Below is HTML syntax
    <html>
        <table></table>
    </html>
    
### <a name="horizontalrules"></a> 分隔线 (Horizontal Rules)

你可以在一行中使用3个或以上的星号、减号、底线来建立一个分隔线，行内不能有其他东西。你也可以在星号或减号中间插入空格：

    ***
    
    * * *

    ---
    
    - - -
    
    ___
    
    _ _ _

---

### <a name="emphasis"></a> 强调 (Emphasis)

Markdown使用`*`或`_`作为强调字词的符号，被一个`*`或`_`包围的字词会被转换成斜体 (Italic)，被两个`*`或`_`包围的字词显示为粗体 (Bold)：

    ＊single asterisks*
    
    _single underscores_
    
    **double asterisks**
    
    __double underscores__
    
*single asterisks*

_single underscores_

**double asterisks**

__double underscores__

注意如果你的`*`或`_`两边有空白的话，它们就只会被当成普通符号：

    There is a space after asterisks * strong *

There is a space after asterisks ** strong **


### <a name="code"></a> 代码 (Code)

如果要标记一小段行内代码，你可以用`` ` ``把它包围起来：

    ｀int a = 10`
    
`int a = 10`

如果你的代码里本身就有反引号，你可以用多个反引号来包围你的代码：

    ``This is a literal backtick (`) here``
    
``This is a literal backtick (`) here``

### <a name="links"></a> 链接 （Links）

Markdown支持两种链接语法：*行内式*和*参考式*：

    This is in line link: [Google](http://www.google.com)
    
    This is reference-style link: [Google][id]

    [id]: http://www.google.com
    
This is in line link: [Google](http://www.google.com)

This is reference-style link: [Google][id]

[id]: http://www.google.com

*隐式链接标记*功能让你可以省略指定链接标记：

    [Google][]
    
    [Google]: http://www.google.com
    
[Google][]

[Google]: http://www.google.com

链接的定义可以放在文件中的任何地方，偏好直接放在链接出现的段落后面，也可以把它放在文件的最后面，就像是注解一样。

### <a name="images"></a> 图片 （Images)

Markdown使用一种和链接很相似的语法来标记图片，在前面加一个惊叹号`!`

    ![Alt text](http://ico.ooopic.com/ajax/iconpng/?id=109229.png）
    ![Alt text][id]
    [id]: http://ico.ooopic.com/ajax/iconpng/?id=109229.png
    
![Alt text](http://ico.ooopic.com/ajax/iconpng/?id=109229.png)


### <a name="automaticlinks"></a> 自动链接 （Automatic Links）

Markdown支持以比较简短的自动链接的方式来处理网址和电子邮件地址，只要尖括号包起来Markdown就会自动把它转成链接：

    <http://tpscash.github.io>
    <tpscash@outlook.com>
    
<http://tpscash.github.io>

<tpscash@outlook.com>

### <a name="backslash"></a> 反斜杠 （Backslash Escapes）

Markdown可以利用`\`来插入一些在Markdown语法中有特殊意义的符号，例如你想在一些文字前后加上星号，而不是想加入强调效果：

    \*literal asterisks\*
    
\*literal asterisks\*

Markdown支持以下这些符号前面加上反斜杠来插入为普通符号：

    \  反斜杠
    `  反引号
    *  星号
    _  底线
    {} 大括号
    [] 方括号
    () 小括号
    #  井号
    +  加号
    -  减号
    .  英文句点
    !  惊叹号


## GitHub Flavored Markdown

### 语法高亮 (Syntax Highlighting)

使用以下语法来高亮代码：

    ```java
    String str = new String("str");
    ```

```java
String str = new String("str");
```

### 任务列表 (Task Lists)

    - [x] This is a complete item
    - [ ] This is a incomplete item

* [x] This is a complete item
* [ ] This is a incomplete item


### 表格 (Tables)

col 1 | col 2 | col 3
------|-------|------
a     |b      |c

### 横划线 (Strikethrough)

    ~~This is a strikthrough~~
    
~~This is a strikethrough~~

## 支持Markdown的编辑器

### 在线编辑器

* [简书](http://www.jianshu.com/)
* [Dillinger](http://dillinger.io/)

### 本地编辑器

* [MacDown for OSX](http://macdown.uranusjr.com/)
* [MarkDownPad for Windows](https://markdownpad.com)
* MarkdownX for Andriod
* ByWord for IOS
