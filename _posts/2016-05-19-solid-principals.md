---
title: S.O.L.I.D Principles
date: 2016-05-19 21:30:00 +0800
categories: [technologies]
tags: [design,principles]
author: [Kevin]
---

S.O.L.I.D is an acronym for the **first five object-oriented design principles** by Robert C. Martin, popularly known as Uncle Bob.

S.O.L.I.D stands for:

| Principle | Description                       | Comment |
|:---------:|:---------------------------------:|---------|
| SRP       |  Single-responsibility Principle  | A class should have one and only one reason to change, meaning that a class should have only on job |
| OCP       |  Open-closed Principle            | Objects or entities should be open for extension, but closed for modification, meaning that a class should be easily extendable without modifying the class itself |
| LSP       |  Liskov Substitution Principle    | Let q(x) be a property provable about objects of x of type T. Then q(y) should be provable for objects y of type S where S is a subtype of T, meaning that every subclass / derived class should be substitutable for their base / parent class |
| ISP       |  Interface Segregation Principle  | A client should never be forced to implement an interface that is doesn't use or clients shouldn't be forced to depend on methods they do not use |
| DIP       |  Dependency Inversion Principle   | Entities must depend on abstractions not on concretions, meaning that the high level module must not depend on the low level module, but they should depend on abstractions |