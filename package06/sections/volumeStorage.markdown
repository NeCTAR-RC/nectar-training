---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


You may think of *volume storage* (also referred to as *block storage*) as one section of a drive of continuous storage which has been assigned for your use. Volume storage appears to the system and the user as *attached drives*. You will see it listed in your file explorer along your other harddrives. Block storage is the type of storage that is required for running things like databases, or as a storage required by applications (e.g. your data analysis software) which frequently access and write files. Volume storage types do not efficiently scale up, but it is required for fast and efficient access from applications. Also, most traditional applications only support file access in simple block storage systems.

Volume storage can live outside your instance. It is appears as block storage which can be attached and then accessed from any of your instances. 
You can attach the Volume to your instance, read and write data, detach it, and make it available to another instance. 
Your data on a volume is retained even when you terminate your instance. Volumes also offer a *Snapshot* feature which can be used to make convenient backups (this uses some of your overall volume quota).

It is even possible to boot an instance from a Volume. For more information, please refer to the [NeCTAR support website](http://support.rc.nectar.org.au/docs/volumes). 

In [Module 7][ModDoc7] we will learn how to attach and detach a Volume to our instance, and [Module 9][ModDoc9] will discuss how to do Backups and Snapshots of Volumes.

{% BgBox info %}
Volumes are *local services* and only instances living in the same Node where the volume has been created can access it.
{% endBgBox %}

