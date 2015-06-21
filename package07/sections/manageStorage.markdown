---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


# 7.6 Managing storage

Prerequisite: You should know what types of storage is available on the NeCTAR cloud. This was discussed in Module 6.

You should also be familiar with connecting to your instance via an ssh shell, as described in [7.2.1: Connect via ssh](#heading=h.sjzg6xxm63fs).

As a brief recap, these are the following storage types:

* **Object storage**: These are single files which you can upload on the server and which you can access from anywhere via a simple web interface.

* Volume Storage (also called Block Storage) and Ephemeral Storage (Also called On-Instance storage) are directly attached to your instance.

    * **Ephemeral storage** is tightly attached to your instance and is deleted when you terminate (delete) your instance. You cannot recover the data after you terminate the instance.

    * **Volume Storage** can be attached and detached from your instance(s). After you terminate the instance, the data is not lost. You can attach it to a new instance after you launch it. 

## Request storage

The NeCTAR trial account only includes object and part of the ephemeral storage. You will have to file an allocation request to get access to Volume storage and extended ephemeral storage.

The allocation process is described in detail here:

[http://support.rc.nectar.org.au/docs/allocations](http://support.rc.nectar.org.au/docs/allocations) 



