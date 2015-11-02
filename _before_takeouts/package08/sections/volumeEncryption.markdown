---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


Because we base our instances in this course on Ubuntu, we shall also include instructions on how to encrypt a volume in your Ubuntu virtual machine.

In [Module 7][ModDoc7], we have seen how we can use our secondary disk of our ephemeral storage to store our data (the secondary disk is essentially a volume storage which is included with the intance). We have also created a Volume storage and attached it to our instance. In both methods we have *mounted* the disk so that we can access it from our instance.    
Disks which are *mounted* on the instance are suitable for Volume Encryption. You can encrypt the whole block of storage, and all files which are written on it will automatically be encrypted. Files on it will be unreadable to others which may gain access to it, even after you delete your storage (or discard your instance).

You can think of volume encryption as happening in the background: You unlock it once with the password, and then use the drive as usual: editing, copying and moving files on it. All programs can access the drive as usual---Ubuntu takes care of automatic encryption and decryption in the background. 

{% BgBox important %}
Before you decide to encrypt your Volume, you should consider carefully whether you want to do this. While encrypting the data **adds security** in terms of preservation of privacy, it also **incurs new risks**: 

* If you ever forget your password, access to your data will be lost forever. 
* It may also introduce difficulties with manual data recovery. 
* You can only unlock your drive using the same encryption algorithm/tool.
* You should also take into account that performance of reading and writing to your Volume will degrade with the encryption.
{% endBgBox %}



{% BgBox info %}
You may ask yourself whether you will also be able to copy data onto the encrypted drive from remote, for example using the *scp* command or an *sftp client*.

You can access the drive from remote as usual. This is because the file server on your instance (e.g. the scp server) takes care of transferring the files to your remote computer after you have requested them. Programs running on Ubuntu (including the file server) can read the files from the drive as usual, because Ubuntu automatically takes care of the encryption/decryption in the background. 

For this reason, you can access the files, even though they are encrypted on the actual harddrive. 

Note however, that if *you* can copy and read the files as usual from remote, so can *everyone who may gain access* to your private ssh key and passphrase! The volume encryption mainly serves as security in case the physical hard-drive gets stolen, or hacked into from outside your VM -- then, nobody can ready your data, because they would have to type in your volume encryption password first.
{% endBgBox %}


In the following, we will go through the steps required to encrypt your Volume storage on your Ubuntu instance. We will use a standard procedure on Linux to encrypt drives with the **Linux Unified Key Setup (LUKS)**. 

*Tipp:* You can use the same instructions below to encrypt your external USB Drives from a Ubuntu system. However, note that your USB drive will most likely then only be readable from a Linux system!


{% BgBox important %}
Following the instructions will **erase all data** on the volume! If you have any files on it, make sure to back them up first.
{% endBgBox important %}

1.  Find out the device name of your volume (e.g. */dev/vdc*). You may for example use   
    ```sudo lsblk -l``` and/or     
    ```sudo lsblk -f```    
    to print information about your drives. You can also see it on the Volumes overview in the Dashboard.    
    The following will assume your drive is located at **/dev/vdc**. If your is at another path, you will have to replace this in the following commands.    

2. Ensure your volume is **attached** to your instance, but **not mounted**.    
    Find out if your volume is mounted:     
    ```mount | grep vdc```    
    If it is, *unmount* it with    
    ```sudo umount /dev/vdc```

3. If you have data on the volume, now is a good time to securely erase it. We will talk about securely erasing all data in [Module 9][ModDoc9]. If in doubt, you should use an empty (newly created) volume for this tutorial. You can skip this step if you don't have data to securely erase --- a process which may take a long time depending on the size of your volume.  Erase your data with:    
```sudo dd if=/dev/urandom of=/dev/vdc```   
   *Note:* [Module 9](/package09/sections/cleanup.html) provides more information about the *dd* command. 

4. Now, install the file encryption package cryptsetup:    
    ```sudo apt-get install cryptsetup```    
    ```sudo modprobe dm-crypt```    
    From now on, every time you restart your machine, the encryption software should start up automatically.

5. Now you can encrypt your Volume:    
```sudo cryptsetup luksFormat -c aes-xts-plain64 -s 512 -h sha512 -y /dev/vdc```    
It will ask you to confirm that you really want to do this, as all data will be erased. You should confirm this with typing **"YES"** (it needs to be *uppercase*! Or the command will do nothing).     
    You should then be prompted for a password -- make sure to choose a secure password, otherwise the encryption will not be secure!    
    {% BgBox info %} The parameter **-c** is used to select the algorithm.  **-y** ensures that you are asked to verify the password, which is always a great idea, in case you have a typo in your first try. **-s** determines the length of the key --- 512 actually corresponds to 256 bit encryption. The reason is that the maximum length of 256 bits is used for *both* *AES* and *XTS* encryption. The more bits are used for encryption, the more it will affect performance. If you would like to trade off a bit of security against performance, you can use *-s 256* instead, which then corresponds to 128 Bit encryption.
{% endBgBox %}

6. Now you can map your encrypted drive to a virtual drive with the following command (you may replace *MySecureDrive* with any name you want to assign to the drive):    
```sudo cryptsetup luksOpen /dev/vdc MySecureDrive```    
    This will ask for the volume encryption password which you just chose. After the command has been executed, your drive will be mapped to */dev/mapper/MySecureDrive* (or other name instead of *MySecureDrive*, if you changed this in the command above).

7. Now it is time to format your drive (again, replace *MySecureDrive* with your name, if you have chosen another).    
    ```sudo mkfs.ext4 /dev/mapper/MySecureDrive```

8. That’s almost done! Now we can mount the drive to any directory. In this example, we will create a new one */MyMountedDriveedDrive*, but you can choose any other directory:    
     ```sudo mkdir /MyMountedDriveedDrive```    
    ```sudo mount /dev/mapper/MySecureDrive /MyMountedDriveedDrive```

9. *Optional:* By default, you do not have write permissions on the secondary drive. We discussed how to change write permissions in [Module 7][ModDoc7]. Here a brief reminder: You can do this either with    
    ```sudo chown ubuntu /data```    
    to allow access only to yourself, or    
    ```sudo chgrp ubuntu /data```    
    ```sudo chmod g+rwx /data```    
    to allow access to your whole user group.

**You are all done!**

You can now use this drive as normal without worrying about encryption, and your data is securely encrypted.

To unmount and free up the volume, type the following commands:

```sudo umount /MyMountedDrive```   
```sudo cryptsetup luksClose MySecureDrive```

After every reboot of your instance, you will have to unlock the drive by typing in your password and mount the drive again:

```sudo cryptsetup luksOpen /dev/vdc MySecureDrive```    
```sudo mount /dev/mapper/MySecureDrive /MyMountedDrive```



