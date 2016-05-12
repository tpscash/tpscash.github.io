---
title: RESTful-API
date: 2016-05-11 21:00:00 +0800
categories: [technologies]
tags: [api,restful]
author: [Shirui]
---

Here is an article to introduce what REST is all about.

## REST(Representational State Transfer)

### Resources

"表现层"其实指的是"资源"（Resources）的"表现层"。 所谓"资源"，就是网络上的一个实体，或者说是网络上的一个具体信息。
它可以是一段文本、一张图片、一首歌曲、一种服务，总之就是一个具体的实在。你可以用一个URI（统一资源定位符）指向它，每种资源对应一个特定的URI。
要获取这个资源，访问它的URI就可以，因此URI就成了每一个资源的地址或独一无二的识别符。
应该在HTTP请求的头信息中用Accept和Content-Type字段指定，这两个字段才是对"表现层"的描述。

### Representation

互联网通信协议HTTP协议，是一个无状态协议。这意味着，所有的状态都保存在服务器端。因此，如果客户端想要操作服务器，必须通过某种手段，让服务器端发生"状态转化" (State Transfer)。
而这种转化是建立在表现层之上的，所以就是"表现层状态转化"。
客户端用到的手段，只能是HTTP协议。具体来说，就是HTTP协议里面，四个表示操作方式的动词：GET、POST、PUT、DELETE。
它们分别对应四种基本操作：GET用来获取资源，POST用来新建资源（也可以用于更新资源），PUT用来更新资源，DELETE用来删除资源。

| No. | HTTP Method | URI Operation        | Operation             | Type       |
|---- |-------------|----------------------|-----------------------|------------|
| 1   | GET	        | /UserService/users   | Get list of users	   | Read Only  |
| 2   | GET	        | /UserService/users/1 | Get User with Id 1	   | Read Only  |
| 3   | PUT	        | /UserService/users/2 | Upate User with Id 2  | Idempotent |
| 3   | PATCH	    | /UserService/users/2 | Upate partial attribute of User with Id 2  | Idempotent |
| 4   | POST	    | /UserService/users/2 | Insert User with Id 2 | N/A        |
| 5   | DELETE	    | /UserService/users/1 | Delete User with Id 1 | Idempotent |

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
* Use lower-case letters - Although URI is case-insensitive, it is good practice to keep url in lower case letters only.
* Maintain Backward Compatibility - As Web Service is a public service, a URI once made public should always be available. In case, URI gets updated, redirect the older URI to new URI using HTTP Status code, 300.
* Use HTTP Verb - Always use HTTP Verb like GET, PUT, and DELETE to do the operations on the resource. It is not good to use operations names in URI.

### Statelessness

As per REST architecture, a RESTful web service should not keep a client state on server.
This restriction is called statelessness. It is responsibility of the client to pass its context to server and then server can store this context to process client's further request.
For example, session maintained by server is identified by session identifier passed by the client.

* Advantages of Statelessness
* Web services can treat each method request independently.
* Web services need not to maintain client's previous interactions. It simplifies application design.
* As HTTP is itself a statelessness protocol, RESTful Web services work seamlessly with HTTP protocol.
* Disadvantages of Statelessness
* Web services need to get extra information in each request and then interpret to get the client's state in case client interactions are to be taken care of.

### HTTP Code:

| NO. | HTTP Code                 | Description                                                                                                                                          |
|-----|---------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1   | 200 OK                    | shows success.                                                                                                                                       |
| 2   | 201 CREATED               | when a resource is successful created using POST or PUT request. Return link to newly created resource using location header.                        |
| 3   | 204 NO CONTENT            | when response body is empty for example, a DELETE request.                                                                                           |
| 4   | 304 NOT MODIFIED          | used to reduce network bandwidth usage in case of conditional GET requests. Response body should be empty. Headers should have date, location etc.   |
| 5   | 400 BAD REQUEST           | states that invalid input is provided e.g. validation error, missing data.                                                                           |
| 6   | 401 UNAUTHORIZED          | states that user is using invalid or wrong authentication token.                                                                                     |
| 7   | 403 FORBIDDEN             | states that user is not having access to method being used for example, delete access without admin rights.                                          |
| 8   | 404 NOT FOUND             | states that method is not available.                                                                                                                 |
| 9   | 409 CONFLICT              | states conflict situation while executing the method for example, adding duplicate entry.                                                            |
| 10  | 500 INTERNAL SERVER ERROR | states that server has thrown some exception while executing the method.                                                                             |

### Cache:

Caching refers to storing server response in client itself so that a client needs not to make server request for same resource again and again.
A server response should have information about how a caching is to be done so that a client caches response for a period of time or never caches the server response.

Following are the headers which a server response can have in order to configure a client's caching:

| NO. | Header           | Description                                                                     |
|-----|------------------|---------------------------------------------------------------------------------|
| 1   | Date             | Date and Time of the resource when it was created.                              |
| 2   | Last Modified    | Date and Time of the resource when it was last modified.                        |
| 3   | Cache-Control    | Primary header to control caching.                                              |
| 4   | Expires          | Expiration date and time of caching.                                            |
| 5   | Age              | Duration in seconds from when resource was fetched from the server.             |

