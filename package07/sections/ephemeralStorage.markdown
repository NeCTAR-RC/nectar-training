---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

On-Instance storage appears as two separate hard disks. For example, in the flavor *"m1.small"* (you selected the *flavor* when launching the instance), this is 

1. a **primary disk** (10GB) which is saved with snapshots you make of the instance (see Module 9 for details about snapshots), and 

2. a **secondary disk** (30GB) which appears as a second hard disk on your instance, and is *not* backed up with snapshots. You will have to back up your data separately, which is a topic we will discuss later in [Module 9][ModDoc9].

The primary disk (1) is usually used for the operating system, you should not use it primarily to store data. Your "home directory" is also located within this disk space (when you log on with ssh, you start off in your "home directory" */home/ubuntu/*). To store large and important files, you should use the secondary disk (2). The advantage of this disk, as opposed to the volume storage, is that you don’t have to create it separately: it already comes with your instance.
Depending on the flavor you choose, you can get up to 480GB of storage for the secondary disk.

To get access to the secondary disk, we will have to *"mount"* it first. *Mounting* is a technique which essentially makes your hard drive accessible to you at a certain location (in a folder). Usually, the secondary disk is available on your system path */dev/vdb*, but this is a *device path*, and you cannot read files there as if it was a folder. For this, we have to *"mount"* */dev/vdb* to another folder. 

{% BgBox info %}
On some images, e.g. on the Ubuntu image we use, the device */dev/vdb* will already have been mounted for you, most likely in the folder */mnt*. However we will still go through the steps of how to mount a device to another folder (name it for example */data*), in order to learn all steps involved in preparing storage. You will benefit from this knowledge when setting up the Volume storage.
{% endBgBox %}

To see where your secondary disk is mounted (or *if* it is mounted), go to your *ssh terminal* and type:

```mount | grep vdb```

You may get output that looks similar to this:
{% BgBox terminal %}
ubuntu@myfirstinstance:~$ mount | grep vdb    
/dev/vdb on /mnt type ext3 (rw)
{% endBgBox %}
This means that vdb is mounted on *mnt* and has the *ext3* file system with read (r) and write (w) permissions. If you don't get an output at all, vdb is not mounted.

Alternatively, try this command to check the *mount point* and size of your disks: 

```sudo lsblk -l```

This should give you an output similar to this:

{% BgBox terminal %}
ubuntu@myfirstinstance:~$ sudo lsblk -l 
NAME  MAJ:MIN   RM  SIZE  RO TYPE MOUNTPOINT 
vda   253:0     0   10G   0  disk             
vda1  253:1     0   10G   0  part        /
vdb   253:16    0   30G   0  disk        /mnt
{% endBgBox %}

This tells us that we have two hard drives, **vda** and **vdb**, of sizes 10G and 30G respectively. The primary disk (*vda*) is further partitioned into a sub-disk called *vda1* (using the full 10G) and this is *mounted* under the *mountpoint "/"*. In Linux terms, this means this disk is used for the operating system. The secondary disk (vdb) has 30G and is mounted on */mnt*. Many OS, for example Ubuntu, already have mounted the secondary disk, but it may also not be mounted yet, in which case nothing is specified under MOUNTPOINT. 

If your disk *vdb* has already been mounted, take note of what is specified as *mount point* for it. Then, **unmount** the disk using the command:

``` sudo umount <mount point> ```

replacing &lt;mount point&gt; with your mount point. For example, if your disk was mounted on */mnt*, do

``` sudo umount /mnt ```

You may also be interested in the **file system type** which your secondary drive is currently using. 

{% BgBox definition %}
A **file system** is used to control how how the storage of data (files, folders, etc.) is organized on a computer disk (hard disk, floppy disk, CDROM, etc.).

The large amounts of data on a hard drive needs to be organized, similar to a library of books which needs to be catalogued, otherwise books cannot be found efficiently. Libraries have developed standards to organise their books, and similarly, computer systems have. Windows uses the *vFat* or the *NTFS* systems, while Linux has others, e.g. *ext3* and *ext4* are current standards.

File systems have different properties, e.g. maximum file size or partition size that is supported, and whether they *journal* or not. A *journaling file system* is more reliable when it comes to data storage: it prevents inconsistency, and is much faster at file system checks than non-journaled file systems.  

For more information about the different Linux file systems, refer to this
[Ubuntu help page](https://help.ubuntu.com/community/LinuxFilesystemsExplained).
{% endBgBox %}



To find out which *file system type* your drives use, type:

```sudo lsblk -f```

which will print a different view of the information we have seen in the last command (because we use the **-f** option instead of **-l**). It should look similar to this:

{% BgBox terminal %}
ubuntu@myfirstinstance:~$ sudo lsblk -f
NAME     FSTYPE   LABEL        UUID               MOUNTPOINT 
vda                                                            
└─vda1   ext4                  1b85cad6-...       /           
vdb      ext3     ephemeral0   24cf7b45-77...       
{% endBgBox %}

From this, we can see that *vda1* is a *partition* of *vda*. We can also see that
*vda1* uses the file system type *ext4*, while *vdb* is formatted with *ext3*.

In the above example, the disk devices are available on the paths */dev/vda*  and */dev/vdb* (you have to put the */dev/* before the disk name to get the path).

Follow these instructions below to set up your secondary hard disk. You should do this every time you start up a new instance and want to prepare the secondary disk for usage.


### Step 1. Formatting

The first time you start up an instance, you may want to format the hard drive of your secondary disk to make sure you have the right *file system type* and start from a clean state. 

{% BgBox important %}
Formatting **erases all data** that may already be on the hard disk. If you are working with a new instance, nothing of importance will be on it, e.g. only a default system *Lost+Found* folder, or something similar. You should only be careful with this step if you have used the disk before and have data on it. Then, you should **back up** this data or **skip this step** (if you skip this step, you will have to keep the file system which is already used on the disk).
{% endBgBox %} 

One way to format the drive with the *ext4* file system type is:

```sudo mkfs.ext4 /dev/vdb```

(if your secondary drive is at another path than */dev/vdb*, which you have just found out before, you have to replace this here).

Confirm the formatting with *'y'*. You should see the status message

{% BgBox terminal %}
Writing superblocks and filesystem accounting information:
{% endBgBox %}

Wait a while until it says "done.", and then your hard-drive is formatted.

Now, you may want to verify that you have formatted the drive with the ext4 file system. Again, use the command
  
```sudo lsblk -f```

which prints information similar to this:

{% BgBox terminal %}
ubuntu@myfirstinstance:~$ sudo lsblk -f
NAME    FSTYPE  LABEL       UUID               MOUNTPOINT  
vda                                                                 
└─vda1  ext4                1b85cad6-...       /            
vdb     ext4                24cf7b45-77...         
{% endBgBox %}

You should now see that *vdb* is formatted with *ext4*. Only *vda* is mounted on *"/"*, and this should stay this way, because the OS is saved under *"/"*.

We will *mount* the secondary drive in the next step.

### Step 2. Mounting

You can now *mount* your hard drive, so you can access it. First, create a folder which will be used to access your data. For example, we can name it */data*:

```sudo mkdir /data```

Then, mount it:

```sudo mount /dev/vdb /data```

{% BgBox info %}
This will mount the disk if the type of file system can be guessed. 
Otherwise you may have to specify the file system type with the -t option, e.g.    
```sudo mount /dev/vdb /data -t ext4.```

If you did not create and format the Volume then you can look up the filesystem type:    
```sudo parted -l```
{% endBgBox %}



This maps the device *dev/vdb* to the folder */data*.
Now, your disk is mounted at */data*, and you can add, remove and access files on your secondary disk at the path */data*. 

You can list the contents of this directory to see what is on your disk (alternatively, if you are using a remote desktop, you can open it in your file explorer. It should be displayed as a disk symbol in the left navigation panel of your file browser). 

```ls /data```

You may see that there is a *Lost+Found* folder (this is a default system folder). If nothing is printed, you have no files there yet.

### Step 3. Write permissions

By default, you do not have write permissions on the secondary drive. You can try to copy a file onto */data*, but you will get an error message about write permissions (*Note:* This is *not* due to our folder not being located in our home directory). So we need to add our write permissions now. 

First, find out which *user group* you belong to is. Type

```id ubuntu```

and find what is written behind *"gid="*. This may be *gid=1000(ubuntu)*. So your *group name* is also *ubuntu* and has the ID *1000*.

Now, there are two options: You can 1) enable write permission only for yourself (your username *ubuntu*), or 2) for the *user group* you are in. This way, you can share the drive with other users that you may give access to your instance and who you put in the same user group. The instructions below detail what you need to do for both alternatives.

