---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

The most commonly used storage systems that you are probably familiar with are *filesystem storage* (commonly deployed as *Network Attached Storage*, short *NAS*) and *block level storage*. 

* *Filesystem storage* is used for transferring **individual files** over a network to or from the storage.
In a file system, files are organized in a hierarchical way, so that an individual file can be located by describing the *path* to that file. 
Network-attached storage (NAS) is a great way to share files securely among users on a network --- it works well on a local network for a large number of files, but not so well over the Internet, and managing billions of files.

* *Block storage* appears to the system and the user as **attached drives**. A *Block* is a chunk of data which may contain several files. Block storage is the type that is required for running things like databases. 

Both of these storage types do not efficiently scale up. However, block storage may still be essential to your research application (e.g. as scratch space or for databases). The principle of filesystem storage provides the base for a more scalable system, suitable for your Big Data demands: The *Object Storage* which we shall introduce in this Module.


There are three different types of cloud storage available to you on the NeCTAR Research Cloud:

* **On-Instance storage** --- this comes with your instance and is "*ephemeral"*: any files disappear when the VM is shut down. This storage is limited in size. There are two on-instance storage disks: The *primary* and *secondary* disk.

* **Volume (or block) storage** --- this is persistent, expandable storage that can be attached to a VM like one or more virtual hard disks.

* **Object storage** --- individual data files can be uploaded to the object store and accessed from the VM or from anywhere via the web (e.g. using a web browser).

The storage system is shared among instances. Not all storage is created equal, and the different types of storage differ according to performance, persistence and data safety.



This summary table provides a comparison of various data storage features.

{% img src=images/storageTypes.png, w=95, dim=percent, align=center %}

1. **Saved in snapshot**: You may save the state of your instance with a "snapshot". However a snapshot does not include all types of storage.

2. **Data Integrity**: how exposed your data is to hardware errors.

3. **Access**: there are two methods of access: either as a *BLOCK* level device (like attaching a hard drive to a computer) or *HTTP* where you use a client to *GET* or *POST* objects.

4. **Backed up**: is where there is a recoverable copy of a file available after a file is updated, deleted or damaged. Backup typically refers to maintaining a completely separate backup system, where, for example, the backup system runs nightly and takes an incremental backup of any new data.

As you can see, none of the data is backed up, so you will have to do backups yourself, which is subject to [Module 9][ModDoc9]. However, Object Storage has a high data integrity, which is a form of protection against data loss as well. We will learn more about Object Storage later in this Module. 




