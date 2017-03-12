---
title: How to Configure Network on CentOS
date: 2017-03-12 11:30:00 +0800
categories: [technology]
tags: [network,centos]
author: Kevin
---

If you don't have a UI on your CentOS system, you need to configure your network via command line. Below are the steps.


You can check your network devices by `ip` command. Run `ip addr`, you will get output like below:

    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
           valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host
           valid_lft forever preferred_lft forever
    2: eno16777736: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
        link/ether 00:0c:29:cc:c7:57 brd ff:ff:ff:ff:ff:ff
        inet 192.168.0.219/24 brd 192.168.0.255 scope global dynamic eno16777736
           valid_lft 31826sec preferred_lft 31826sec
        inet6 fe80::20c:29ff:fecc:c757/64 scope link
           valid_lft forever preferred_lft forever


Network interface config files are located in `/etc/sysconfig/network-scripts/` directory. There are segregated files in this folder for all your network devices e.g. ifcfg-en16777736


## DHCP

Make sure below lines are in the config file:

    BOOTPROTO="dhcp"
    ONBOOT="yes"

And file will look like below after changes:    

    TYPE="Ethernet"
    BOOTPROTO="dhcp"
    DEFROUTE="yes"
    PEERDNS="yes"
    PEERROUTES="yes"
    IPV4_FAILURE_FATAL="no"
    IPV6INIT="yes"
    IPV6_AUTOCONF="yes"
    IPV6_DEFROUTE="yes"
    IPV6_PEERDNS="yes"
    IPV6_PEERROUTES="yes"
    IPV6_FAILURE_FATAL="no"
    NAME="eno16777736"
    UUID="fb0f101a-6299-4179-8cd9-de054cb7b577"
    DEVICE="eno16777736"
    ONBOOT="yes"

 
 
## Static IP
 
Change BOOTPROTO to static
 
    BOOTPROTO="static"
    
And add below lines at the end of the file

    IPADDR=192.168.1.33
    NETMASK=255.255.255.0
    GATEWAY=192.168.1.1
    
The file will look like below after changes:
 
    TYPE="Ethernet"
    BOOTPROTO="static"
    DEFROUTE="yes"
    PEERDNS="yes"
    PEERROUTES="yes"
    IPV4_FAILURE_FATAL="no"
    IPV6INIT="yes"
    IPV6_AUTOCONF="yes"
    IPV6_DEFROUTE="yes"
    IPV6_PEERDNS="yes"
    IPV6_PEERROUTES="yes"
    IPV6_FAILURE_FATAL="no"
    NAME="eno16777736"
    UUID="fb0f101a-6299-4179-8cd9-de054cb7b577"
    DEVICE="eno16777736"
    ONBOOT="yes"
    IPADDR=192.168.1.33
    NETMASK=255.255.255.0
    GATEWAY=192.168.1.1
    
Default gateway can be configured in `/etc/sysconfig/network`

    NETWORKING=yes
    HOSTNAME=centos7
    GATEWAY=192.168.1.1
    
    
## DNS

Add below to `/etc/resolv.conf`

    nameserver 8.8.8.8 #Primary DNS
    nameserver 8.8.4.4 #Secondary DNS   
  
    
## Hostname

There are several ways to set up hostname

* Use hostnamectl

    `hostnamectl set-hostname centos [--pretty][--static][--transient]`
    
    The name "centos" is persisted to `/etc/hostname`
    
* For internal networking
    
    Change the IP -> hostname mapping in `/etc/hosts`
    
* Run hostname command 

    `hostname centos`
    
    Note: This is not persistent


For all steps run `systemctl restart network` to let the change take effect.