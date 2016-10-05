---
title: Servlet 3.0 Annotation
date: 2016-10-05 16:30:00 +0800
categories: [technology]
tags: [servlet,annotation]
author: Kevin
---

Servlet 3.0 has many new features like **pluggability and the extension support**, **asynchronous execution of processing**,and **a new set of annotations**.

And with these annotations, we can write servlet completely without web.xml.

You can use below annotations on your servlet or filter to achieve the same effect as you usually do in web.xml

    @WebServlet
    
    @WebFilter
    
    @WebListener

If you don't own the source code of the servlet or filter, you can register them programmatically by implementing your own `ServletContainerInitializer`. In spring-web, there is already an implementation `SpringServletContainerInitializer`, we can utilize this and just provide an implementation of `WebApplicationInitializer`. A sample for a JWS project:

    public class WebInit implements WebApplicationInitializer {
        @Override
        public void onStartup(ServletContext servletContext) throws ServletException {
    
            servletContext.addFilter("hibernateFilter", OpenEntityManagerInViewFilter.class).addMappingForUrlPatterns(null, false, "/*");
    
            AnnotationConfigWebApplicationContext root = new AnnotationConfigWebApplicationContext();
            root.register(MainConfig.class);
            servletContext.addListener(new ContextLoaderListener(root));
    
            ServletRegistration.Dynamic jnlpDownloadServlet = servletContext.addServlet("JnlpDownloadServlet", new JnlpDownloadServlet());
            jnlpDownloadServlet.setLoadOnStartup(1);
            jnlpDownloadServlet.addMapping("*.jnlp", "webstart/*");
    
        }
    }

    