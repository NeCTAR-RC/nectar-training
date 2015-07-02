---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}



*Prerequisite*: You need to have installed the *python-openstackclient* using the instructions given earlier. You should also be familiar with the terminology and concepts involved for managing volumes, as described in [Module 6][ModDoc6] and [Module 7][ModDoc7]. You also must have *sourced* your OpenStack RC file on the command line you are using, as described [earlier in this module](openStackClients.html).

{% BgBox info %}
{% include /docLinks.markdown %}
Before the **openstack** client was introduced, managing volumes was done with the **cinder** and **nova** commands, so you may still find references to it on the Internet. While you still can use *cinder* and *nova*, in this tutorial we stick to the more uniform and intuitive *openstack* client, which works very similar to the *cinder* and *nova* commands. 
For more details, refer to the [official OpenStack cinder][OpenStackCinder] and [nova][OpenStackNova] documentation.
{% endBgBox %}

You can display help for the *openstack* command with:

``` openstack help ```

This will print a list of options for this command. Each option listed can be seen as a 'sub-command'. You may print more information about usage of the particular sub-command, e.g. for *volume* which we are going to use in this section:

``` openstack help volume```

For supporting and further documentation, please refer to the [official openstack client documentation][OpenStackClientDoc]. 


In this section we are going to deal with managing *Volumes*:

* Creating and deleting volumes

* Attaching and detaching volumes from instances

* Taking snapshots and backups of volumes and 

* Restoring volumes from snapshots or backups


{% BgBox important %}
You cannot use Volumes if you are using the NeCTAR Trial Account. You need to submit an allocation request to get access to volume storage. You may read more about allocations in [Module 5](/package05/sections/allocations.html).
{% endBgBox %}




#### Create a new volume


You may list the volumes you already have with:

```openstack volume list```

