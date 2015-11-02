---
layout: package-part
part: Outline
---

Duration: about 1 - 1.5 hours (video targeted at 0.5 hours)

Level: _Beginner_ / **_Intermediate_** / **_Advanced_**

### Synopsis


This module discusses how to back up VMs and data on various storage types. The attendee will learn how to make snapshots and how to recover their virtual machine using this snapshot. They will also learn how to backup their data and how to terminate a virtual machine without losing anything.

Emphasis is placed on how important it is to terminate/delete resources which are not needed any more: If resources are kept running idle, they are unavailable to other researchers. An appeal is made to play fair and use only the resources which are required at a time.

### Content

This module covers:

* An introduction on why it is important to create backups and terminate/delete resources which are not needed
* Creating snapshots of a VM and of Volumes.
* Launching a VM from a snapshot
* Creating images from a volume
* Tools to use for backing up volumes
    * Difference between *Backup* and *Snapshot*
    * Backups using OpenStack
    * Backups using RSync
    * Creating an image of a volume using *dd*
    * Using *BackupPC* to install a backup server
    * Overview of other backup tools
* Cleaning up:
    * Securely erasing data with *dd* or *shred*
    * Terminating instances and volumes via the Dashboard


### Delivery

* face to face
* video
* hands-on exercises

### Outcomes

The attendee will know how to back up their instance and data, how to securely erase a disk before releasing it, and how to terminate instances and volumes. They will know that it is important to release resources they don't need any more so other researchers can use them.

### Course suitable for

Intermediate to advanced users who have attended the previous modules or have equivalent knowledge.
The researcher is concerned about data loss. They want to know what the cloud will do to protect their data. They also want to know what they need to do and how to do it. 
They are done with a project but terminating a VM scares them - they want to know how to keep a copy of their VM for posterity.

### Before the course

The attendee needs to bring their own laptop (and charger!) if there are no Lab computers available. Instructions in this Module cover Linux, Mac OSX and Windows systems.

The user should have already logged onto the Dashboard once to activate their Trial Account. They should be familiar will all terminology and steps involved in launching an instance and setting up NeCTAR storage. They have already set up an instance and can connect to it via ssh; they have set up one secondary ephemeral disk and mounted it on the instance; ideally, they have done the same with one Volume.

They should have this instance and storage ready to go. They will create Snapshots of this instance and backups of the volume, and then **delete** this instance and volume --- so if they are concerned, they should set up an instance and volume exclusively for this tutorial which they can delete without being concerned.

No software needs to be installed in advance, all of this is going to be covered in the exercises.

