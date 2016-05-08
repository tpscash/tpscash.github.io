---
title: Maven Dependency Mechanism
date: 2016-05-08 13:40:00 +0800
categories: [technologies]
tags: [maven]
author: [Kevin]
---

Transitive dependencies are a new feature since Maven 2.0.

## Transitive Dependencies

It allows you to avoid needing to discover and specify the libraries that your own dependencies require, and including them automatically.

There is no limit to the number of the levels that dependencies can be gathered from, and will only cause a problem if a cyclic dependency is discovered.

With transitive dependencies, the graph of included libraries can quickly grow quite large. For this reason, there are some additional features that will limit which dependencies are included:

- Dependency mediation - this determines which version of a dependency will be used when multiple version of an artifact are encountered. Maven supports using the "nearest definition" which means it will use the version of the closest dependency to your project in the tree of dependencies(*If two versions are at the same depth in the dependency tree, then it's the order in the declaration that counts - since Maven 2.0.9*). **You can always guarantee a version by declaring it explicitly in your project's POM.** 

- Dependency management - version can be specified explicitly in the dependency management section for transitive dependencies.

- Dependency scope - this allows you to only include dependencies appropriate for the current stage of the build

- Excluded dependencies

- Optional dependencies


## Dependency Scope

Dependency scope is used to limit the transitivity of a dependency and also affect the classpath used various build tasks.

There are 6 scopes available:

- compile

  This is the default scope, used if none is specified. Those dependencies are propagated to dependent projects.
  
- provided

  This is much like `compile`, but indicates you expect the JDK or a container to provide the dependency at runtime. This scope is only available on the compilation and test classpath and is not transitive.
  
- runtime

  This scope indicates that the dependency is not required for compilation, but is for execution. It is in the runtime and test classpath, but not the compile classpath
    
- test

  This scope indicates that the dependency is not required for normal use of the application, and is only available for the test compilation and execution phase.
  
- system

  This scope is similar to `provided` except that you have to provide the JAR which contains it explicitly. The artifact is always available and **is not looked up in a repository.**
  
- import

  This scope is only used on a dependency of type `pom` in the `dependencyManagement` section. It indicates that the specified POM should be replaced with the dependencies in that POM's `dependencyManagement` section.
  
  
## Dependency Scope Affects Transitive Dependencies

Each of the scopes (except for `import`) affects transitive dependencies in different ways, as is demonstrated below. **If a dependency is set to the scope in the left column, transitive dependencies of that dependency with the scope across the top row will result in a dependency in the main project with the scope listed at the interaction. If no scope is listed, it means the dependency will be omitted.**

|          | compile  | provided | runtime  | test |
|----------|----------|----------|----------|------|
| compile  | compile  | -        | runtime  | -    |
| provided | provided | -        | provided | -    |
| runtime  | runtime  | -        | runtime  | -    |
| test     | test     | -        | test     | -    |