title: CURL Introduction
date: 2016-06-03 10:30:00 +0800
categories:
 - technologies
tags:
 - linux
 - shell
 - curl
author: Kevin
---

CURL is a powerful command in linux to access resources on internet.

<!-- more -->

## Basic Usage

The simplest format is `curl www.google.com`, and there are many useful parameters:

    --data DATA     HTTP POST data (H)
    
    --form CONTENT  Specify HTTP multipart POST data (H)
    
    -H --header LINE   Pass custom header LINE to server (H)
    
    -I, --head          Show document info only
    
    -i, --include       Include protocol headers in the output (H/F)
    
    -L, --location      Follow redirects (H)
    
    -U, --proxy-user USER[:PASSWORD]  Proxy user and password
    
    -u, --user USER[:PASSWORD]  Server user and password
    
    -v, --verbose       Make the operation more talkative
    
    --trace FILE    Write a debug trace to FILE
    
    --trace-ascii FILE  Like --trace, but without hex output
    
    
## Advanced Usage

### Download Files

    curl -o [file_name] http://hostname/resource
    
    or 
    
    curl -O http://hostname/resource
    
### Upload a File via Form

    curl --form "fileupload=@your_file.txt" http://hostname/resource
    
### GET with Header

    curl -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://hostname/resource
    
    curl -H "Accept: application/xml" -H "Content-Type: application/xml" -X GET http://hostname/resource
    
### POST with Data

    curl -X POST --data "param=value" http://hostname/resource
    
    curl -X POST -d @filename http://hostname/resource # read data from file
    
### Login with User Credentials

    curl -u username:password http://hostname/resource
    
    or
    
    curl -H "Content-Type: application/x-www-form-urlencoded" --data "username=user&password=passwd" http://hostname/resource   
    
    
    

    
