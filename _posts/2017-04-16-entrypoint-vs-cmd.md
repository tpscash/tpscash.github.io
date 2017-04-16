---
title: ENTRYPOINT vs. CMD in Dockerfile
date: 2017-04-16 11:30:00 +0800
categories: [technologies]
tags: [docker]
author: Kevin
---

Both ENTRYPOINT and CMD allow you to specify the startup command for an image, but there are subtle differences between them. There are many times where you'll want to choose one or the other, but they can also be used together. We'll explore the similarity and difference of the two instructions in below section.

## Similarities

* Both the ENTRYPOINT and CMD instructions support two different forms: the shell form and the exec form

    - When using the shell form, the specified binary is executed with an invocation of the shell using `/bin/sh -c`

    - When the exec form is used the command will be executed without a shell. This means that normal shell processing does not happen e.g it will not do variable substitution

    - The exec form is preferred form for both of the two instructions.
    

* The ENTRYPOINT or CMD that you specify in your Dockerfile identify the default executable for your image. However, the user has the option to override either of these values at run time

    - We can override the default CMD by specifying an argument after the image name when starting the container: `docker run <image name> commands`
    
    - The default ENTRYPOINT can be similarly overridden but it requires the use of the `--entrypoint` flag

* When multiple ENTRYPOINT or CMD specified in a Dockerfile, only the last one will take effect respectively

## Differences

### ENTRYPOINT

* ENTRYPOINT command and parameters are not ignored when Docker container runs with command line parameters
 
* ENTRYPOINT should be used in scenarios where you want the container to behave exclusively as if it were the executable it's wrapping. That is, when you don't want or expect the user to override the executable you've specified

* In an exec form ENTRYPOINT, command line arguments to docker run <image> will be appended after all elements, and will override all elements specified using CMD

* The shell form prevents any CMD or run command line arguments from being used

* The disadvantage of the shell form is that your ENTRYPOINT will be started as a subcommand of /bin/sh -c, which does not pass signals. This means that the executable will not be the container’s PID 1 - and will not receive Unix signals - so your executable will not receive a SIGTERM from docker stop <container>. However, you can use `exec` before your binary in the shell form to make the executable be the container's PID 1

### CMD

* CMD instruction allows you to set a default command, which will be executed only when you run container without specifying a command

* If the user specifies arguments to docker run then they will override the default command specified in CMD

* CMD has another form: CMD \["param1","param2"] (as default parameters to ENTRYPOINT), which is used with ENTRYPOINT together 

* If CMD is used to provide default arguments for the ENTRYPOINT instruction, both the CMD and ENTRYPOINT instructions should be specified with the JSON array format

## Use ENTRYPOINT and CMD Together

Combining ENTRYPOINT and CMD allows you to specify the default executable for your image while also providing default arguments to that executable which may be overridden by the user

Both CMD and ENTRYPOINT instructions define what command gets executed when running a container. There are few rules that describe their co-operation. The table below shows what command is executed for different ENTRYPOINT / CMD combinations:

|                             | No ENTRYPOINT               | ENTRYPOINT exec_entry p1_entry  | ENTRYPOINT ["exec_entry", "p1_entry"]             |
|-----------------------------|-----------------------------|---------------------------------|---------------------------------------------------|
| No CMD                      | error, not allowed          | /bin/sh -c exec\_entry p1_entry | exec\_entry p1_entry                              |
| CMD ["exec_cmd", "p1_cmd"]  | exec\_cmd p1_cmd            | /bin/sh -c exec\_entry p1_entry | exec\_entry p1\_entry exec\_cmd p1_cmd            |
| CMD ["p1_cmd", "p2_cmd"]    | p1\_cmd p2_cmd              | /bin/sh -c exec\_entry p1_entry | exec\_entry p1\_entry p1\_cmd p2_cmd              |
| CMD exec\_cmd p1_cmd        | /bin/sh -c exec\_cmd p1_cmd | /bin/sh -c exec\_entry p1_entry | exec\_entry p1\_entry /bin/sh -c exec\_cmd p1_cmd |




## Conclusions and Hints

* The main purpose of a ENTRYPOINT is to configure a container that will run as an executable

* The main purpose of a CMD is to provide defaults for an executing container

* Prefer ENTRYPOINT to CMD when building executable Docker image and you need a command always to be executed. Additionally use CMD if you need to provide extra default arguments that could be overwritten from command line when docker container runs

* Dockerfile should specify at least one of CMD or ENTRYPOINT commands

* ENTRYPOINT should be defined when using the container as an executable

* CMD should be used as a way of defining default arguments for an ENTRYPOINT command or for executing an ad-hoc command in a container

* CMD will be overridden when running the container with alternative arguments

* If you need to write a starter script for a single executable, you can ensure that the final executable receives the Unix signals by using exec and gosu commands

* The exec form is parsed as a JSON array, which means that you must use double-quotes (“) around words not single-quotes (‘)


