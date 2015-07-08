---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


You may think of *Volume Storage* (also referred to as *block storage*) as a *section* of a large hard-drive which has been assigned for your use. Volume storage appears to the system and the user as *attached drives*. You will see it listed in your file explorer along with your other harddrives. 

You have to *request an allocation* (see [Module 5](/package05/sections/allocations.html)) to obtain access to Volume storage. Depending on your requirements and how you justify your needs, you may get access to very large Volumes.


Volume storage can live outside your instance. It is appears as block storage which can be attached and then accessed from any of your instances. 
You can attach the Volume to your instance, read and write data, detach it, and make it available to another instance. 
Your data on a Volume is retained even when you terminate your instance. Volumes also offer a *Snapshot* feature which can be used to make convenient backups (this uses some of your overall Volume quota).

You can use the Volume storage as regular *block storage*, for example for your programs to read/write files to from within a program, or to operate your databases. You may also store all your important files on the Volumes --- however don't forget to do regular backups (more about this in [Module 9][ModDoc9])! 

It is also possible to boot an instance from a Volume. For more information, please refer to the [NeCTAR support website](http://support.rc.nectar.org.au/docs/volumes). 

In [Module 7][ModDoc7] we will learn how to attach and detach a Volume to an instance and access the data on it. [Module 9][ModDoc9] will discuss how to do Backups of Volumes.

{% BgBox info %}
Volumes are *local services* and only instances living in the same Node where the Volume has been created can access it.
{% endBgBox %}

