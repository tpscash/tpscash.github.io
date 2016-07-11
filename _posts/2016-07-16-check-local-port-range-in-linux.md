---
title: Check Local Port Range in Linux
date: 2016-07-16 10:30:00 +0800
categories: [technologies]
tags: [linux]
author: Kevin
---

The /proc/sys/net/ipv4/ip_local_port_range defines the local port range that is used by TCP and UDP traffic to choose the local port. You will see in the parameters of this file two numbers: The first number is the first local port allowed for TCP and UDP traffic on the server, the second is the last local port number. For high-usage systems you may change its default parameters to `32768-61000`.

The default setup for the ip_local_port_range parameters under Red Hat Linux is: "`1024 4999`"

If you are picking up a port number for you web server or JMX port etc, you'd better choose numbers that are not in the range to avoid conflicts. For example, if your configuration for the local port range is 32768-61000, then choose number from `1024-32768` and `61000-65535`.

To change the values of ip_local_port_range:

	$ echo 1024 65535 > /proc/sys/net/ipv4/ip_local_port_range
	
OR

	$ sudo sysctl -w net.ipv4.ip_local_port_range="1024 64000"
	
OR edit /etc/sysctl.conf to make changes to /proc filesystem permanently i.e. append the following line to your /etc/sysctl.conf file:

	# increase system IP port limits
	net.ipv4.ip_local_port_range = 1024 65535
	
You must restart your network for the change to take effect. The command to manually restart the network is the following:

	$ /etc/rc.d/init.d/network restart