Option 1) 

```sudo chown ubuntu /data```

Option 2) 

```sudo chgrp ubuntu /data```    
```sudo chmod g+rwx /data```

This should do it. You can now write and execute files from your secondary drive.

You will only need to do this once for the secondary drive on this instance. 

### Step 4. Auto-mounting

Every time you reboot your machine, you have to *mount* (**_not_** format!) the secondary drive again (so only do Step 2 above, not Step 1). We can avoid this by *automounting* it. For this, we have to edit a file called *fstab*:

```sudo nano /etc/fstab```

Look for a line which starts with */dev/vdb*. You may find one that looks like this:

{% BgBox edit %}
/dev/vdb  /mnt    auto    defaults,nobootwait,comment=cloudconfig   0  2
{% endBgBox %}

If you find such a line, this means your secondary hard disk is already automatically mounted at system start. On the Ubuntu distribution we are using in this course, this is the case: it is auto-mounted to the folder */mnt*, as we can see in this line. If you find this line, you can edit it and just change the */mnt *to */data*. If you cannot find this line, just add this line to the file at the bottom:

{% BgBox edit %}
/dev/vdb   /data  auto   defaults,nobootwait   0  2
{% endBgBox %}

Exit the nano file editor with **Ctrl+X** and confirm saving of the file with *'Y'*. Next time you reboot your instance, you should already find your secondary drive in your folder */data*, and you won't need to do any of the Steps described here to access it.


