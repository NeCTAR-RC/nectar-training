


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


