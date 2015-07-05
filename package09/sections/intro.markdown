---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

In this module we will discuss how you can back up your instance and your data. You will learn how to make snapshots and how to recover your virtual machine using this snapshot. You will also learn how to backup your data and how to terminate your virtual machine without losing anything.

Not only is it important that you know about what measures are taken at NeCTAR to prevent data loss. Part of keeping your data safe is your responsibility: You should **create backups** at regular intervals. In this module, you will learn a few options how to back up your data.

A very important issue is also that you **"clean up"** your resources after you have finished using them. This involves not only securely erasing data on your volumes or ephemeral storage. You should also "terminate" (delete) your instance as soon as you don't need it any more. Why is this so important? Because your instance, while it is running, **takes up resources which other researchers may need**. 
{% BgBox info %}
NeCTAR experiences resource shortage problems from time to time, which is largely due to that most NeCTAR instances are seriously underutilized (they are *idle*). It has been observed that the average CPU utilization rate across the NeCTAR federation is less that **5%**, and many large instances sit idle for days, weeks or months at a time.
{% endBgBox %}

The problem is that many people want their compute resources to be available when *they* are ready to use them. They don't realise that while they are not using it, they are blocking resources to others. It is therefore important that everyone is aware of this and responsibly releases their resources when they don't need them any more. **Fair play!**

It is not difficult to **save your instance and volumes** ("create a snapshot"), then terminate the VM and release the volumes, and **re-launch your instance and volumes** in exactly the same state at a later time, when you need it. In this module, we will show you how you can do this.




{% include /disclaimer.markdown %}
{% include /disclaimerCmd.markdown %}

