---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

{% BgBox prerequisite %}
*Prerequisite:* You should be familiar with all the storage terminology discussed in [Module 6](/package06/sections/storage.html) and [Module 7](/package07/sections/manageStorage.html). You must know how to *mount* your secondary ephemeral drive on your instance, and how to *attach* and *mount* a Volume to your instance.

Some basic command line usage skills are helpful for this section as well.
{% endBgBox %}

The NeCTAR instances and volumes are not backed up automatically. Managing the backups is your repsonsibility.
However some types of NeCTAR storage use **RAID** storage, which protects your data somewhat against data loss (roughly speaking, if one harddrive fails, your data can probably be reconstructed from other drives). The *Object Store* is **replicated** across several physical locations, which is also a form of protection against data loss. The Table below shows which types of NeCTAR storage use RAID or are replicated:

| Storage   | Saved in <br> Snapshot | RAID  | Replicated | Backed up | 
|---------- |----------|-------|------------|-----------|
| Eph. 1st  | YES      | YES   |   NO       |  NO       |
| Eph. 2nd  | NO       | YES   |   NO       |  NO       |
| Volumes   | NO       | YES   |   NO       |  NO       |
| Object    | NO       | NO    |   YES      |  NO       |
|---------- |----------|-------|------------|-----------|

{% col 255,0,0 %}
TODO: Format this table, ensure information is correct. Source: [NeCTAR wiki](https://support.rc.nectar.org.au/wiki/ResearchCloudStorage#Summary)
{% endcol %}


It is recommended that you back up your important data at regular intervals. You may also feel more comfortable knowing that you have a copy of your data available off-line, maybe on your local office computer or a server at your research organistaion. There are lots of tools available to backup data --- in this section, we will discuss a few of them.


Of all the storage types, probably **Object Storage** is the most robust against data loss due to the physical distribution of multiple copies of each file. However you may still prefer to keep a copy of a recent state of your files on your local premises.
Probably the easiest way to keep backups of your objects is to use clients like *CyberDuck, CloudBerry* or FTP clients like *FileZilla* to copy your files across manually. This has been described [here in Module 7](/package07/sections/objectStorage.html). A more advanced way to automate backups from the object store is to write scripts which use the *openstack command line client* to download several object files. This is going to be subject to discussion in [Module 10][ModDoc10].

For backing up the **secondary ephemeral disk and Volume storage**, there are a number of different tools which have different characteristics in type and form of backup they achieve.
Both secondary ephemeral disk and Volumes have one thing in common: They are *"mounted"* at one folder on your instance. Therefore, to back up your data, you can use most methods for both of the storage types, with one exception: The OpenStack Volume backup tools only work for Volumes. 

In the following, we will discuss a few options and tools to back up your data on the ephemeral disk and on Volumes. 

### Backups of Volumes using OpenStack tools

OpenStack offers tools to back up your Volumes (*not* your secondary ephemeral disk). They can be used from the Dashboard, or from the command line.

There are two ways to backup your data on the volume:


1. **Volume Snapshot**: This creates a copy of your entire volume, so if the volume is 5GB but you are only using 1GB of it, the Snapshot will still have a size of 5GB. The Snapshot is stored in the Image service, so you will be able to select it when you create a *new* volume. A volume from which Snapshots have been created cannot be deleted while any of these Snapshots still exists --- A Snapshot is *dependent* of the actual Volume. Creating Snapshots is fairly quick.

2. **Volume Backup**: Your data will be backed up and placed in your *Object Storage*. You can later restore that backup onto a new *or* existing volume. Only the amount of storage you are currently using is being backed up: If you only have 1GB of data on a 5GB volume, the backup will only be about 1GB. Backups are independent of the original volume, but they are still full copies of the Volumes. Therefore, they take longer to create than Snapshots.  

The [last section](Snapshot.html) has discussed how to take a Snapshot of a Volume. To make a *Backup* instead, you will need to use the openstack command line client, as described in [Module 10](ModDoc10). Support to create Backups via the Dashboard will probably be added in the near future --- it will then work in a very similar fashion to taking Snapshots.


### Rsync command line utility 

[Rsync](https://rsync.samba.org/) is a Unix command line tool which maintains a copy of a local directory on a (typically) remote system, in a traditional "mirror" fashion. 
The contents of the two folders, which we call **source and destination folders are _synchronized_**. 
The source and destination folders can be on the same computer, or they could be on separate computers that are accessible over a network or the Internet.

In the most typical backup scenario, the *source* would be the disk which is *mounted* on your NeCTAR instance, and the *destination* would be your office computer or a server at your research organisation onto which the data will be backed up.

{% BgBox info %} 
Rsync creates **incremental backups**, which means only what has changed in the directory since the last backup will be copied to the backup folder, so not every time a backup is performed all files have to be transferred again. This speeds up the backup process, especially with slow network connections.

Rsync can also **compress and encrypt data streams** during the backup process, which is important if the data being backed up has to travel through the internet to reach the server which maintains the backup copy.
{% endBgBox %}

RSync is a **good choice for you if:** 

* you want to create a backup of the *most recent state* of your volume or secondary ephemeral drive 
* and save the backup on your local computer, or another computer onto which you can log on to a terminal (e.g. via a ssh shell).


RSync is great in that it does incremental per-file copies, so it makes it easy for you to access (and even edit) your files offline, and keep the most recent state of your data synchronized between your computer and the NeCTAR storage.

The main **drawbacks** are:

* it is difficult to maintain backups of multiple time points --- e.g. if you wanted to keep a backup of every week that you can restore individually later on. Rsync is more suitable to keep a backup of the *most recent state*.    
* if something goes wrong while the *rsync* process in ongoing, the backup will contain a mix of old and new files, and the whole backup process should be repeated.
* It is a bit more complicated to set up *automated backups* (you can do this using *cronjobs*); The easiest is if you do the backups manually each time you want to back up your data.

#### Installation of Rsync

You will have to install *rsync* on your local computer (or on any computer you can logon to via a terminal, e.g. via ssh, and you want to use this computer for backups).

* On many Linux distributions, *rsync* is already installed. If it is not, you can install it using your package manager. For example on Ubuntu/Debian:    
   ```sudo apt-get install rsync```
* On Mac OSX, *rsync* is available by default.
* Under Windows, *rsync* can be installed as part of the [cygwin](https://www.cygwin.com/) package and used from the command line. This is a bit more compilicated, so if you are using a Windows system, *rsync* is maybe not the right choice.

You also have to make sure *rsync* is installed on the NeCTAR instance on which the disk to be backed up is *mounted* --- the image we used in [Module 7][ModDoc7] does already come with *rsync* on it.

#### Usage of Rsync

The rsync command copies files from the *source* directory to the *destination* directory, automatically using your ssh keys to encrypt the connection:

```rsync -av <source directory> <destination directory>```

Either the source *or* destination directory can be a remote directory on your NeCTAR instance. For example, it can be the folder which your Volume is *mounted* on, which we called */data* in [Module 7][ModDoc7]. Or it can be any other folder on your NeCTAR instance.    
The other directory (source or destination) is then a directory on your local computer.

The syntax to specify a *remote* directory is *&lt;username&gt;@&lt;IP-Address&gt;:&lt;Path-to-Folder&gt;*

Depending on which direction you want to do the synchronization:

* If you want to synchronize the */data* folder *from* your instance *onto* your local computer, and save the copy in folder *dataCopy*:    
    ```rsync -av ubuntu@NNN.NNN.NNN.NNN:/data/ dataCopy/```    
    This is what you do when you **backup** the data on your instance onto your local computer.

* If you want to synchronize a folder *dataCopy* from your local computer *onto* your instance, and save it there in the folder */data*:     
    ```rsync -av dataCopy/ ubuntu@NNN.NNN.NNN.NNN:/data/```    
    This is what you do to **restore** the data, or if you changed something in your *dataCopy* folder (e.g. edit a file) and want to apply the changes on your NeCTAR data copy as well.

{% BgBox important %}
**Caveat:** You have to make sure the source and destination directory specifications in the command end with a slash *"/"* in order to get the expected synchronization behaviour (otherwise a new directory will be created in the destination directory instead).
{% endBgBox %}

{% BgBox info %}
The **-a** option in the command stands for "archive" --- it synchronizes *recursively* (meaning it includes sub-directories) and preserves symbolic links, special and device files, modification times, group, owner, and permissions.

The **-v** option means "verbose" and prints out status messages while the command is working.

You may also be interested in using the option **-z** if you have large amounts of data to be backed up. This option **compresses** the data for transmission, which can speed up the backup process. 
The amount of compression that can be achieved depends on the type of data being transferred, e.g. text files can be compressed efficiently, whereas binary files can't be reduced much in size.
To use compression:    
```rsync -avz <source directory> <destination directory>```
{% endBgBox %}



There are other tools related to or similar to *rsync*, for example [rdiff-backup](http://www.nongnu.org/rdiff-backup/) or [rsnapshot](http://www.rsnapshot.org/) which you may be interested in.
For more information about *rsync*, please refer to the man pages:

```man rsync```

or visit the [rsync website](https://rsync.samba.org/). There are also many tutorials for rsync which you can find online.

{% BgBox info %}
If your private key is not in the directory *.ssh* and you don't have an ssh agent (or you are using Mac OSX which may not use *.ssh* as default), you will get a *Permission denied* error. Then, you need to specify the private key manually:

```rsync -av -e '-i <path-to-private-key>' <source> <destination>```

You have to specify the path to the private key in full, not using abbreviations such as **~**.
{% endBgBox %}

#### Working example

Lets try this out. First, make sure your Volume is attached to your instance and *mounted* on any directory, say for example */data*.
Then go to your **ssh terminal** and create a file in your instances */data* directory:

```nano /data/testFile.txt```    

Write some text into the file, for example *"This is my instance text file"*, and close the editor with *Ctrl+X*.

Now, go to the **terminal commanding your local computer** and type (replacing N's with your instances IP address):
    
```rsync -av ubuntu@NNN.NNN.NNN.NNN:/data/ dataCopy/```    

List the contents of your current directory:

```ls```

and you will see that now there is a folder *dataCopy*. List the contents of it:

```ls dataCopy/```

and you should see that the file *testFile.txt* is there now. Open it, and *add* something new after the content you wrote in there before (e.g. *"This is a line added on my local computer"*):

```nano dataCopy/testFile.txt```

and exit the editor with *Ctrl+X*. You have just edited the *copy* of the file which you synchronized onto your local machine earlier! We want to apply the same changes on the file on the NeCTAR storage as well. So synchronize the two folders again, this time specifying your local directory *dataCopy* as *source folder*:

```rsync -av dataCopy/ ubuntu@NNN.NNN.NNN.NNN:/data/```

Now, you can switch back to your **ssh terminal** to your instance and check that the changes also have been applied there: 

```nano /data/testFile.txt```

The text you added earlier should be visible here as well.

While you will only need to perform the first *rsync* command to create a **backup**, it is also nice to know that you can do it the other way round, in case you change something on your local copy of the data and then want to apply the changes on your instance as well. 
In case you need to **restore** your data, you will do the same thing.



### Unix *dd* utility 

[Dd](https://en.wikipedia.org/wiki/Dd_(Unix)) is a low level command line utility that you can use create an *Image* of a volume. It is essentially a low level *byte-for-byte* copy utility. 
*Dd* is installed by default on most Linux distributions (on Ubuntu/Debian as part of the *coreutils* package) and on Mac OSX. 


Because dd is a lower-level backup tool, you need to have *sudo* privileges to perform a backup.  

To back up a partition or a volume which is attached on */dev/vdc* into an *Image file* called *volumeBackup.dd*, from the **ssh terminal** type:

```sudo dd if=/dev/vdc of=./volumeBackup.dd```

This process can take quite some time depending on the size of your volume.
After the command has finished successfully, type    
```ls```    
to reveal that now you have a file *volumeBackup.dd* in your current directory. You now can copy this image file to any place you consider "safe", e.g. a server in your research organisation. You may use  the instructions given [here in Module 7](/package07/sections/copyFiles.html) to download the backup file *volumeBackup.dd* from your NeCTAR instance.

When you want to **restore** a volume state you need to have the *.dd* image file on your NeCTAR instance again. 
To restore a volume/partition from the same file:

```sudo dd if=./volumeBackup.dd of=/dev/vdc```

{% BgBox important %}
When restoring the backup, the volume or partition needs to be the **same size** as the one you took the image from, so this limits your options in case of a restore. 
{% endBgBox %}

The advantage of this method is that it is easy to use and it takes a **1:1 copy of your volume**, preserving *everything* like file system, persmissions, etc. The disadvantage is that backups are not incremental (like *rsync*) and each image file takes up the **entire size of the volume** --- if your volume is 50GB, but you only use 1GB on it, the image file will still use 50GB. If you want to maintain several backups (e.g. snapshots of various stages of the volume state) and you have large volumes, *dd* is probably not the right choice.

### BackupPC

[BackupPC](http://backuppc.sourceforge.net/index.html)
is a *web-based* system for managing backups of Unix, Linux, Windows and and Mac OSX computers. It allows you to configure automated *backup schedules* and offers a web-based interface which you can use from any computer to configure your backups.
It can transfer *tar* archives over *ssh* or *nfs*, or use *rsync* (amonst other options). The backups are stored **incrementally** on a *backup server*.

The big advantage is that once you have the backup server running, you get a graphical web interface to configure your backups, and you can **create automated schedules** for your backups, so you don't have to regularly do this manually. You can still use BackupPC to run *manual* backups as well.

The disadvantage is that you need a dedicated **backup server** which runs BackupPC. This server may also be a virtual machine. Maybe your research organistaion can provide you with access to a server on which you can install BackupPC.      
Another drawback is that while you can use BackupPC to back up *several* instances, unfortunately it will back up the *same* folder on *all* of them, e.g. */data*. So all your instances must have a */data* folder (or any other that you specify), and it has to be *mounted* on the instance at the time the Backup happens.

{% BgBox info %}
Launching a separate instance on NeCTAR to handle the Backups of another NeCTAR instance is also possible. However, it contradicts the aim of having backups at a physically different locations --- you would not even know if your Backup Volume is on the same hard drive as the Volume to be backed up. If that harddrive fails, or the whole data center burns down, all your backups are affected just as the original Volume. However you may only want additional *copies* of your data (at several stages of development), in which case BackupPC may still be an interesting option for you.
{% endBgBox %}

It takes a bit of work to set up BackupPC, because you have to set up the server, and configure the Apache Webserver on it accordingly. But it is not a complicated process. Refer to the [official documentation](http://backuppc.sourceforge.net/faq/BackupPC.html) or check out [this tutorial on digitalocean](https://www.digitalocean.com/community/tutorials/how-to-use-backuppc-to-create-a-backup-server-on-an-ubuntu-12-04-vps) or [this page on archlinux](https://wiki.archlinux.org/index.php/BackupPC) for detailed instructions on how to set it up. 


In this tutorial, only a quick *HowTo* is provided. On your backup server (ssh terminal to it):

1. ```sudo apt-get install backuppc```     
   This will install BackupPC and its dependencies (including apache) and also create a unix user *backuppc* which will be used to run BackupPC.    
   Follow the installation wizard in the terminal: Choose 'OK' (hit Tab if OK is not selected), select 'Local only', and set 'System mail name' to *localhost*; Confirm other messages with 'OK'. The last message will display a generic password for the user *backuppc*, but you can set this separately later.

2. You may want to change the password to something you may remember. Set password for the *user* and for the *web access*:    
    ```sudo passwd backuppc```    
    ```sudo htpasswd /etc/backuppc/htpasswd backuppc```

3. Restart apache    
   ```sudo service apache2 restart```    


5. Generate a ssh key pair (with default name *id_rsa*, and **no passphrase**) for backup purposes only. Put the private key into the */var/lib/backuppc/.ssh* directory, with the user *backuppc* being the owner of the key. Then, put the *public* key into the *authorized_key* file of *all* your instances you wish to back up. One way to do all this:    
    ```cd .ssh```    
    ```ssh-keygen -t rsa```    
    ```sudo mkdir /var/lib/backuppc/.ssh```    
    ```sudo cp id_rsa /var/lib/backuppc/.ssh/```    
    ```sudo chown -R backuppc.backuppc /var/lib/backuppc/.ssh/```    
    ```sudo chmod -R 700 /var/lib/backuppc/.ssh/```    
    Copy the public key onto any instance you want to back up. Because you are using a new set of ssh keys, the easiest is if you just copy the file onto your local computer, and then onto the target instance. From your **local computers terminal**:     
    ```scp <user-backup-srv>@<IP-backup-srv>:.ssh/id_rsa.pub Backup_Key.pub```    
    ```scp Backup_Key.pub ubuntu@<IP-of-your-instance>:.ssh/```    
    Logon to your **NeCTAR instance** (the one to be backed up) via ssh. In the ssh terminal, copy the public key into *authorized_keys*:    
    ```cat .ssh/Backup_Key.pub >> .ssh/authorized_keys```    
    Switch back to your **backup server ssh terminal**, and test if you can connect to your ubuntu instance:    
    ```su - backuppc```    
    ```ssh ubuntu@<IP-of-your-instance>```    
    You should now be logged on to your NeCTAR instance. Log out again    
    ```logout```    
    and exit the *backuppc* logon shell:     
    ```exit```
6. Your BackupPC web interface will now be available on your webbrowser at the URL    
    ```<IP-of-Backupserver>/backuppc```     
    The user name is *backuppc* and the password the one you specified with the *htpasswd* command earlier (*Note:* Use Firefox! There may be problems with the Chrome browser).

7. Please refer to the online documentation mentioned earlier for further steps to set up your backups --- only one thing to be noted here: In the **Xfer** Tab of the main configuration editor, you have to replace *root* by *ubuntu* in the following fields: *RsyncClientCmd*, *RsyncClientRestoreCmd*.  This is because we use the **user *ubuntu* instead of _root_** to log on to the instance.  The *XferMethod* should be *rsync*, unless you specifically choose to use another option. Set the *RsyncShareName* to */data* (or to the folder you mounted your volume or ephemeral drive to). Click "Save" to confirm.




### Other tools for Volume backups

There are a large number of tools for backup and restore which you may want to look into if the tools described in this section do not meet your requirements. 

Examples include:


* You may use a **secure copy (scp)** command or a **secure FTP client** to copy your data manually to your local machine. 
This has been described [here in Module 7](/package07/sections/copyFiles.html).
Before you do this, you should create a *zip* or *tar* archive of all your files, so you only need to copy across one file:     
    ```tar -czf <NameOfArchive>.tgz <list of your files or folders>``` 

* The [dump and restore](http://dump.sourceforge.net/) command line utilities provide you the ability to backup and recover your data.
They support full and incremental modes. Backups can be saved as a file, or directly uploaded to a server that supports the remote tape protocol (rmt). It is possible to restore an entire file system, or restore in *"interactive"* mode and manually select individual files to restore.
Detailed instructions are out of scope of this tutorial. 

* [Duplicity](http://www.nongnu.org/duplicity/) is a simple command line utility which supports *encrypted and compressed, full or incremental* backup of a directory tree. The attractive thing about Duplicity is that the backups can be made to many types of storage, including scp, sftp, ftp, rsync, Amazon S3, Google Cloud Storage, Dropbox, OpenStack Object Storage, and more.
For more information, refer to the [duplicity man pages](http://duplicity.nongnu.org/duplicity.1.html).

* [CloneZilla](http://clonezilla.org/) is a free partition and disk imaging/cloning program, similar to the commercial [Ghost](https://en.wikipedia.org/wiki/Ghost_(software)). 

* This [archlinux wiki](https://wiki.archlinux.org/index.php/Backup_programs) provides a good overview of many other Backup tools.


