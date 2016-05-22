---
title: Regex - Delete Lines Does not Contain Certain Keyword
date: 2016-05-04 17:15:00 +0800
categories: [technologies]
tags: [regex]
author: Kevin
---


The fact that regex doesn't support inverse matching is not entirely true. You can mimic this behavior by using negative look-arounds:

    ^((?!gold).)*$

The regex above will match any string, or line without a line break, not containing the (sub) string `"gold"`. As mentioned, this is not something regex is "good" at (or should do), but still, it is possible.

And if you need to match line break chars as well, use the DOT-ALL modifier (the trailing s in the following pattern):

    /^((?!gold).)*$/s

or use it inline:

    /(?s)^((?!gold).)*$/

(where the /.../ are the regex delimiters, i.e. not part of the pattern)

If the DOT-ALL modifier is not available, you can mimic the same behavior with the character class [\s\S]:

    /^((?!gold)[\s\S])*$/

### Explanation

A string is just a list of n characters. Before and after each character, there's an empty string. So a list of n characters will have n+1 empty strings. Consider the string "ABgoldCD":

        +--+---+--+---+--+---+--+---+--+---+--+---+--+---+--+---+--+
    S = |e1| A |e2| B |e3| g |e4| o |e5| l |e6| d |e7| C |e8| D |e9|
        +--+---+--+---+--+---+--+---+--+---+--+---+--+---+--+---+--+

    index    0      1      2      3      4      5      6      7

where the e's are the empty strings. The regex (?!gold). looks ahead to see if there's no substring `"gold"` to be seen, and if that is the case (so something else is seen), then the . (dot) will match any character except a line break. Look-arounds are also called zero-width-assertions because they don't consume any characters. They only assert/validate something.

So, in my example, every empty string is first validated to see if there's no `"gold"` up ahead, before a character is consumed by the . (dot). The regex (?!gold). will do that only once, so it is wrapped in a group, and repeated zero or more times: `((?!gold).)*.` Finally, the start- and end-of-input are anchored to make sure the entire input is consumed: `^((?!gold).)*$`

As you can see, the input "ABgoldCD" will fail because on e3, the regex (?!gold) fails (there is `"gold"` up ahead!).