当资源第一次被访问的时候，HTTP头部如下:

    (Request-Line)  GET /a.html HTTP/1.1
    Host    127.0.0.1
    User-Agent  Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.9.0.15) Gecko/2009102815 Ubuntu/9.04 (jaunty) Firefox/3.0.15
    Accept              text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
    Accept-Language     zh-cn,zh;q=0.5
    Accept-Encoding     gzip,deflate
    Accept-Charset      gb2312,utf-8;q=0.7,;q=0.7
    Keep-Alive          300
    Connection          keep-alive

HTTP返回头部如下

    (Status-Line)       HTTP/1.1 200 OK
    Date                Thu, 26 Nov 2009 13:50:54 GMT
    Server              Apache/2.2.11 (Unix) PHP/5.2.9
    Last-Modified       Thu, 26 Nov 2009 13:50:19 GMT
    Etag                “8fb8b-14-4794674acdcc0″
    Accept-Ranges       bytes
    Content-Length      20
    Keep-Alive          timeout=5, max=100
    Connection          Keep-Alive
    Content-Type        text/html

当资源第一次被访问的时候，http返回200的状态码，并在头部携带上当前资源的一些描述信息，如
*Last-Modified      // 指示最后修改的时间
*Etag                // 指示资源的状态唯一标识
*Expires             // 指示资源在浏览器缓存中的过期时间

接着浏览器会将文件缓存到Cache目录下，并同时保存文件的上述信息
当第二次请求该文件时，浏览器会先检查Cache目录下是否含有该文件，
如果有，并且还没到Expires设置的时间，即文件还没有过期，那么此时浏览器将直接从Cache目录中读取文件，而不再发送请求
如果文件此时已经过期，则浏览器会发送一次HTTP请求到WebServer，并在头部携带上当前文件的如下信息
If-Modified-Since   Thu, 26 Nov 2009 13:50:19 GMT
If-None-Match       ”8fb8b-14-4794674acdcc0″
即把上一次修改的时间，以及上一次请求返回的Etag值一起发送给服务器。
服务器在接收到这个请求的时候，先解析Header里头的信息，然后校验该头部信息。
如果该文件从上次时间到现在都没有过修改或者Etag信息没有变化，则服务端将直接返回一个304的状态，而不再返回文件资源，状态头部如下

    (Status-Line)       HTTP/1.1 304 Not Modified
    Date                Thu, 26 Nov 2009 14:09:07 GMT
    Server              Apache/2.2.11 (Unix) PHP/5.2.9
    Connection          Keep-Alive
    Keep-Alive          timeout=5, max=100
    Etag                “8fb8b-14-4794674acdcc0″

### Security

As RESTful web services work with HTTP URLs Paths so it is very important to safeguard a RESTful web service in the same manner as a website is be secured. Following are the best practices to be followed while designing a RESTful web service.

* Validation - Validate all inputs on the server. Protect your server against SQL or NoSQL injection attacks.
* Session based authentication - Use session based authentication to authenticate a user whenever a request is made to a Web Service method.
* No sensitive data in URL - Never use username, password or session token in URL , these values should be passed to Web Service via POST method.
* Restriction on Method execution - Allow restricted use of methods like GET, POST, DELETE. GET method should not be able to delete data.
* Validate Malformed XML/JSON - Check for well formed input passed to a web service method.
* Throw generic Error Messages - A web service method should use HTTP error messages like 403 to show access forbidden etc.

oauth for API authentication

OAuth 2.0的运行流程如下图

![request](/images/posts/api/oauth_flow.jpg)

（A）用户打开客户端以后，客户端要求用户给予授权。
（B）用户同意给予客户端授权。
（C）客户端使用上一步获得的授权，向认证服务器申请令牌。
（D）认证服务器对客户端进行认证以后，确认无误，同意发放令牌。
（E）客户端使用令牌，向资源服务器申请获取资源。
（F）资源服务器确认令牌无误，同意向客户端开放资源。

客户端必须得到用户的授权（authorization grant），才能获得令牌（access token）。
OAuth 2.0定义了四种授权方式。
  + 授权码模式（authorization code）
  + 简化模式（implicit）
  + 密码模式（resource owner password credentials）
  + 客户端模式（client credentials）

  授权码模式

![request](/images/posts/api/authorization_code.jpg)

  步骤如下：

  （A）用户访问客户端，后者将前者导向认证服务器。
  （B）用户选择是否给予客户端授权。
  （C）假设用户给予授权，认证服务器将用户导向客户端事先指定的"重定向URI"（redirection URI），同时附上一个授权码。
  （D）客户端收到授权码，附上早先的"重定向URI"，向认证服务器申请令牌。这一步是在客户端的后台的服务器上完成的，对用户不可见。
  （E）认证服务器核对了授权码和重定向URI，确认无误后，向客户端发送访问令牌（access token）和更新令牌（refresh token）。

Introduction of Oauth2 : [Oauth2](http://www.ruanyifeng.com/blog/2014/05/oauth_2_0.html)
Wiki for all status: [HTTP STATUS CODE](http://www.restapitutorial.com/httpstatuscodes.html)