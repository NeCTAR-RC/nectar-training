---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


NOTE TO SELF: We want to see how we can regularly backup the data on the server, but we also want to see how we can backup the data we have on the cloud and store it locally on our computer or data center. We should be able to access our data backups locally without effort, e.g. if there is an internet outage.

In case of internet drop-outs, we need access to all data. Therefore, we want to create a backup not only for the volume storage, for object storage as well!

### Backup the instance

https://espaces.edu.au/vwrangler/nectar-topics/nectar-how-tos/backups-for-nectar-virtuals

### Secondary disk & Volumes

Secondary disks and volumes have one thing in common: They are "mounted" as a disk on your instance, therefore you can use some methods for both of them - some tools described in this section will only be suitable for one of them though.

### Dashboard

easy way to back up volumes (does not work for secondary disk)

#### Creating a volume snapshot or backup

There are two ways to backup your data on the volume:

1. **Volume Backup**: Your data will be backed up and placed in the *Object Storage*. You can later restore that backup in a new volume. Only the amount of storage you are currently using is being backed up: If you only have 1GB of data on a 5GB volume, the backup will only be about 1GB.

2. **Volume Snapshot**: This creates a copy of your entire volume, so if the volume is 5GB but you are only using 1GB of it, the snapshot will still have a size of 5GB. The snapshot is stored in the Image service, you will be able to select it when you create a new volume.

Before taking a snapshot, you have to observe two things:

1. Your volume has to be detached. You can check this with "cinder list" or “nova volume-list”, it has to be in in “*available*” status.

2. The original volume that you want to take the snapshot of may not be deleted - if you delete it, then the snapshot will become unusable!

### Rsync type backups

The main characteristic of this type of backups is that they maintain a copy of the directory you want to keep a backup of, in a traditional "mirror" fashion.

Certain rsync-type packages also do snapshot backups by storing files which describe how the contents of files and folders changed from the last backup (so-called 'diffs'). Hence, they are inherently incremental, but usually they do not have compression or encryption. On the other hand, a working copy of everything is immediately available, no decompression/decryption needed. A downside to rsync-type programs is that they cannot be easily burned and restored from a CD or DVD.

Live data transfer: To copy the data from an example directory to the new machine replace 'blah' with your wanted directories:rsync -vaz /mnt/blah  ubuntu@VM.NEW.IP.ADDRESS:/mnt/blah    (or other way)

TODO: See man pages for rsync which have a good description to paste in here!

[http://support.ersa.edu.au/storage/rsync-guide.html](http://support.ersa.edu.au/storage/rsync-guide.html) 

[http://www.tecmint.com/rsync-local-remote-file-synchronization-commands/](http://www.tecmint.com/rsync-local-remote-file-synchronization-commands/) 

[https://wiki.archlinux.org/index.php/Backup_programs](https://wiki.archlinux.org/index.php/Backup_programs) 

!!!!!!!!

https://support.rc.nectar.org.au/wiki/Melbourne_qh2_VM_migration#Live_Data_Transfer

!!!!!!!!!

https://espaces.edu.au/vwrangler/nectar-topics/nectar-how-tos/backups-for-nectar-virtuals


### Cinder

TODO: Still have to try this out still!

[http://docs.openstack.org/admin-guide-cloud/content/volume-backup-restore.html](http://docs.openstack.org/admin-guide-cloud/content/volume-backup-restore.html) 

can use NFS export as backup repository!

Tutorial will be given in Module 10.

### CloneZilla

CloneZilla: [http://clonezilla.org/](http://clonezilla.org/) 

CloneZilla tutorial: [http://www.dedoimedo.com/computers/free_imaging_software.html](http://www.dedoimedo.com/computers/free_imaging_software.html) 

### Dump and restore commands

The "dump" and "restore" backup utilities in the Ubuntu repositories provide you with the ability to backup and recover an entire system's "system state".

The "dump" and "restore" utilities can be installed from the repositories using:

sudo apt-get install dump

Below are links to the Man pages:

⠀[Dump](http://manpages.ubuntu.com/manpages/trusty/man8/dump.8.html)

⠀[Restore](http://manpages.ubuntu.com/manpages/trusty/man8/restore.8.html)

In your case, you could backup the system to a portable drive:

dump -0uan -f my_file /

For recovery you would need to:

1. Boot from your Ubuntu live CD/DVD/USB.

2. Install the dump utility.

3. Mount your hard drive.

4. Restore (i.e. restore -r -f my_file /my_mount).

Note: If you are restoring to a new disk you will need to install your bootloader (GRUB).

More information can be found at[ Move linux to another hard drive (dump, restore, backup)](http://www.linuxscrew.com/2007/08/13/move-linux-to-another-hard-drive-dump-restore-backup/)

### 2.5 Ubuntu "disks"

We have a GUI available in Ubuntu, called 'Disks' (gnome-disk-utility) and comes default in later Ubuntu. You can use this option if you are connecting to a remote desktop.

If it is not in your Ubuntu distribution, install it manually:

 *sudo apt-get install gnome-disk-utility*

![image alt text](image_0.png)

### Scp / WinSCP / Filezilla 

to copy a backup image to your local machine

## 2.2 Object store

Mention again: This is safer as several copies are kept at various nodes.

Use clients (drag&drop) as discussed in module 7.

Point out encryption.

## Resources

[http://askubuntu.com/questions/19901/how-to-make-a-disk-image-and-restore-from-it-later](http://askubuntu.com/questions/19901/how-to-make-a-disk-image-and-restore-from-it-later) 

[https://wiki.archlinux.org/index.php/Backup_programs](https://wiki.archlinux.org/index.php/Backup_programs) 


