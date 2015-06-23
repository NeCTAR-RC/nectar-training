---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

In this section, we will go through the steps to set up various types of storage on our instance.

*Prerequisite:* You should know what types of storage is available on the NeCTAR cloud. This was discussed in [Module 6](/package06/sections/storage.html).
You should also be familiar with connecting to your instance via an ssh shell, as described in [an earlier section](connectViaSSH.html).

A brief recap of the available storage types:

* **Object storage**: These are single files which you can upload on the server and which you can access from anywhere via a simple web interface.

* **Volume Storage** (also called *Block Storage*) and **Ephemeral Storage** (also called *On-Instance storage*) are directly attached to your instance.

    * **Ephemeral storage** is tightly attached to your instance and is deleted when you terminate (delete) your instance. You cannot recover the data after you terminate the instance, unless you have backed it up.

    * **Volume Storage** can be attached and detached from your instance(s). After you terminate the instance, the data is not lost. You can attach it to a new instance after you launch it. 

### Requesting storage

The NeCTAR trial account only includes object storage and ephemeral storage. You will have to **file an allocation request** to get access to Volume storage.

The allocation process was described in [Module 5](/package05/sections/allocations.html), and more information can also be found on the [NeCTAR support website][Allocations].

{% BgBox important %}
If you don't have an allocation yet, you can complete the next section, "[On-Instance storage](ephemeralStorage.html)", and section "[Object storage](objectStorage.html)". You will have to wait for your allocation until you can follow instructions for "[Volume Storage](volumeStorage.html)". However you can still read through the Volume storage instructions to see that it is easy, and in parts very similar to handling the secondary disk with the On-Instance storge.
{% endBgBox %}
