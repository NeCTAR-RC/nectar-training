---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

There are three different types of cloud storage available, which will be described in more detail later:

* **On-Instance storage** - this comes with your instance and is "*ephemeral"* (any files disappear when the VM is shut down). This storage is limited in size. There are two on-instance storage disks: The primary and secondary disk.

* **Volume (or block) storage** - this is persistent, expandable storage that can be attached to a VM like one or more virtual hard disks.

* **Object storage** - individual data files can be uploaded to the object store and accessed from the VM or from anywhere via the web (i.e. via *http*).

The storage system is shared among instances. Not all storage is created equal, and the different types of storage differ according to performance, persistence and data safety.

This summary table provides a comparison of various data storage features.

<table>
  <tr>
    <td>Storage service</td>
    <td>Saved in snapshot</td>
    <td>DATA INTEGRITY(1)</td>
    <td>ACCESS(2)</td>
    <td>Backed up(3)</td>
  </tr>
  <tr>
    <td>On-instance Primary Disk</td>
    <td>Yes</td>
    <td>OK</td>
    <td>BLOCK</td>
    <td>No</td>
  </tr>
  <tr>
    <td>On-instance Secondary Disk</td>
    <td>No</td>
    <td>OK</td>
    <td>BLOCK</td>
    <td>No</td>
  </tr>
  <tr>
    <td>Persistent Volumes</td>
    <td>No</td>
    <td>Good</td>
    <td>BLOCK</td>
    <td>No</td>
  </tr>
  <tr>
    <td>Object Store</td>
    <td>No</td>
    <td>Best</td>
    <td>HTTP</td>
    <td>No</td>
  </tr>
</table>


1. **Data Integrity** how exposed your data is to hardware errors.

2. **Access** there are two methods of access: either as a *BLOCK* level device (like attaching a hard drive to a computer) or *HTTP* where you use a client to *GET* or *POST* objects.

3. **Backed up** is where there is a recoverable copy of a file available after a file is updated, deleted or damaged. Backup typically refers to maintaining a completely separate backup system, where, for example, the backup system runs nightly and takes an incremental backup of any new data.

As you can see, none of the data is backed up, so you will have to do backups yourself, which is subject to Module 9. However with the object storage, *several* copies of your data will be kept at different locations, which can be regarded as a form of backup - however this is no dedicated backup system, it is merely a means to increase availability and integrity of your data by keeping multiple copies. You don’t have to do anything to maintain the multiple copies, this is done automatically for you. Because of the distributed copies of your files, availability (data integrity) of the Object Store is the best.

## On-Instance storage

Each instance you start on the cloud comes with a certain amount of on-instance storage, which appears as two separate hard disks: The primary and secondary disk. When you launch an instance (see Module 7), you will choose a "flavour", which also determines the sizes of the two disks on the on-instance storage. In the flavour “m1.small”, you get a primary disk of 10GB. The primary disk is saved with Snapshots you make of the instance. The secondary disk is 30GB to 480GB depending on the flavour you select and your allocation. The secondary disk is *not *backed up with Snapshots!

TODO: Put in Background Info Box

*Important: *Not all flavours provide a secondary disk. At the time of writing, the following do:

Collection of images called "*standard-v2*": Starting from flavour m2. large and bigger.

Collection of images called "*standard*": Starting from flavour m1.small and bigger. 

End Background Info Box

**Important:** On-instance storage is regarded as *ephemeral*. You should treat it as scratch space and keep important data in either volumes or object store.

See also: [http://support.rc.nectar.org.au/docs/instance-storage](http://support.rc.nectar.org.au/docs/instance-storage)

## Object storage

The most commonly used storage systems that you are probably familiar with are *filesystem storage* (commonly deployed as Network Attached Storage, short NAS) and *block level storage*. Filesystem storage is used for transferring files over a network to or from the storage, whereas block storage appears to the system and the user as attached drives. Block storage is the type that is required for running things like databases. These storage types do not efficiently scale up, and it’s not easy to access the files from anywhere. Also, if the data center has an outage, access to the data is cut off. This is where object storage comes in: Object storage is made up of many distributed resources, while the storage still acts as one. It is highly fault tolerant through redundancy and *distribution *of data. It also scales up nicely, and it is easy to access your files from anywhere with a variety of devices.

Object storage targets the problem of data growth: As more and more data is generated, storage systems have to grow at the same pace. What if you try to expand a block-based storage system beyond a hundred terabytes or beyond multiple petabytes? You may hit limitations with the storage infrastructure, and managing a huge storage becomes very complex. A per-file object-based storage instead is easier to manage and can be distributed. Multiple copies of object data is stored over a distributed system. If one or more nodes fail, the data can still be made available, in most cases you as an end user will not even notice that a node was down. In most cases at least 3 copies of a file are stored.

TODO: Pub in background info box

The term *Object storage* refers to the way in which we organize and work with units of storage, called *objects*. Every object contains 1) The data 2) Metadata (contextual information, confidentiality, or anything else useful) and 3) a globally unique identifier which allows finding the data without having to know the physical location. Objects may be local (located on the same hard drive) or geographically separated – but we can find them anyway.

End Background info box

### Suitable use of object store

Object Storage is not a traditional file-system or real-time data storage system. It's designed for mostly static data that can be retrieved, leveraged, and then updated if necessary. It is independent of a particular instance and can be updated and used without having any instance running. It is designed to be redundant and scalable.

