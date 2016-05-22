---
title: Create a New User and Grant Permissions in MySQL
date: 2016-05-07 16:40:00 +0800
categories: [technologies]
tags: [mysql,sql,database]
author: Kevin
---

This is a brief tutorial about creating user and grant permissions in MySQL


## How to Create a New User

Making a new user within the MySQL shell:

    CREATE USER 'kevin'@'localhost' IDENTIFIED BY 'password123';
    
If you want the new user to be able to login from any host:

    CREATE USER 'kevin' IDENTIFIED BY 'password123';
    
At this point the new user has no permissions to do anything with the database, not even to login. 

To grant all privileges on all database to the user:

    GRANT ALL PRIVILEGES ON *.* TO 'kevin'@'localhost';
    
Clearly this new user got too big power, if you want to just grant privileges on a specific database to the user:

    REVOKE ALL PRIVILEGES ON *.* FROM 'kevin'@'localhost'; 
    
    GRANT ALL PRIVILEGES ON wordpress.* TO 'kevin'@'localhost';
    
Instead of granting all privileges, you can also only grant specific permissions:

- CREATE - allows user to create new tables or databases
- DROP - allows user to delete tables or databases
- DELETE - allows user to delete rows from tables
- INSERT - allows user to insert rows into tables
- SELECT - allows user to read through databases
- UPDATE - allows user to update table rows
- GRANT OPTION - allows user to grant or remove other users' privileges

Once you have finalized the permissions that you want to set up for the user, always be sure to reload all the privileges:

    FLUSH PRIVILEGES;
    
Your changes will now be in effect.
    
To test your new user, log out and log back in with the commands in terminal:

    quite
    
    mysql -u kevin -p
    
If you want to delete a user:

    DORP USER 'kevin'@'localhost'
    
Just list the syntax again:

    GRANT [type of permissions] ON [database name].[table name] TO '[username]'@'[hostname]'
    
    REVOKE [type of permissions] on [database name].[table name] FROM '[username]'@'[hostname]'
    
    DROP USER '[username]'@;'[hostname]'
