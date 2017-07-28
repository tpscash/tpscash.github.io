title: Build SS Server on a VPS
date: 2016-09-20 01:00:00 +0800
categories:
 - technologies
tags:
 - centos
 - ss
author: Kevin
---

The SS proxy is proven to be faster and more stable than SSH. Here is an introduction on how to build SS server on a VPS.

<!-- more -->

## Install SS server:

### Debian/Ubuntu:

    apt-get install python-pip
    
    pip install shadowsocks
    
### CentOS:

    yum install python-setuptools && easy_install pip
    
    pip install shadowsocks
    
## Write a Configuration File for SS

### Sample:

    { 
      "server": "IP of VPS", 
      "server_port": 3333, /* Port of SS server, not the same as SSH port, better to be greater than 1024 */
      "local_port": 1080, 
      "password": "mypassword",
      "timeout": 300, 
      "method": "aes-256-cfb" /* encryption method, recommend to use aes-256-cfb */
    }

### Sample - Multiple SS account

    {  
      "server": "IP of VPS",
      "port_password": {  
        "1080": "password1",
        "1081": "password2"
      },
      "timeout": 300,
      "method": "aes-256-cfb", /* Set to true to reduce latency if your Linx kernal is 3.7+ */
      "fast_open": false,
      "workers": 1,
      "_comment": {  
        "1080": "myself",
        "1081": "guest"
      }
    }

    
## Start/Stop SS server

### Start/Stop with Configuration File

    ssserver -c /etc/shadowsocks.json -d start
    
    ssserver -c /etc/shadowsocks.json -d stop
    
### Start/Stop with Configuration in Command Line

    ssserver -p 1080 -k mypassword -m aes-256-cfb --user nobody -d start
    
    ssserver -d stop

### Log File

    /var/log/shadowsocks.log   
    
  
