---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

When you are finished with your work and don’t need the virtual machine any more, you should *terminate* it, so it does not take up any more of your allocated resources. By deleting the instance and volumes you don't need any more, you **free them up for other researchers** to use. You can easily terminate an instance on the Dashboard.

However before you terminate it, don’t forget to back up your data that is on the *on-instance storage* (*Note:* [Module 6][ModDoc6] will discuss the different storage types). Data on on-instance storage will be lost after you terminate your instance. You may also want to create a Snapshot of your instance before you terminate it, so you can re-launch it any time. [Module 9][ModDoc9] will discuss options to back up your data and how to take a Snapshot of your instance and later re-launch it from this snapshot.

Similarly, if you don’t need your *volume data storage* (discussed in [Module 6][ModDoc6]) any more, you should delete it. You can also do this in the Dashboard. Before you delete it, you should *securely erase* all the data on it, so nobody else can restore it if they get access to the portion of the harddrive where your data was stored before.        
You will most likely want to back up your data on the storage, so you can restore it at a later time.     
[Module 9][ModDoc9] will show how to safely erase a hard-disk and how to create a backup of it and restore it at a later time.