This will print information about your existing volumes (or print nothing if you don't have any volumes yet):
{% BgBox terminalPreformat %}
+------------------+----------+--------------+------+-------------+----------+-----------------+
|  ID              |  Status  | Display Name | Size | Volume Type | Bootable |  Attached to    |
+------------------+----------+--------------+------+-------------+----------+-----------------+
| 494e6104-a282-...|  in-use  | MyVolume     |  1   |  intersect  |  false   | a87a...         |
+------------------+----------+--------------+------+-------------+----------+-----------------+
{% endBgBox %}


Creating a new volume is easy using the *openstack* client. You can display help for volume creation with:

```openstack help volume create``` 

to see the syntax of the command and some optional arguments.

Now, create a new Volume called *MyNewStorage* sized *1GB* with the following command (specifying your own availability zone):

```openstack volume create --description "Description of the volume" --availability-zone <zone name> --size 1 MyNewStorage```

{% BgBox important %}
You will need to specify the *same* availability zone in which the instance you want to attach it to is running, or you will not be able
to attach the volume to the instance.

To list all availability zones:    
```openstack availability zone list```
{% endBgBox %}

A summary will be printed which shows the details of the volume you are creating (extracts shown in output):

{% BgBox terminalPreformat %}
+---------------------+--------------------------------------+
| Field               | Value                                |
+---------------------+--------------------------------------+
| attachments         | []                                   |
| availability_zone   | intersect                            |
| bootable            | false                                |
| display_description | Description of the Volumme           |
| display_name        | MyNewStorage                         |
| encrypted           | False                                |
| id                  | 42385945-e2...                       |
| properties          |                                      |
| size                | 1                                    |
| snapshot_id         | None                                 |
| source_volid        | None                                 |
| status              | creating                             |
| type                | intersect                            |
+---------------------+--------------------------------------+
{% endBgBox %}

The *status* of the volume should switch to *'Available'* soon. Re-check the status with

```openstack volume show MyNewStorage```

After the volume has been created, when you type    

```openstack volume list```    

you should see your new volume in the list.

If you want to *delete* a volume again, use this command:

```openstack volume delete <volume name or ID>```

{% BgBox important %}
{% include /docLinks.markdown %}
When you delete a volume, you will **lose all data and access** to this volume. Make sure you **back up** all data, and **securely erase** the data on the volume (as described in [Module 9][ModDoc9]) *before* you delete it!
{% endBgBox %}

#### Attaching/Detaching a volume to an instance

To attach and detach a volume to an instance, you will use the command tool *openstack server*. Display the help:

```openstack server help | grep volume```

First, find the instance name that you want to attach the volume to by listing all your instances:

```openstack server list```

{% BgBox terminalPreformat %}
+-------------------+----------------------------+--------+----------------------------+
| ID                | Name                       | Status | Networks                   |
+-------------------+----------------------------+--------+----------------------------+
| af87a5c8-e751-... | CopyOfClientLaunchedInstance | ACTIVE | intersect-02=137.92.56.42  |
| b720630a-e0dd-... | ClientLaunchedInstance       | ACTIVE | intersect-02=137.92.56.36  |
+-------------------+----------------------------+--------+----------------------------+
{% endBgBox %}


To attach a volume, you may use this command:

```openstack server add volume  <Server-Name> <Volume-Name>```


**Server-Name**: the name (or ID) of instance which you want to attach the volume to. Let's attach it to the instance we launched in the last section, which is named *ClientLaunchedInstance*.

**Volume-Name**: The name (or ID) of the volume you want to attach. We will attach the volume *MyNewStorage* which we just created.


with the examples used in this tutorial this command unfolds as:    

```openstack server add volume ClientLaunchedInstance MyNewStorage```

{% BgBox info %}
The ```openstack server add volume``` command also offers an argument ```--device```. This *optional* argument is intented to set the device mapping, e.g. */dev/mydevice*. OpenStack **currently ignores** this option when attaching volumes, so you should skip this option at this stage (it may be that your command does not work if you specify this option). 
{% endBgBox %}


The command will take a while to execute. 
When it is finished, when you run

```openstack volume list``` 

the output should show that your volume is attached:
{% BgBox terminalPreformat %}
+--------------+--------------+--------+------+-----------------------------------------------+
| ID           | Display Name | Status | Size | Attached to                                   |
+--------------+--------------+--------+------+-----------------------------------------------+
| 42385945-... | MyNewStorage | in-use |    1 | Attached to ClientLaunchedInstance on /dev/vdc  |
+--------------+--------------+--------+------+-----------------------------------------------+
{% endBgBox %}

OpenStack adds the volume as the lowest available device name: For a standard flavor instance (with a primary & secondary drive) the first volume will be attached as */dev/vdc*. You can see where your device has been mapped to in the last column of the output.

{% BgBox info %}
You may attach *several* volumes to one instance. However you may only attach one volume to *one* instances at a time. 
{% endBgBox %}

To **detach** a volume, use a similar command:

```openstack server remove volume <Server-Name> <Volume-Name>```


{% BgBox important %}
{% include /docLinks.markdown %}
Before you detach a volume, you have to **unmount** it! [Module 7][ModDoc7] includes information about mounting and unmounting drives.
{% endBgBox %}

Now, detach the volume again that we have just attached:    
```openstack server remove volume ClientLaunchedInstance MyNewStorage```

After detaching, if you run

```openstack volume list```

you will see that the status of the volume is not in status *"in-use"* any more, but now *"avalibale"* again.


### Backups and Snapshots

You may create a *Backup* of a volume, or take a *Snapshot* of it.
The difference between Backup and Snapshot has been explained in [Module 9](/package09//sections/backup.html): The key difference is that a Snapshot creates an *Image* of the size your Volume has, whereas a Backup creates a *backup file* which has the size of your *used* storage, and saves it in the *Object Store*. Another important difference is that Backups can be used to restore the state onto an *existing* volume, whereas with a Snapshot, it is only possible to create an entirely *new* volume from it.

**1. Backup and restore a volume**

To manage your volume Backups, you will use the command set *openstack backup*:

```openstack help backup```   
```openstack help backup create```


Before you can create a Backup, you must *detach* the volume from any instances. You need to first *unmount* the device (if you have mounted it from an instance), and then detach it, as described earlier. A volume is *detached* when it is in the status *"available"*. Check this with
 
```openstack volume list```

You will see *"Backup1"* listed and the status it is in.

To create a backup of the volume named *MyNewStorage*, and save it into the object store container *"Backups"* naming it *"Backup1"*:

```openstack backup create --container Backups --name Backup1 --description "Backup MyNewStorage" MyNewStorage```

While the argument ```--description``` is optional, it is recommended you fill in some meaningful information about this backup here, as it will make it
easier to identify it when you want to restore it.

If the container *"Backups"* did not exist yet, it will have been created. 
After creating the backup, your volume will be in in the status *"backing-up"*, which can take a while. Type 

```openstack backup list```

to see the status of your Volume backup.

{% BgBox terminalPreformat %}
+--------------------+---------+---------------------+-----------+------+
| ID                 | Name    | Description         | Status    | Size |
+--------------------+---------+---------------------+-----------+------+
| eb4d23e7-861e-4... | Backup1 | Backup MyNewStorage | available |    1 |
+--------------------+---------+---------------------+-----------+------+
{% endBgBox %}


After the backup has been done, you can see it listed in your Object Store:

```openstack container list```    
```openstack object list Backups```

The Backups container has been created (unless you already had it). You will see a rather long list of files in the *Backups* container --- which means your Backup has been saved in several object files. This should not concern you however, as you can restore the data with only one command. 

To restore your Volume to the state we just saved in *Backup1*, first obtain the *ID* of this backup, which is displayed in the first column of the output:

```openstack backup list```

You will need the *ID* (in this case, the *Name* does not work) to display some more information about this Backup:

```openstack backup show <Backup-ID>```

{% BgBox terminalPreformat %}
+-------------------+-----------------------+
| Field             | Value                 |
+-------------------+-----------------------+
| availability_zone | intersect             |
| container         | Backups               |
| created_at        | 2015-07-...           |
| description       | Backup MyNewStorage   |
| fail_reason       | None                  |
| id                | eb4d23e7-8 ...        |
| name              | Backup1               |
| object_count      | 22                    |
| size              | 1                     |
| status            | available             |
| volume_id         | 42385945-e2d2...      |
+-------------------+-----------------------+
{% endBgBox %}


Note that the Volume ID (field *volume_id*) is displayed in the information to remind us which volume this is a backup from. The ID is not very intuitive, so it is a good idea to add a meaningful description to the backup when you create it.


To restore, display the help for the *backup restore* tool:

```openstack help backup restore```


To restore the volume *MyNewStorage* to the state we saved in *Backup1*, use the command:

```openstack backup restore <Backup-ID> MyNewStorage```
 
{% BgBox important %}
You may also restore the backup to a volume other than the Volume you took the Backup of --- the Backup is **not bound to the original Volume** you took the Backup of! 

When you restore to **any Volume**, you must keep the following in mind:

* all data on the Volume you choose as restore target **will be lost**! The state of the Volume after the restore is going to be **exactly the state** which your Volume was in when you made the Backup.

* the Volume needs to be large enough to fit your backup data. 

* the Volume you restore the backup onto will get the name of the originally backed up Volume. For example if you did a Backup of *MyNewStorage*, then restored this backup onto the Volume *MySecondStorage*, the volume *MySecondStorage* will be renamed to *MyNewStorage* (however the original *ID* of the Volume will be kept).

{% endBgBox %}

Backups take space in your object store, so you may want to delete old Snapshots every now and then:

```openstack backup delete <Backup-ID>```



**2. Snapshot a volume and re-create it**

Before taking a snapshot, you should make sure that your volume is detached from any instance: It has to be in in “*available*” status. You can check this with

```openstack volume list```

To create a Snapshot of a volume:

```openstack snapshot create --name <Snapshot-Name> --description "Describe the snapshot" <Volume-Name>```

As volume name you may specify the name or ID. You should name and describe the snapshot such that it makes sense to you.
Let's for example create a snapshot of *MyNewStorage* and name it *MyNewStorageSnapshot1": 

```openstack snapshot create --name MyNewStorageSnapshot1 --description "First snapshot" MyNewStorage```

Now, you should be able to see your Snapshot in the list:

```openstack snapshot list```

Take note of the *ID* of your snapshot, you will need it to restore the snapshot state.

{% BgBox info %}
When you want to restore the state of the snapshot, you need to create a *new* volume --- it is not possible to restore the state onto an existing volume, as it can be done with a Backup.
{% endBgBox %}

You can create a *new* volume of this snapshot using the same command as described earlier to create a volume, but adding the ```--snapshot``` argument to specify the ID (the *Name* will not work) of your snapshot.

```openstack volume create --snapshot <snapshot-ID> --description "My restored Volume" --size <Size-in-GB> [--availability-zone <zone>] <New-Volume-Name> ```

You may create a Volume which has a larger storage size than the original Snapshot, but it may not be less.

For example, we can create a new volume out of the snapshot *MyNewStorageSnapshot1* and call it *"MyRestoredVolume"*, and set the size to 2GB this time:

```openstack volume create --snapshot <ID of MyNewStorageSnapshot1> --description "My restored Volume" --size 2 MyRestoredVolume```

{% BgBox important %}
The original volume that you want to take the Snapshot of **must still exist** when you create a new volume of the Snaphot! You cannot have deleted your Volume before.

OpenStack does not let you delete Volumes which have "depending snapshots", so loosing the state of snapshots is not a worry. However you have to be aware that the Snapshots are only usable while you keep your Volume in existence. This is different to *Backups*.
{% endBgBox %}

The new volume will now be listed with your other volumes:

```openstack volume list```

{% BgBox terminalPreformat %}
+------------------------+------------------+-----------+------+-------------+
| ID                     | Display Name     | Status    | Size | Attached to |
+------------------------+------------------+-----------+------+-------------+
| 9f8af2bd-d5d4-45d4-... | MyRestoredVolume | available |    2 |             |
| 80cec22c-8c0c-4bd4-... | MyNewStorage     | available |    1 |             |
+------------------------+------------------+-----------+------+-------------+
{% endBgBox %}

Snapshots take a good amount of your storage capacity, because they have the same size as the volume that was snapshotted. So you may want to delete old Snapshots every now and then:

```openstack snapshot delete <Snapshot Name>```









