---
title: Create Restricted User for SSH Tunneling
date: 2016-04-27 22:40:00 +0800
categories: [technologies]
tags: [ssh,linux]
author: [Kevin]
---

For safety purpose, you can create a user without login for SSH tunneling. Such user won't have access to login the system and don't have a home folder either. The only thing this user can do is changing the login password.
 
Commands to create a restricted user for SSH tunneling:

    #Create user
    useradd -M -s /sbin/nologin -n username
    
    #Modify password
    passwd username
    
    #Remove the user
    userdel -r username