---
title: Discover the Mystery of Metaspace
date: 2017-06-23 12:30:00 +0800
categories: [technologies]
tags: [jdk]
author: Kevin
---

The JDK 8 HotSpot JVM is now using native memory for the representation of class metadata and is called Metaspace

## What is Metaspace

Metaspace is nothing but a replacement of our old friend PermGen (Permanent Generation) space. The main difference between PermGen and Metaspace is that Metaspace by default auto increases its size while PermGen always has a fixed maximum size. You can set a fixed maximum for Metaspace with JVM parameters, but you can't make PermGen auto increase. By default class metadata allocation is limited by the amount of available native memory (capacity will of course depend if you use a 32-bit JVM vs. 64-bit along with OS virtual memory availability). The main purpose of Metaspace is to reduce the OOM error caused by PermGen is exhausted (although the removal of PermGen doesn’t mean that your class loader leak issues are gone).

## What is Metaspace Composed of

If `UseCompressedOops` is turned on and `UseCompressedClassesPointers` is used, then two logically different areas of native memory are used for class metadata - `Klass Metaspace` & `NoKlass Metaspace`. UseCompressedClassPointers uses a 32-bit offset to represent the class pointer in a 64-bit process as does UseCompressedOops for Java object references. A region (Klass Metaspace) is allocated for these compressed class pointers (the 32-bit offsets). The size of the region can be set with `CompressedClassSpaceSize` and is 1 gigabyte (GB) by default and it is just adjacent to the heap. The space for the compressed class pointers is reserved as space allocated by `mmap` at initialization and committed as needed. The `MaxMetaspaceSize` applies to the sum of the committed compressed class space and the space for the other class metadata (NoKlass Metaspace). If UseCompressedOops & UseCompressedClassesPointers are turned off or `-Xmx` is set to greater than 32G, the Klass Metaspace will not exist, all Klass will be nested in NoKlass Metaspace in this case.

Java Hotspot VM explicitly manages the space used for metadata. Space is requested from the OS and then divided into chunks (can be discontiguous chunks). A class loader allocates space for metadata from its chunks (a chunk is bound to a specific class loader). When classes are unloaded for a class loader, its chunks are recycled for reuse or returned to the OS. Metadata uses space allocated by `mmap`, not by `malloc`. Klass Metaspace & NoKlass Metaspace are shared by all class loaders.

 
## Metaspace Tuning

Class metadata is deallocated when the corresponding Java class is unloaded. Java classes are unloaded as a result of garbage collection, and garbage collections may be induced in order to unload classes and deallocate class metadata. When the space committed for class metadata reaches a certain level (a high-water mark), a garbage collection is induced. After the garbage collection, the high-water mark may be raised or lowered depending on the amount of space freed from class metadata. The high-water mark would be raised so as not to induce another garbage collection too soon. The high-water mark is **initially** set to the value of the command-line option `MetaspaceSize`. **It is raised or lowered based on the options MaxMetaspaceFreeRatio and MinMetaspaceFreeRatio**. If the committed space available for class metadata as a percentage of the total committed space for class metadata is greater than `MaxMetaspaceFreeRatio`, then the high-water mark will be lowered. If it is less than `MinMetaspaceFreeRatio`, then the high-water mark will be raised
 
Specify a higher value for the option `MetaspaceSize` to avoid early garbage collections induced for class metadata. The amount of class metadata allocated for an application is application-dependent and general guidelines do not exist for the selection of MetaspaceSize. The default size of MetaspaceSize is platform-dependent and ranges from 12 MB to about 20 MB.


Besides all the parameters mentioned above, there are also several other parameters to change Metaspace behaviors, below list includes them all together:

* UseLargePagesInMetaspace
* InitialBootClassLoaderMetaspace
* MetaspaceSize
* MaxMetaSpaceSize
* CompressClassSpaceSize
* MinMetaspaceExpansion
* MaxMetaspaceExpansion
* MinMetaspaceFreeRatio
* MaxMetaspaceFreeRatio

### UseLargePagesInMetaspace

By default its value is false. This parameter specify if use LargePage in Metaspace. Generally the page size is 4KB. This parameter takes effect only if `UseLargePages` is turned on, but usually it is turned off.

### InitialBootClassLoaderMetaspaceSize

By default its value is 4M in 64-bit JVM and 2200K in 32-bit JVM. This parameter indicates the size of the first block of NoKlass Metaspace - 2 * InitialBootClassLoaderMetaspaceSize, meanwhile it indicates the size of the first chunk of bootstrapClassLoader.

### MetaspaceSize

By default its value is about 20M (~20.8M). It is the initial threshold (also the minimum threshold) of Metaspace GC.

### MaxMetaspaceSize

By default it's unlimited. It is recommended to set value for this parameter to avoid memory leak exhausted all the OS memory.

### CompressedClassSpaceSize

By default its value is 1g. It is the size of Klass Metaspace. It only takes effect when `UseCompressedOops` & `UseCompressedClassesPointers` are turned on and `-Xmx` doesn't exceed 32G

### MinMetaspaceExpansion

Is it the minimum size to expand when Metaspace is not enough (as its name implies)? No...
 
It is the minimum requirement on the incremental size when increasing the threshold of Metaspace GC. By default its value is 332.8K.

###  MaxMetaspaceExpansion

By default its value is 5.2M. It is the maximum requirement on the incremental size when increasing the threshold of Metaspace GC. If the incremental size exceeds MinMetaspaceExpansion but less than MaxMetaspaceExpansion, then the incremental size is MaxMetaspaceExpansion. If the incremental size exceeds MaxMetaspaceExpansion, then the incremental size is MinMetaspaceExpansion + original incremental size

### MinMetaspaceFreeRatio

By default its value is 40. After a GC activity, If the committed space available for class metadata as a percentage of the total committed space for class metadata is less than MinMetaspaceFreeRatio, then the threshold of Metaspace GC will be raised, but the incremental size of the threshold must meets the requirement by MinMetaspaceExpansion, otherwise the threshold will not be raised.

### MaxMetaspaceFreeRatio

By default its value n 70. The effect of this parameter is the opposite to the MinMetaspaceFreeRatio.


## Tools to Check Metaspace

We can use `jstat` to check the Metaspace of a JVM process:

`jstat -gc <pid>`

Meaning of the output:

### MC

It is total committed size of Klass Metaspace & NoKlass Metaspace (it is committed size although the name is interpreted to capacity). Unit is KB.

### MU

It is used size of Klass Metaspace & NoKlass Metaspace. Unit is KB.

### CCSC

It is the committed size of Klass Metaspace. Unit is KB.

### CCSU

It is the used size of Klass Metaspace.

### M

It is the total usage of Klass Metaspace & NoKlass Metaspace - (CCSU + MU) / (CCSC + MC).

### CCS

It is the usage of NoKlass Metaspace - CCSU / CCSC.

### MCMX

It is total reserved size of Klass Metaspace & NoKlass Metaspace. By default, Klass Metaspace reserves 1g of memory and NoKlass Metaspace reserves 2 * InitialClassLoaderMetaspaceSize of memory.

### CCSMX

It is the reserved size of Klass Metaspace.