Think about that dataset comprised of 2GB files that you read in and analyse many times, but in general it doesn't change. Or the images you want to use on the cloud. Those are a couple examples of what's perfect for Object Storage. 

You may think of each file as an "object".  In general, the object store is great for data you write once and read many times, but not suitable for applications like databases. It's the safest place to put your data on the NeCTAR Research Cloud as multiple redundant copies of your data are made, and it has great performance. You can access the object store from anywhere on the internet, and data from Object Storage can be transferred to and from your instance with a variety of tools.

### Swift

Swift is the component that provides object storage for OpenStack. With your credentials, which you can download from the Dashboard, and via a URL, you can request Swift to reserve & create storage (called *containers* or *buckets*). Files can then be uploaded and accessed similarly by your running instances.

TODO: Put in background info box

The NeCTAR implementation of Swift is geodistributed across Nodes of the Research Cloud so that availability is not reliant on any one datacentre or network infrastructure. Each collection of Swift nodes/hardware is known as a *region*, which may or may not include a Swift proxy server (the Internet facing and serving component of Swift). With some Swift clients/APIs users can explicitly choose which proxy to connect to, this might be useful e.g. for speeding up writes to object storage by choosing the nearest proxy. Due to NeCTAR's Swift having multiple regions (some of which are Node private) some clients/APIs require explicit configuration of a default region, which should be "Melbourne" for most users (see e.g. the Cyberduck profile below).

End background info box

TODO: Put in "Important" Box

**Security Warning**

Swift does NOT provide encryption of the data it stores.

If you have sensitive data that requires encryption you must encrypt the data files before upload.

End "Important" box

In Module 7 we will learn a few ways how to connect to your object storage and copy objects from and to the object store. Module 8 will introduce a few tools that can be used for data encryption, and Module 10 will discuss the more advanced use of command line tools and APIs to access the object store. 

See also: [http://support.rc.nectar.org.au/docs/object-storage](http://support.rc.nectar.org.au/docs/object-storage) 

## Volume storage

You may think of *volume storage* (also referred to as *block storage*) as one section of a drive of continuous storage which has been assigned for your use. Volume storage appears to the system and the user as attached drives. You will see it listed in your file explorer along your other harddrives. Block storage is the type of storage that is required for running things like databases, or as a storage that applications (e.g. your data analysis software) require to frequently access and write files. Volume storage types do not efficiently scale up as Object storage does, but it is required for fast and efficient access from applications. Also, most traditional applications will not support object storage, so you will need Volume storage in this case.

Volume storage can live outside your instance. It is appears as block storage which can be attached and then accessed and even booted from. This is a storage volume that you can attach to from within your instance, read and write data, detach it, and make it available to another instance. Your data on a volume is retained even when you terminate your instance. Volumes also offer a *Snapshot* feature which can be used to make convenient backups (this uses some of your overall volume quota).

TODO: PUT IN INFO BOX

NOTE:  Volumes are local services and only instances in the availability zone where the volume has been created can access it.

END INFO BOX

## Difference between volume (block) and object storage

*Volume** *or* Block *storage can be seen as what we know as a partition of a harddrive (or a whole hard drive), containing a lot of files in one whole block. You can attach and detach such a block storage to/from your instance and share it across instances. The data is retained as soon as you shut down your instance. You can also take a snapshot of the volume, just as you can do for the instance.

Unlike accessing a file within a volume with traditional file access methods, you access an *object* in the Object Store using an HTTP-based interface. Anyone who has stored a picture on Facebook or a song on Spotify has used object storage even if they don’t know it. 

Object Storage is a per-file based storage system which stores each file at several locations which are found suitable for this file - you won’t know where exactly the individual files are stored, they may even not all be on the same harddrive. In contrast, volume storage is one larger block of storage which contains several files.

## RDSI storage

You may also get access to the *Research Data Storage Infrastructure* (RDSI): [https://www.rdsi.edu.au/](https://www.rdsi.edu.au/). The aim of the RDSI Project is that researchers will be able to use and manipulate significant collections of data that were previously either unavailable or difficult to access and that there will be a consistent means of accessing this data. 

The Project is realised through the creation and development of data storage infrastructure. Specifically, the intention is to increase the sharing and re-use of research related data.

The resulting data environment is not intended to be exclusive to the use of RDSI Project stakeholders. Rather, it is expected to contribute to the development of an open infrastructure that institutions, disciplines and research facilities can expand or extend. Researchers will be able to use the consistent interface established by this project for access to data collections at participating institutions and other locations as well as data held at the nodes.

The RDSI Project will deliver a national infrastructure able to hold significant collections of research data. That infrastructure will comprise:

* A small number of high capacity *nodes* where each *node* will contain multiple petabytes of storage;

* A dedicated high speed inter-connection network with high bandwidth low latency connections that will support replication and data transfer between nodes;

* A common access infrastructure to provide a uniform experience for common researcher access to all the data held; and

* Appropriate specialist access infrastructure hosting specialist access tools appropriate to the disciplines closely related to these national collections.

RDSI is funding the setup of eight data centres or 'Nodes' as we call them, around Australia.  These Nodes are capable of storing petabytes of research data from researchers and institutions around the country. The map below shows the Node locations and the organisations who operate them:

![image alt text](image_0.jpg)

You may get access to data that other researchers have shared in *collections*. A large amount of discipline-specific collections are already available. To see the collections which are currently available, follow this link: [https://www.rdsi.edu.au/collections-stored](https://www.rdsi.edu.au/collections-stored) 

TODO: Find out how to get access to the RDSI storage


