---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


## Ephemeral storage

On-Instance appears as two separate hard disks: In the flavour "m1.small" (you selected the *flavour* when launching the instance), this is 

(1) a primary disk (10GB) which is saved with snapshots you make of the instance (see Module 9 for details about snapshots), and 

(2) a secondary disk (30GB to 480GB depending on your allocation) which appears as a second hard disk on your instance, and is *not *backed up with snapshots. You will have to back up your data separately, which is a topic we will discuss later in Module 9.

The primary disk (1) is usually used for the operating system, you should not use it primarily to store data. For this, you have the secondary disk (2). The advantage of this disk, as opposed to the volume storage that we will discuss next, is that you don’t have to request it separately, it already comes with your instance.

To get access to the secondary disk, we will have to "*mount*" it first. *Mounting* is a technique which essentially makes your hard drive accessible to you at a certain location (in a folder). Usually, the secondary disk is available on your system path */dev/vdb*, but the disk may not be mounted yet, so we will have to do this ourselves. 

To see where your secondary disk is mounted, go to your *ssh shell* and type:

*   mount | grep vdb*

Now, you may verify that you have formatted the drive with the *ext4* file system. Type

  *sudo lsblk -f*

This should give you an output similar to this:

NAME     MAJ:MIN   RM    SIZE   RO     TYPE   MOUNTPOINT

**vda**	   253:0	 0     **10G**    0      disk

`-vda1   253:1	 0     10G    0      part   **/**

**vdb**	   253:16    0     **30G**    0      disk   /mnt

This tells us that we have two hard drives, **vda** and **vdb**, of sizes 10G and 30G respectively. The primary disk (*vda*) is further partitioned into a sub-disk, using the full 10G, and this is *mounted* under the *mountpoint* ‘/’. In Linux terms, this means this disk is used for the operating system. The secondary disk (*vdb*) has 30G and is mounted on */mnt*. Many OS, for example Ubuntu, already have mounted the secondary disk, but it may also not be mounted yet, in which case nothing is specified under MOUNTPOINT. If it is mounted, take note of what is specified here for your secondary disk.

In the above example, the disks are available on the paths */dev/vda*  and */dev/vdb* (you have to put the */dev/* before the disk name to get the path).

NOTE: Alternatively, you can use

  *sudo fdisk -l*

to print information about your drives.

 

No matter whether your secondary disk has been mounted or not, we would like to do this manually and mount it at a path which is more meaningful to us than "*/mnt*". So in any case, follow these instructions to set up your secondary hard disk. You should do this every time you start up a new instance. 

### Step 1. Formatting

The first time you start up an instance, you may want to format the hard drive of your secondary disk to make sure you have the right file system and start from a clean state. 

**Important: **Note that we will now erase all data that may already be on the hard disk (if it is a new instance, nothing of importance will be on it, e.g. only a default system "*Lost+Found*" folder or something similar). 

One way to do format the drive is typing the command:

  *sudo mkfs.ext4 /dev/vdb*

(if your secondary drive is at another path than /dev/vdb, which you have just found out before, you have to replace this here).

Confirm the formatting with ‘y’. You should see the status message

  Writing superblocks and filesystem accounting information:

Wait a while until it says "done.", and then your hard-drive is formatted.

Now, you may want to verify that you have formatted the drive with the ext4 file system:

  *sudo lsblk -f*

This should give you something like:

NAME      FSTYPE        LABEL UUID                             	MOUNTPOINT

vda                                                 	 

`-vda1   ext4     	1b85cad6-8ac8-4822-a62e-7ad03d71c5aa      /

vdb	   ext4     	e31a7587-20f5-4026-aca3-a473dadc1593

It shows you that we have the *ext4* file system for both *vda* and *vdb*, and only *vda* is mounted.

We will mount the secondary drive in the next step.

### Step 2. Mounting

You can now mount your hard drive, so you can access it afterwards. First, create a folder which will be used to access your data. For example, we can name it /data:

  *sudo* *mkdir /data*

Then, mount it:

  *sudo mount  /dev/vdb  /data*

Now, your disk is mounted at */data*, and you can add, remove and access files on your secondary disk at the path */data*. You can list the contents of this directory to see what is on your disk (alternatively, if you are using a remote desktop, you can open it in your file explorer. It should be displayed as a disk symbol in the left navigation panel): 

  *ls /data*

You may see that there is a "*Lost+Found*" folder already which has been put there for you (this is a default system folder). If nothing is printed, you have no files there yet.

### Step 3. Write permissions

By default, you do not have write permissions on the secondary drive. So we need to change this now. You will only need to do this once.

First, find out which user group you belong to is. Type

  *id ubuntu*

and find what is written behind "*gid=*". This may be *gid=1000(ubuntu)*. So your group name is also *ubuntu* and has the ID *1000*.

Now, there are two options: You can 1) enable write permission only for yourself (your username "*ubuntu*"), or 2) for the user group you are in. This way, you can share the drive with other users that you may give access to your instance and who you put in the same user group. The instructions below detail what you need to do for both alternatives.

Option 1) 

  *sudo chown ubuntu /data*

Option 2) 

    *sudo chgrp ubuntu /data*

    *sudo chmod g+rwx /data*

This should do it. You will only need to do this once.

### Step 4. Auto-mounting

Every time you reboot your machine, you have to *mount* (**_not_*** format!*) the secondary drive again (so only do step 2 above, not step 1). We can avoid this by *automounting* it. For this, we have to edit a file called *fstab*:

  *sudo nano /etc/fstab*

Look for a line which starts with */dev/vdb*. You may find one that looks like this:

**  ****/dev/vdb   /mnt  **auto	defaults,nobootwait,comment=cloudconfig   0  2

If you find such a line, this means your secondary hard disk is already automatically mounted at system start. On the Ubuntu distribution we are using in this tutorial, it is auto-mounted to the folder */mnt*, as we can see in this line. If you find this line, you can edit it and just change the */mnt *to */data*. If you cannot find this line, just add this line to the file at the bottom:

**/dev/vdb   /data  **auto   defaults,nobootwait   0  2

Exit the nano file editor with Ctrl+X and confirm saving of the file with ‘Y’. Next time you reboot your instance, you should already find your secondary drive in your folder */data*.


