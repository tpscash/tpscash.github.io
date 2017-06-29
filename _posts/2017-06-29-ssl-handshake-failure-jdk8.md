---
title: SSL Handshake Failure after Upgrading to JDK 8
date: 2017-06-29 23:30:00 +0800
categories: [technologies]
tags: [jdk,ssl]
author: Kevin
---

This post is for tracking the process to solve a SSL issue after JDK 8 upgrade.


## Background

We have a component which is using PKCS12 key store as the SSL identify when connecting to an external EMS instance, code like this:

```
<bean name="jndiTemplate" class="org.springframework.jndi.JndiTemplate">
   <property name="environment">
       <props>
           <prop key="java.naming.factory.initial">com.tibco.tibjms.naming.TibjmsInitialContextFactory</prop>
           <prop key="java.naming.provider.url">${ems_ssl_url}</prop>
           <prop key="com.tibco.tibjms.naming.ssl_identity">${path_to_the_p12_file}</prop>
           <prop key="com.tibco.tibjms.naming.ssl_password">${ssl_password}</prop>
           <prop key="com.tibco.tibjms.naming.security_protocol">ssl</prop>
           <!--<prop key="com.tibco.tibjms.naming.ssl_cipher_suites">RC4-MD5</prop>-->
           <prop key="com.tibco.tibjms.naming.ssl_enable_verify_host">false</prop>
           <prop key="com.tibco.tibjms.naming.ssl_enable_verify_hostname">false</prop>
      </props>
   </property>
</bean>
```

This EMS connection stopped working after we upgraded to JDK 8, error in the log:

```
javax.jms.JMSSecurityException: Failed to connect to any server at: ssl://xxxx [Error: Failed to connect via SSL to [ssl://xxxx]: Received fatal alert: handshake_failure: url that returned this exception = SSL://xxxx ]
```

## Solving the Issue

### Get More Intel

It was handshake failure while building the SSL connection, so I enabled debugging on the SSL connection by -Djavax.net.debug=ssl and it gave me:
 
\*** ClientHello, TLSv1

RandomCookie:  GMT: 1498746256 bytes = { 236, 170, 65, 179, 185, 201, 110, 99, 17, 112, 13, 59, 2, 67, 217, 159, 2, 1, 83, 70, 37, 196, 220, 130, 16, 124, 243, 89 }

Session ID:  {}

Cipher Suites: [TLS_RSA_WITH_AES_128_CBC_SHA, SSL_RSA_WITH_3DES_EDE_CBC_SHA, SSL_DHE_DSS_WITH_3DES_EDE_CBC_SHA, SSL_RSA_WITH_DES_CBC_SHA, SSL_DHE_DSS_WITH_DES_CBC_SHA, SSL_DHE_DSS_EXPORT_WITH_DES40_CBC_SHA, TLS_DHE_RSA_WITH_AES_128_CBC_SHA, TLS_DHE_DSS_WITH_AES_128_CBC_SHA, SSL_RSA_WITH_NULL_MD5, SSL_RSA_WITH_NULL_SHA]

Compression Methods:  { 0 }

Extension server_name, server_name: [type=host_name (0), value=xxxx]

Extension renegotiation_info, renegotiated_connection: <empty>

\***

main, WRITE: TLSv1 Handshake, length = 105

main, READ: TLSv1 Alert, length = 2

main, RECV TLSv1.2 ALERT:  fatal, handshake_failure

### Possible Reasons

The handshake failure could have occurred due to various reasons:

* Incompatible cipher suites in use by the client and the server. This would require the client to use (or enable) a cipher suite that is supported by the server.

* Incompatible versions of SSL in use (the server might accept only TLS v1, while the client is capable of only using SSL v3). Again, the client might have to ensure that it uses a compatible version of the SSL/TLS protocol.

* Incomplete trust path for the server certificate; the server's certificate is probably not trusted by the client. This would usually result in a more verbose error, but it is quite possible. Usually the fix is to import the server's CA certificate into the client's trust store.
 
* The certificate is issued for a different domain. Again, this would have resulted in a more verbose message, but I'll state the fix here in case this is the cause. The resolution in this case would be get the server (it does not appear to be yours) to use the correct certificate

### Suspect and Experiment

I doubt this is very likely the cipher issue as I encountered before, so I tested the remote EMS server by:
 
openssl s_client -tls1 -connect xxxx
 
The test returned successfully but I saw below from the output:
 
New, TLSv1/SSLv3, Cipher is RC4-MD5
Server public key is 2048 bit
Secure Renegotiation IS supported
Compression: NONE
Expansion: NONE
SSL-Session:
    Protocol  : TLSv1
    Cipher    : RC4-MD5
    
### Research and Confirm

The EMS server is using RC4 ciphers, after google it, no surprise that RC4 had been disabled since JDK 8u51 update:

[Java™ SE Development Kit 8, Update 51 Release Notes](http://www.oracle.com/technetwork/java/javase/8u51-relnotes-2587590.html) 

```
RC4 is now considered as a weak cipher. Servers should not select RC4 unless there is no other stronger candidate in the client requested cipher suites. A new security property, jdk.tls.legacyAlgorithms, is added to define the legacy algorithms in Oracle JSSE implementation. RC4 related algorithms are added to the legacy algorithms list.
 
 
JDK-8043201 (not public)
 
 
Area: security-libs/javax.net.ssl
Synopsis: Prohibit RC4 cipher suites
 
 
RC4 is now considered as a compromised cipher. RC4 cipher suites have been removed from both client and server default enabled cipher suite list in Oracle JSSE implementation. These cipher suites can still be enabled by SSLEngine.setEnabledCipherSuites() and SSLSocket.setEnabledCipherSuites() methods
```

### Solution

It is possible that to enable RC4 again by removing RC4 from JDK disabled algorithms list defined in $JAVA_HOME/jre/lib/security/java.security file or pragmatically enabling them using 

Security.setProperty("jdk.tls.disabledAlgorithms", "" /\*disabledAlgorithms*/ );
 
But by Security.setProperty(), it is not reliable because the fields which hold disabled algorithms are static and final, So if that class gets loaded first you don't have control over it, you could alternatively try by creating a properties file like this
 
 
\## override it to remove RC4, in disabledcipher.properties

jdk.tls.disabledAlgorithms=DHE
 
 
and in your JVM, you could refer it as system property like this
 
 
java -Djava.security.properties=[path_to_the_disabledcipher.properties_file]
 
However better solution would be to update the EMS server configuration to upgrade to stronger Ciphers, but since the EMS instance is not owned by us, so we have to go hack it this way.



