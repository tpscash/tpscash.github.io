title: How to Install Java 8 on CentOS
date: 2016-12-10 11:30:00 +0800
categories:
 - technologies
tags:
 - jdk
 - centos
author: Kevin
---

A walking through to install JDK on CentOS.

<!-- more -->

## Download JDK

You need to agree OTN license terms before downloading the package. So if you are using `wget` or `curl`, you need to add more parameters to avoid only downloading a webpage instead of the real package.

### wget

`wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u112-linux-x64.rpm`

### curl

`curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u112-linux-x64.rpm > jdk-8u112-linux-x64.rpm`

* -j -> junk cookies
* -k -> ignore certificates
* -L -> follow redirects
* -H -> headers (--header)


## Install JDK RPM

You can install the RPM manually or use yum:

`yum localinstall jdk-8u112-linux-x64.rpm -y`

After it is completed, you will see below in folder /usr/java:


    jdk1.8.0_112
    
    latest -> /usr/java/jdk1.8.0_112
    
    default -> /usr/java/latest



## Install Java with Alternatives

To avoid configuring Java again when you upgrade to a newer Java version, you can utilize above soft link to hide the version from configuration.

### Check current alternatives environment

`alternatives --config java`




    There is 1 program which provide 'java'.

      Selection    Command
    -----------------------------------------------
    *+ 1           /opt/jdk1.7.0_71/bin/java
    
    Enter to keep the current selection[+], or type selection number: ^C


### Install new Java version    
To not break existing environment we need to install Java using below alternative command:

`alternatives --install /usr/bin/java java /usr/java/default/bin/java 2`

Then check alternatives environment again and choose new installed Java version

`alternatives --config java`




    There are 2 programs which provide 'java'.

      Selection    Command
    -----------------------------------------------
    *  1           /opt/jdk1.7.0_71/bin/java
     + 2           /usr/java/default/bin/java
    
    Enter to keep the current selection[+], or type selection number: 2  


At this point Java 8 has been successfully installed on your system. Let's set up javac/jar as well:

    alternatives --install /usr/bin/jar jar /usr/java/default/bin/jar 2
    alternatives --install /usr/bin/javac javac /usr/java/default/bin/javac 2
    alternatives --set jar /usr/java/default/bin/jar
    alternatives --set javac /usr/java/default/bin/javac

## Check Installed Java Version

`java --version`


    java version "1.8.0_112"
    Java(TM) SE Runtime Environment (build 1.8.0_112-b15)
    Java HotSpot(TM) 64-Bit Server VM (build 25.112-b15, mixed mode)
    
## Configure Environment Variables

    export JAVA_HOME=/usr/java/default
    export JRE_HOME=/usr/java/default/jre
    export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin    
