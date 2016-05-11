---
title: RESTful-API
date: 2016-05-11 21:00:00 +0800
categories: [technologies]
tags: [API]
author: [Shirui]
---

## REST（Representational State Transfer）

### Resources
"表现层"其实指的是"资源"（Resources）的"表现层"。
所谓"资源"，就是网络上的一个实体，或者说是网络上的一个具体信息。
它可以是一段文本、一张图片、一首歌曲、一种服务，总之就是一个具体的实在。你可以用一个URI（统一资源定位符）指向它，每种资源对应一个特定的URI。
要获取这个资源，访问它的URI就可以，因此URI就成了每一个资源的地址或独一无二的识别符。
应该在HTTP请求的头信息中用Accept和Content-Type字段指定，这两个字段才是对"表现层"的描述。

### Representation
互联网通信协议HTTP协议，是一个无状态协议。这意味着，所有的状态都保存在服务器端。因此，如果客户端想要操作服务器，必须通过某种手段，让服务器端发生"状态转化"（State Transfer）。
而这种转化是建立在表现层之上的，所以就是"表现层状态转化"。
客户端用到的手段，只能是HTTP协议。具体来说，就是HTTP协议里面，四个表示操作方式的动词：GET、POST、PUT、DELETE。
它们分别对应四种基本操作：GET用来获取资源，POST用来新建资源（也可以用于更新资源），PUT用来更新资源，DELETE用来删除资源。

No.|HTTP Method|	URI	Operation	 | Operation               |Type
---|-----------|---------------------|------------------------------------------
1  |GET	       |/UserService/users	 |  Get list of users	   |Read Only
---|-----------|---------------------|------------------------------------------
2  |GET	       |/UserService/users/1 |	Get User with Id 1	   |Read Only
---|-----------|---------------------|------------------------------------------
3  |PUT	       |/UserService/users/2 |	Insert User with Id 2  |Idempotent
---|-----------|---------------------|------------------------------------------
4  |POST	   |/UserService/users/2 |	Update User with Id 2  |N/A
---|-----------|---------------------|------------------------------------------
5  |DELETE	   |/UserService/users/1 |	Delete User with Id 1  |Idempotent

### Message
RESTful web services make use of HTTP protocol as a medium of communication between client and server.
A client sends a message in form of a HTTP Request and server responds in form of a HTTP Response.
This technique is termed as Messaging. These messages contain message data and metadata i.e. information about message itself.
Let's have a look on HTTP Request and HTTP Response messages for HTTP 1.1.

* HTTP Request

A HTTP Request has five major parts:
![request](/images/posts/api/http_request.jpg)
+ Verb- Indicate HTTP methods such as GET, POST, DELETE, PUT etc.
+ URI- Uniform Resource Identifier (URI) to identify the resource on server
+ HTTP Version- Indicate HTTP version, for example HTTP v1.1 .
+ Request Header- Contains metadata for the HTTP Request message as key-value pairs. For example, client ( or browser) type, format supported by client, format of message body, cache settings etc.
+ Request Body- Message content or Resource representation.


* HTTP Response
A HTTP Response has four major parts:
![response](/images/posts/api/http_response.jpg)
+ Status/Response Code - Indicate Server status for the requested resource. For example 404 means resource not found and 200 means response is ok.
+ HTTP Version - Indicate HTTP version, for example HTTP v1.1 .
+ Response Header - Contains metadata for the HTTP Response message as key-value pairs. For example, content length, content type, response date, server type etc.
+ Response Body - Response message content or Resource representation.

### Addressing

Constructing a standard URI
Following are important points to be considered while designing a URI:

* Use Plural Noun - Use plural noun to define resources. For example, we've used users to identify users as a resource.
* Avoid using spaces - Use underscore(_) or hyphen(-) when using a long resource name, for example, use authorized_users instead of authorized%20users.
* Use lowercase letters - Although URI is case-insensitive, it is good practice to keep url in lower case letters only.
* Maintain Backward Compatibility - As Web Service is a public service, a URI once made public should always be available. In case, URI gets updated, redirect the older URI to new URI using HTTP Status code, 300.
* Use HTTP Verb - Always use HTTP Verb like GET, PUT, and DELETE to do the operations on the resource. It is not good to use operations names in URI.

### Statelessness
As per REST architecture, a RESTful web service should not keep a client state on server.
This restriction is called statelessness. It is responsibility of the client to pass its context to server and then server can store this context to process client's further request.
For example, session maintained by server is identified by session identifier passed by the client.

* Advantages of Statelessness
+ Web services can treat each method request independently.
+ Web services need not to maintain client's previous interactions. It simplifies application design.
+ As HTTP is itself a statelessness protocol, RESTful Web services work seamlessly with HTTP protocol.
* Disadvantages of Statelessness
+ Web services need to get extra information in each request and then interpret to get the client's state in case client interactions are to be taken care of.

### HTTP Code:
NO.|HTTP Code                | Description
---|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------
1  |200 OK                   | shows success.
---|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------
2  |201 CREATED              | when a resource is successful created using POST or PUT request. Return link to newly created resource using location header.
---|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------
3  |204 NO CONTENT           | when response body is empty for example, a DELETE request.
---|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------
4  |304 NOT MODIFIED         | used to reduce network bandwidth usage in case of conditional GET requests. Response body should be empty. Headers should have date, location etc.
---|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------
5  |400 BAD REQUEST          | states that invalid input is provided e.g. validation error, missing data.
---|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------
6  |401 UNAUTHORIZED         | states that user is using invalid or wrong authentication token.
---|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------
7  |403 FORBIDDEN            | states that user is not having access to method being used for example, delete access without admin rights.
---|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------
8  |404 NOT FOUND            | states that method is not available.
---|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------
9  |409 CONFLICT             | states conflict situation while executing the method for example, adding duplicate entry.
---|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------
10 |500 INTERNAL SERVER ERROR| states that server has thrown some exception while executing the method.


Wiki for all status:[HTTP STATUS CODE](http://www.restapitutorial.com/httpstatuscodes.html)

