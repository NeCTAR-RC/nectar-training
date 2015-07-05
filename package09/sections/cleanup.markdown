---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

{% BgBox prerequisite %}
*Prerequisite:* You should be familiar with all the storage terminology discussed in [Module 6](/package06/sections/storage.html) and [Module 7](/package07/sections/manageStorage.html). You must know how to *mount* your secondary ephemeral drive on your instance, and how to *attach* and *mount* a Volume to your instance.

Some basic command line usage skills are helpful for this section as well.
{% endBgBox %}


It is important that you **take responsibility** and have your instance and volume storage up and running **only** when you really need it, otherwise your resources will sit idle, and you will be using up the resources that other researchers may need. 

In the last sections you have learned how you can take Snapshots of your instances and easily re-launch them when you need them again; you can also take an Image of your Volumes and create backups to re-create the state of your Volume at a later time. Once you have your instance and data backed up, you are free to *terminate* your resources and free them up for others. 

Before you free up the resources, you should make sure that you **securely erase all the data** on your volumes, to make sure nobody will be able to restore the data on the section of the hard-drive you were using. This section will show how you can securely erase data, and then **terminate your instances and volumes** so that the resources are freed up for other researchers.


### Securely ereasing data

Just removing all files from your secondary ephemeral drive or your Volumes won't do the job --- this just removes the index of the files (think of it like a table of contents), but the actual bits of the files will still be on the harddrive, so it is possible to restore them when using special tools. To definitely erase the data, you have to *overwrite* the bits with other (random) bits. You even have to repeat the overwriting several times to be sure nothing can be recovered. Some people even argue the only way to really, really ensure the data is erased is to burn up the hard drive --- an option we don't have in this case, so we will have to be satisfied with overwriting the data several times.

If you are really concerned that overwriting your data several times may still not be enough, then **encrypt your volume**, as described [here in Module 8](/package08/sections/encryption.html), and then securely erase it afterwards. Even if someone was able to restore the data, it would be the encrypted data --- and they would still need your key!

{% BgBox important %}
Before you start erasing data, make sure that you **unmount** the drive from your instance!
{% endBgBox %}

#### Using *dd*

Using the *dd* unix command line utility, wiping your disk is easy. Say your *device location* is your volume */dev/vdc*, or your secondary ephemeral storage */dev/vdb*, you can securely erase it with the *dd* command (we already encountered *dd* in the last section):

```sudo dd if=/dev/urandom of=<device file> bs=4K```

{% BgBox important %}
Warning: This command will start erasing all data as soon as you start running it, with no further confirmation. Check that the correct drive or partition has been targeted: the of=... option has to point to your volume or ephemeral disk you want to erase. It should *not* point to a system disk!
{% endBgBox %}

{% BgBox info %}
The option **bs** means *block size*, which is the number of bytes that are written at one time. The command is faster if you choose the block size used by your physical harddrive --- in case of doubt, just use *4k*. You may specify the size in bytes, or in *kilobytes* by appending *k*, or in Megabytes by appending *M*.
{% endBgBox %}


The process may take quite a while. It is finished when dd **reports the error** *"No space left on device"* (this is technically an error because **dd** tries to write beyond the end of the disk, which it cannot.
{% BgBox terminal %}
$ sudo dd if=/dev/urandom of=/dev/vdc bs=4K iflag=nocache oflag=direct
dd: error writing ‘/dev/vdc’: No space left on device
262145+0 records in
262144+0 records out
1073741824 bytes (1.1 GB) copied, 293.366 s, 3.7 MB/s
{% endBgBox %}

Now if you wanted to be even more sure your data is erased, you repeat this process several times.

After you have erased your disk, everything will be wiped --- also the file system. If you wanted to re-use the volume, you have to format it again, as described in [Module 7](/package07/sections/manageStorage.html).

To speed up the process, you may also overwrite the data with *only zeros* instead of random data (it is faster because the random generator can be switched off). This is a little less secure:
while this will render any data irrecoverable by software, it still may be recoverable by [special laboratory techniques](https://en.wikipedia.org/wiki/Data_remanence). However for this, somebody would need to break into the NeCTAR data center, identify the section of the hard drive you have been using, and undergo significant efforts to restore your data, with no guaranteed outcome --- unlikely! So let's speed up the process:

```sudo dd if=/dev/uzero of=<device file> bs=4K iflag=nocache oflag=direct```

{% BgBox info %}
Options **iflag** and **oflag** will try to disable buffering, which does not make sense in this case of a constant stream of zeros. The options should speed up the process.
{% endBgBox %}

#### Using *shred*

The [shred](https://en.wikipedia.org/wiki/Shred_(Unix)) command line utility also provides a means to securely erase data. It is installed by default on most Linux distributions (e.g. on Debian/Ubuntu as part of the *coreutils* package).
It is argued that *shred* is not as secure as the above *dd* command --- shred securely deletes data, but in theory it can be recovered, albeit only with great difficulty using specialised hardware, if at all. 

To run *shred* with its default settings (overwrite with random data in 3 passes) to erase your device mapped on *device file* (e.g. */dev/vdc*):

```sudo shred -v <device file>```

The option **-v** means *"verbose"*, it will print information while the process is ongoing. For overwriting with zeros instead of random data (which is faster but less secure), add the option **-z**.

Shred also allows specification of a particular file instead of *&lt;device file&gt;*, but *this is not secure on journaling file systems* (which most modern Linux file systems are)! Be sure to choose your device mapping file.

Shred by default uses three passes (overwriting your data three times), writing pseudo-random data. 
Alternatively, shred can be instructed to do *X* number of passes with the same random source as used in the *dd* command described earlier:

```sudo shred -v --random-source=/dev/urandom -n<X> <device file>```

For example, say you want to erase your drive attached to */dev/vdc*, use 5 passes and random data:

```sudo shred -v --random-source=/dev/urandom -n5 /dev/vdc```

After you have erased your disk, everything will be wiped --- also the file system. If you wanted to re-use the volume, you have to format it again, as described in [Module 7](/package07/sections/manageStorage.html).

For more details on the *shred* utility, refer to the man pages:

```man shred```


### Terminating an instances and Volumes

Deleting your instance or volume and thereby freeing up resources for others is also called *terminating* your instance or volume. This can be done easily in the Dashboard.

To terminate an instance, first make sure you have securely erased the data on the secondary ephemeral disk which you may have used (probably on */dev/vdb*). Then, go to *Dashboard > Compute > Instances* and find the instance you want to terminate in the list. On the right-hand side drop-box next to the instance, select *Terminate instance*.

{% BgBox important %}
You must *detach* any Volumes from your instance before terminating it --- There may be problems if you terminate an Instance while it has Volumes attached. Recovering your volume requires the NeCTAR technical staff to manually patch a database.
{% endBgBox %}

To delete a Volume, *after* you have securely erased your data, go to *Dashboard > Compute > Volumes* and find the volume you want to delete in the list. In the right-hand side drop-down menu, select *Delete Volume*.


**Congratulations!!!**

You have now learned how to back up your data and release it securely for other researchers.

Continue with [Module 10][ModDoc10].
