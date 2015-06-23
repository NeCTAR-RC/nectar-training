---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


For several reasons discussed earlier, you may want to encrypt your file. We can broadly distinguish two types of file encryption: 1) encrypting an entire volume and 2) encrypting individual files. 

Object storage (discussed in [Module 6][ModDoc6]) is very useful for ease of access and data integrity.  Because several copies of your data is kept, availability is very good: The NeCTAR Object Store is geo-distributed across Nodes of the Research Cloud so that availability is not reliant on any one datacentre or network infrastructure. *Only you* have access to your object store using your OpenStack credentials, so only you can select files to download, or upload files to a container. 

While *access* to your account is secure, the *transfer* of your files via the network is not: When you upload and download files, it happens via an unencrypted connection. At the time when you download or upload your files, and the individual files are wired through the Internet, somebody could catch the data you are just transferring. Also, when your files are replicated across NeCTAR nodes, this happens without encryption.
{% col 255,0,0 %} (Verify this ! This should be the case though:  [http://docs.openstack.org/security-guide/content/object-storage.html](http://docs.openstack.org/security-guide/content/object-storage.html) Figure 9.2)
{% endcol %}
The critical point is the moment of *data transfer*. 
{% BgBox info %}
Extensions to *OpenStack* (the cloud software that NeCTAR is using) for object storage data encryption have been proposed and will probably be available at some point.
{% endBgBox %}

For this reason, you may want to encrypt sensitive data before you upload it to the object storage. With the Object Storage, you upload individual files, so you should do a **per-file encryption**. 

If you want to protect your data on a Volume against *breaches* (someone gaining access to your volume), you may want to do an entire **volume encryption** on the volume which you have attached to your VM. 

There are many tools for data encryption available. Not all of them support both per-file *and* whole volume encryption. When choosing a tool for encryption, it is also important that the encryption algorithm used by the tool is secure and cannot be hacked easily. 

In this section, we will go through a few example tools for file and volume encryption.

## File encryption

In the following we will discuss the following tools which support per-file encryption:

* GnuPG

* AESCrypt

* Encrypted zip file

* Mac: Disk Utility

{% col 255,0,0 %}
TODO: Insert internal document links
{% endcol %}

Other widely known tools which have recently received bad security audits (e.g. *EncFS, OpenSSL, TrueCrypt*) are not discussed in this course.

{% col 255,0,0 %}
TODO: Insert screenshots for all the tools
{% endcol %}

#### GnuPG

*GnuPG* is an implementation of Pretty Good Privacy (PGP). PGP has excellent security: 

> "To the best of publicly available information, there is no known method which will allow a person or group to break PGP encryption by cryptographic or computational means."     
-- source: [Wikipedia](http://en.wikipedia.org/wiki/Pretty_Good_Privacy#Security_quality). 

*GnuPG* is open-source and accessible through a variety of different clients and tools. New versions of PGP are released periodically and vulnerabilities are fixed by developers as they come to light. There is a simple command line interface, but there are also [many graphical interfaces]( https://www.gnupg.org/related_software/frontends.html) available which are more popular. 

The [official releases](https://www.gnupg.org/download/) can encrypt 

* files 

* entire volumes

* Disk images

* External drives 

* E-mails

* and more.  

All *GnuPG* tools support multiple encryption types and ciphers.

*GnuPG* works very well on almost all 32 and 64 bit platforms. It has mainly been developed for Unix systems, but binaries available for **Windows, OS X, Debian/Ubuntu, Android and more** provided (with no guarantee that binary versions provided are current). Mac users may be interested in [GPGSuite](https://gpgtools.org/gpgsuite.html). 

*GnuPG* is easy to use and if you keep your private key and the passphrase secret, it is a very secure way to encrypt files. *GnuPG* also has the advantage that no passwords will appear in any script files if you use your private key to encrypt files.

#### AESCrypt

[AESCrypt](https://www.aescrypt.com/) is a free, open-source tool which is available for Mac, Linux and Windows. It provides a secure way to **encrypt individual files**, using the industry standard Advanced Encryption Standard (AES).

*AESCrypt* is easy to use: On **Windows**, you only right-click on a file, select AES Encrypt (or Decrypt) and enter a password. On a **Mac**, you drag the file into the *AESCrypt* program and type in the password. On the **Linux** command line, you may use the command aescrypt along with the name of the file and the password.

The [AESCrypt website](https://www.aescrypt.com/) provides an excellent documentation on how to set up and use *AESCrypt*.

#### Encrypted zip file

Zip files can be password-protected, but the standard Zip encryption scheme is extremely weak. If your operating system has a built-in way to encrypt zip files, you probably shouldn’t use it. You should use *AES-256* encryption. The tools discussed in the following do support *AES-256* encryption.

Zip files are archives containing individual files, so this cannot be used to encrypt entire volumes.

{% BgBox important %}
The older zip encryption is not secure! Several tools can create encrypted zip files (the older, insecure version). 

For example,

* On **Windows**, you can right-click on a file and select **Compress...** to create a zip archive.

* On **Linux or Mac**, this can be done via command line:    
    ```zip -0 -e backup.zip <yourfile>```    
    The option **-0** means "store only" and don't compress --- this is faster. **-e** means encrypt archive.    
It will ask for the password.


This is ***not secure!*** 

Use the more secure methods described in this section.

{% endBgBox %}



**Windows: 7-zip**

[7-zip](http://www.7-zip.org/) is great for compressing files and is also a strong file encryption tool. It's free even for commercial use and supports *256-bit AES* encryption. The official download is Windows only, but there are also unofficial Linux and OS X versions.

In *7-Zip*, you can select files in the Windows Explorer window, right-click and select **7-Zip > Add to archive**. You should make sure to select the *Add to archive* option in order to encrypt the file. You will be given the option to set a password, make sure you select one! Alternatively, you can open the *7-Zip* application and create the archive from there.

{% BgBox important %}
*7-Zip* will create a *7z* archive by default, but you can also choose *Zip*. If you *do* opt to go with Zip, be sure to select the *AES-256* encryption method instead of the weaker *ZipCrypto* method. 
{% endBgBox %}

**Mac: Keka**

With [Keka](http://www.kekaosx.com/), you compress individual files by dragging and dropping them to *Keka* in the Dock. You may drop multiple files at once, and they will be compressed as one zip file. You can get *Keka* from the Mac App Store, here is good documentation on the website on how to use it.

{% BgBox important %}
*Keka* creates encrypted *7z* files.By default, the *7z *files will be encrypted using *AES-256*, which is secure. If the selected format is *Zip*, *Zip 2.0* legacy encryption will be used, so this is not recommended!
{% endBgBox %}

**Linux: p7zip**

The file explorer on your Linux desktop can be used to create encrypted *7z* archives. You first need to install the *p7zip-full* package (it may also simply be called *p7zip* on some Linux distributions). Installing *p7zip-full* allows your file explorer encrypt your files or folders in the *7z* compression format. You may find it in your package manager, e.g. on Ubuntu

```sudo apt-get install p7zip-full```

Then, open your file explorer, right click on the file and select **Compress...**. Be sure to select *7z* as a format! In the window that comes up, expand **Other Options**, tick **encrypt the file list too** and type in your password.

You may also use *p7zip* in the command line. The command is simply called *7z*. Refer to the man pages for usage.

{% BgBox important %}
*p7zip* does not store the owner and group of a file. So if you want to use it for backup purposes (or for other reasons want to preserve owner/group), you should pack your files in a *tar* archive first, and then encrypt the tar archive with *p7zip*.

To create a tar archive:

```tar -cf <tar-file-name>.tar <list of your files or folders>```

To extract a tar archive:

```tar -xf <tar-file-name.tar>```

Then, compress the tar archive file with *p7zip* as described.
{% endBgBox %}

### Volume encryption on Ubuntu

Because we base our instances in this course on Ubuntu, we shall also include instructions on how to encrypt a volume in your Ubuntu virtual machine.

In [Module 7][ModDoc7], we have seen how we can use our secondary disk of our ephemeral storage to store our data (the secondary disk is essentially a volume storage which is included with the intance). We have also created a Volume storage and attached it to our instance. In both methods we have *mounted* the disk so that we can access it.    
This type of disk is suitable for Volume Encryption. You can encrypt the whole block of storage, and all files which are written on it will automatically be encrypted. Files on it will be unreadable to others which may gain access to it, even after you delete your storage (or discard your instance).

You can think of volume encryption as happening in the background: You unlock it once with the password, and then use the drive as usual: editing, copying and moving files on it. All programs can access the drive as usual, and Ubuntu takes care of automatic encryption and decryption in the background. 

{% BgBox important %}
Before you decide to encrypt your Volume, you should consider carefully whether you want to do this. While encrypting the data **adds security** in terms of preservation of privacy, it also **incurs new risks**: If you ever forget your password, access to your data will be lost forever. It may also introduce difficulties with manual data recovery. You should also take into account that performance of reading and writing to your Volume will degrade with the encryption.
{% endBgBox %}



{% BgBox info %}
You may wonder whether you will also be able to copy data onto the encrypted from remote, for example using the *scp* command or an *sftp client*.

You can access the drive from remote as usual. This is because the file server on your instance (e.g. the scp server) takes care of transferring the files to your remote computer after you have requested them. Programs running on Ubuntu (including the file server) can read the files from the drive as usual, because Ubuntu automatically takes care of the encryption/decryption in the background. 

For this reason, you can access the files, even though they are encrypted on the actual harddrive. 

Note however, that if *you* can copy and read the files as usual from remote, so can *everyone who may gain access* to your private ssh key and passphrase! The volume encryption mainly serves as security in case the physical hard-drive gets stolen, or hacked into from outside your VM -- then, nobody can ready your data, because they would have to type in your volume encryption password first.
{% endBgBox %}


In the following, we will go through the steps required to encrypt your Volume storage on your ubuntu instance.We will use a standard procedure on Linux to encrypt drives with the **Linux Unified Key Setup (LUKS)**. 

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

3. If you have data on the volume, now is a good time to securely erase them. We will talk about securely erasing all data in [Module 9][ModDoc9]. If in doubt, you should use an empty (newly created) volume for this tutorial. You can skip this step if you don't have data to securely erase --- a process which may take a long time depending on the size of your volume.  Erase your data with:    
```sudo dd if=/dev/urandom bs=1M count=8 of=/dev/vdc```    
    *Note:* Volume 9 explains more about how it can be sped up.

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

6. Now you can map your encrypted drive to a virtual drive with the following command (You may replace *MySecureDrive* with any name you want to assign to the drive):    
```sudo cryptsetup luksOpen /dev/vdc MySecureDrive```    
    This will ask for the volume encryption password which you just chose. After the command has been executed, your drive will be mapped to */dev/mapper/MySecureDrive* (or other name instead of *MySecureDrive*, if you changed this in the command above).

7. Now it is time to format your drive (again, replace *MySecureDrive* with your name, if you have chosen another).    
    ```sudo mkfs.ext4 /dev/mapper/MySecureDrive```

8. That’s almost done! Now we can mount the drive to any directory. In this example, we will create a new one */myMount*, but you can choose any other directory:    
     ```sudo mkdir /myMount```    
    ```sudo mount /dev/mapper/MySecureDrive /myMount```

9. *Optional:* By default, you do not have write permissions on the secondary drive. We discussed how to change write permissions in [Module 7][ModDoc7]. Here a brief reminder: You can do this either with    
    ```sudo chown ubuntu /data```    
    to allow access only to yourself, or    
    ```sudo chgrp ubuntu /data```    
    ```sudo chmod g+rwx /data```    
    to allow access to your whole user group.

**You are all done!**

You can now use this drive as normal without worrying about encryption, and your data is securely encrypted.

To unmount and free up the volume, type the following commands:

```sudo umount /MyMount```   
```sudo cryptsetup luksClose MySecureDrive```

After every reboot of your instance, you will have to unlock the drive by typing in your password and mount the drive again:

```sudo cryptsetup luksOpen /dev/vdc MySecureDrive```    
```sudo mount /dev/mapper/MySecureDrive /MyMount```



Well done! You are now finished with [Module 8][ModDoc8] and can continue with [Module 9][ModDoc9].
