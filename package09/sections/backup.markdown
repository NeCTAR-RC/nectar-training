---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

Beyond that, some types of NeCTAR storage are implemented on RAID storage; see above.

Reference: NeCTAR Support Wiki: ResearchCloudStorage https://support.rc.nectar.org.au/wiki/ResearchCloudStorage#Summary

NOTE TO SELF: We want to see how we can regularly backup the data on the server, but we also want to see how we can backup the data we have on the cloud and store it locally on our computer or data center. We should be able to access our data backups locally without effort, e.g. if there is an internet outage.

In case of internet drop-outs, we need access to all data. Therefore, we want to create a backup not only for the volume storage, for object storage as well!


The secondary ephemeral disk and Volumes have one thing in common: They are "mounted" as a disk on your instance. Therefore, to back up your data, you can use some methods for both of the storage types. In this section, we will discuss a few options and tools to back up your data on the ephemeral disk and on Volumes. Some tools will only be suitable for one of the storage types.

### Backups of Volumes using OpenStack tools

OpenStack offers tools to back up your Volumes (*not* your secondary ephemeral disk). They can be used from the Dashboard, or from the command line.

There are two ways to backup your data on the volume:


1. **Volume Snapshot**: This creates a copy of your entire volume, so if the volume is 5GB but you are only using 1GB of it, the Snapshot will still have a size of 5GB. The Snapshot is stored in the Image service, you will be able to select it when you create a new volume. A volume from which Snapshots have been created cannot be deleted while any of these Snapshots still exists --- A Snapshot is *dependent* of the actual Volume. Creating Snapshots is fairly quick.

2. **Volume Backup**: Your data will be backed up and placed in the *Object Storage*. You can later restore that backup in a new volume. Only the amount of storage you are currently using is being backed up: If you only have 1GB of data on a 5GB volume, the backup will only be about 1GB. Backups are independent of the original volume once created. Backups are full copies of the Volumes, they take longer to create than Snapshots.  

The [last section](Snapshot.html) has discussed how to take a Snapshot. To make a *Backup* instead, you will need to use command line tools, as described in [Module 10](ModDoc10). Support to create Backups via the Dashboard will probably be added in the near future -- it then works in a very similar fashion to taking Snapshots.


### Rsync backups

*Rsync* is a Unix **command line tool** which maintains a copy of a local directory on a (typically) remote system, in a traditional "mirror" fashion. 
The contents of the two folders, which we call **source and destination folders are _synchronized_**. 
The source and destination folders can be on the same computer, or they could be on separate computers that are accessible over a network or the Internet.

{% BgBox info %} 
Rsync creates **incremental backups**, which means only what has changed in the directory since the last backup will be copied to the backup folder, so not every time a backup is performed all files have to be transferred again. This speeds up the backup process, especially with slow network connections.

Rsync can also **compress and encrypt data streams** during the backup process, which is important if the data being backed up has to travel through the internet to reach the server which maintains the backup copy.
{% endBgBox %}

**RSync is a good choice for you if:** you want to create a backup of the *most recent state* of your volume or secondary ephemeral drive, and save the backup on your local computer, or another computer onto which you can log on to a terminal (e.g. via a ssh shell).


The main drawbacks are:

-  it is difficult to maintain backups of multiple time points --- e.g. if you wanted to keep a backup of every week that you can restore individually later on. Rsync is more suitable to keep a backup of the *most recent state*.    

- One other issue is that if something goes wrong while the *rsync* process in ongoing, the backup will contain a mix of old and new files.

- It is a bit more complicated to set up *automated backups* (using *cronjobs*); The easiest is if you do this manually each time you want to back up your data.

#### Installation of Rsync

You will have to install *rsync* on your local computer. Alternatively, you can use another computer, as long as you can log on to a terminal of this computer (e.g. via ssh) --- then, install *rsync* on this computer instead.

* On many Linux distributions, *rsync* may already be installed. If it is not, you can install it using your package manager. For example on Ubuntu/Debian:    
   ```sudo apt-get install rsync```
