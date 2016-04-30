---
title: Validate Inputs in Shell Script
date: 2016-04-30 14:55:00 +0800
categories: [technologies]
tags: [shell,linux]
author: [Kevin]
---

When you create a shell script which requires some parameters as inputs, it is necessary to validate the parameters are recognizable by the script.

* Validate parameter to be a number

        RET=`date -d $1 "+%Y%m%d" 2>/dev/null`
        if [ $? = 0 ]; then
            echo "Input date: [$RET]"
        else
            echo "Invalid date: [$1]"
            exit -1
        fi

* Validate parameter to be a date

        RET=`expr match $1 "[0-9]*$"`
        if [ "$RET" -gt 0 ]; then
            echo "Input number: [$RET]"
        else
            echo "Invalid number: [$1]"
            exit -1
        fi
        
* Validate total parameters count

        if [ $# -lt 2 ]; then
            echo "Usage: `basename $0` {PARAM1} {PARAM2} [OPTIONAL_PARAM]
            exit -1
        fi