* On Mac OSX, *rsync* is available by default.
* Under Windows, *rsync* can be installed as part of the [cygwin](https://www.cygwin.com/) package and used from the command line. This is a bit more compilicated, so if you are using a Windows system, *rsync* is maybe not the right choice.

You also have to make sure *rsync* is installed on your Ubuntu instance --- the image we used in [Module 7][ModDoc7] does already come with *rsync* on it.

#### Usage of Rsync

The rsync command copies files from the *source* directory to the *destination* directory, automatically using your ssh keys to encrypt the connection:

```rsync -av <source directory> <destination directory>```

Either the source *or* destination directory can be a remote directory on your ubuntu instance. For example, one directory can be the folder in which your Volume is *mounted* on your instance, which we called */data* in [Module 7][ModDoc7]. Or it can be any other folder on your Ubuntu instance.    
The other directory (source or destination) is then a directory on your local computer.

The syntax to specify a *remote* directory is *&lt;username&gt;@&lt;IP-Address&gt;:&lt;Path-to-Folder&gt;*

{% BgBox info %}
The **-a** option in the command stands for "archive" and syncs recursively (meaning it includes sub-directories) and preserves symbolic links, special and device files, modification times, group, owner, and permissions.

The **-v** option means "verbose" and prints out status messages while the command is working.

You may also be interested in using the option **-z** if you have a lot of files, as this **compresses* the data for transmission. 
The amount of compression that can be achieved depends on the type of data being transferred, e.g. text files can be compressed efficiently, whereas binary files can't be reduced much in size.

To use compression:    
```rsync -avz <source directory> <destination directory>```
{% endBgBox %}

Depending on which direction you want to do the synchronization:

* If you want to synchronize a folder *from* your instance *onto* your local computer, the *source* directory is on your Ubuntu instance, and the *destination* directory is on your local machine. For example, if you want to synchronize your */data* directory on your instance with the *dataCopy* directory on your local computer:    
    ```rsync -av ubuntu@NNN.NNN.NNN.NNN:/data/ dataCopy/```    
    This is what you can do when you want to backup the data on your instance onto your local computer.

* If you want to synchronize a folder *from* your local computer *onto* your instance, the *source* directory is on your local machine, and the *destination* directory is on your ubuntu instance. For example, if you want to synchronize your *dataCopy* directory with the */data* directory on your instance:    
    ```rsync -av dataCopy/ ubuntu@NNN.NNN.NNN.NNN:/data/```    
    This is what you can do if you change something in your *dataCopy* folder (e.g. edit a file) and want to apply the changes on your *ubuntu* instance as well.


**Caveat:** You have to make sure the source and destination directories end with a slash *"/"* in order to get the expected synchronization behaviour (otherwise a new directory will be created in the destination directory instead).

For more information about *rsync*, please refer to the man pages:

```man rsync```

{% BgBox info %}
If your key is not in the directory *.ssh* and you don't have an ssh agent (or you are using Mac OSX which may not use *.ssh* as default), you will get a *Permission denied* error. Then, you need to specify the private key manually:

```rsync -av -e '-i <path-to-private-key>' <source> <destination>```

You have to specify the path to the private key in full, not using abbreviations as ~.
{% endBgBox %}

#### Working example

Lets try this out. First, make sure your Volume is attached to your instance and *mounted* on any directory, say for example */data*.
Then go to your *ssh terminal* and create a file in your instances */data* directory:

```nano /data/testFile.txt```    

Write some text into the file, for example *"This is my instance text file"*, and close the editor with *Ctrl+X*.

Now, go to a terminal on your local computer and type:
    
```rsync -av ubuntu@NNN.NNN.NNN.NNN:/data/ dataCopy/```    

Print the contents of your current directory:

```ls```

and you will see that now there is a folder *dataCopy*. List the contents of it:

```ls dataCopy/```

and you should see that the file *testFile.txt* is there now. Open it, and add something new to the content you wrote in there before:

```nano dataCopy/testFile.txt```

and exit the editor with *Ctrl+X*. Now, you have edited the *backup* file on your local machine. We want to update the file on the instance as well, so synchronize the folders:

```rsync -av dataCopy/ ubuntu@NNN.NNN.NNN.NNN:/data/```

Now, you can go back to your ssh terminal into your instance and check that the changes also have been applied on your Volume:

```nano /data/testFile.txt```


While you will only need to perform the first *rsync* command in the example to create a backup, it is also nice to know that you can do it the other way round, in case you change something on your local copy of the data and then want to apply the changes on your instance as well.



### Dump and restore commands

The [dump and restore](http://dump.sourceforge.net/) command line backup utilities provide you the ability to backup and recover an entire system's "system state".

The *dump* and *restore* utilities can be installed from the repositories using:

```sudo apt-get install dump```

Because dump is a lower-level backup tool, you need to have sudo privileges to perform a dump.  

When you "dump" a volume, you can specify the *level* of backup you want to do. Level 0 means backup everything. A level number above 0 ("incremental backup")  tells  dump to copy all files new or modified since the last dump of a lower level. For example, if level-5 backup is invoked after level-4 backup, the files updated after the level-4 backup will be recorded to this level-5 backup archive. If in doubt, just always do a level 0 backup. 

With the "-a" option you tell *dump* to "auto-size" the file. If you specified another size, it would back up the data into several *dump files*. However because we are dumping into a local file, we are not worried about its size. The -f option specifies the location where the dump file will be written. Finally, the -u option tells *dump* to log the state of this dump in the file */etc/dumpstates*.

You can backup the volume which is mounted on */data* into a file called *volumeBackup1.dump* from your ssh terminal into the instance:

```sudo dump -0au -f volumeBackup1.dump /data```

You may also use */dev/vdc* or any other device mapping instead of */data*. 
A ```ls``` will reveal that now you have a file *volumeBackup1.dump* in your current directory. You now can copy this file to any place you consider "safe", e.g. a server in your research organisation. You may use  the instructions given [here in Module 7](/package07/sections/copyFiles.html) to download this file from your Ubuntu instance.

When you want to **restore** a dump state you need to have the *.dump* file on your Ubuntu instance again. For example, if your dump file is called *volumeBackup1.dump*:




### Other tools for Volume backups

There is a large number of tools for backup and restore available which you may want to look into, if the tools described in this section do not meet your requirements. 

Examples include:


* You may also use a **secure copy (scp)** command or *secure FTP* client to copy your data manually to your local machine. 
This has been described [here in Module 7](/package07/sections/copyFiles.html).
Before you do this, you should create a *zip* or *tar* archive of all your files, so you only need to copy across one file:     
    ```tar -czf <NameOfArchive>.tgz <list of your files or folders>``` 

* [dd](https://en.wikipedia.org/wiki/Dd_(Unix)) is a low level command line utility that you can use create an image of a volume. It is essentially a low level byte-for-byte copy utility. Detailed instructions are out of scope of this tutorial, but to give you a brief impression:      
    ```dd if=/dev/vdc of=./volumeBackup.image``` to backup a partition.    
    ```dd if=./volumeBackup.image of=/dev/vdc``` to restore.    
     When restoring the backup, the partition needs to be the same size as the partition you took the image from, so this limits your options in case of a restore. 

* [CloneZilla](http://clonezilla.org/) is a free partition and disk imaging/cloning program, similar to the commercial [Ghost](https://en.wikipedia.org/wiki/Ghost_(software)). 

### Backing up the Object Store

Last but not least, you may want to back up files in your Object Store. While files are generally well-protected against data loss due to geographical distribution of multiple copies, you may still want to keep a local backup of your files.

Probably the easiest way to keep backups of your objects is to use clients like *CyberDuck, CloudBerry* or FTP clients like *FileZilla* to copy your files across manually. This has been described [here in Module 7](/package07/sections/objectStorage.html).
