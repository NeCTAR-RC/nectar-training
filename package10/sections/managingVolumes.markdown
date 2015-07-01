---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}



*Prerequisite*: You need to have installed the *python-openstackclient* using the instructions given earlier. You should also be familiar with the terminology and concepts involved for launching an instance, as described in [Module 7][ModDoc7]. You also must have *sourced* your OpenStack RC file on the command line you are using, as described [earlier in this module](openStackClients.html).


In this section we are going to deal with managing *Volumes*:

* Creating and deleting volumes

* Attaching and detaching volumes from instances

* Taking snapshots of volumes and 

* Creating volumes from snapshots


You can list the volumes you already have with:

```openstack volume list```

{% BgBox terminalPreformat %}
+------------------+----------+--------------+------+-------------+----------+-----------------+
|  ID              |  Status  | Display Name | Size | Volume Type | Bootable |  Attached to    |
+------------------+----------+--------------+------+-------------+----------+-----------------+
| 494e6104-a282-...|  in-use  | MyVolume     |  1   |  intersect  |  false   | a87a...         |
+------------------+----------+--------------+------+-------------+----------+-----------------+
{% endBgBox %}


You can display help for the *openstack* command with:

``` openstack help ```

And if you would like to see the help for a particular sub-tool, e.g. *volume:*

``` openstack help volume```

For supporting and further documentation, please refer to the [official openstack client documentation][OpenStackClientDoc]. 




#### Create a new volume

Creating a new volume is easy using the *openstack volume create* command. You can display help for this command with

```openstack help volume create``` 

to see the syntax of the command and some optional arguments.

Create a new Volume called *MyNewStorage* with the following command, choosing your availability zone and the size in GB you want to create:

```openstack volume create --description "Description of this volume" --availability-zone <zone name> --size <size in GB> MyNewStorage```

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

The status of the volume should switch to 'Available' soon. Re-check the status with    
```openstack volume show MyNewStorage```

After the volume has been created, when you type    
```openstack volume list```    
you should see your new volume in the list.


#### Attaching/Detaching a volume to an instance

To attach and detach a volume to an instance, you will use the command tool *openstack server*.

First, find the instance name that you want to attach the volume to by listing all your instances:

```openstack server list```

{% BgBox terminalPreformat %}
+-------------------+----------------------------+--------+----------------------------+
| ID                | Name                       | Status | Networks                   |
+-------------------+----------------------------+--------+----------------------------+
| af87a5c8-e751-... | CopyOfNovaLaunchedInstance | ACTIVE | intersect-02=137.92.56.42  |
| b720630a-e0dd-... | NovaLaunchedInstance       | ACTIVE | intersect-02=137.92.56.36  |
+-------------------+----------------------------+--------+----------------------------+
{% endBgBox %}


Now, to attach the volume:

```openstack server add volume  <Server-Name> <Volume-Name>```


**Server-Name**: the name of instance that you just looked up with *nova list*. Let's attach it to the instance listed above which is named *NovaLaunchedInstance*.

**Volume-Name**: The name of the volume you want to attach. We will attach the volume *MyNewStorage* which we just created.

{% BgBox info %}
The *openstack server add volume* command also has an optional argument **--device**. This argument sets the name which will be used for the device mapping, e.g. */dev/mydevice*. OpenStack **currently ignores** the specified device when attaching volumes, so you should skip this option at this stage. 
{% endBgBox %}

The full command with the examples looks like this:
```openstack server add volume NovaLaunchedInstance MyNewStorage```

The command will take a while to execute.    
Now, if you run

``openstack volume list``` 

you should see the output which shows that your volume is attached:
{% BgBox terminalPreformat %}
+--------------+--------------+--------+------+-----------------------------------------------+
| ID           | Display Name | Status | Size | Attached to                                   |
+--------------+--------------+--------+------+-----------------------------------------------+
| 42385945-... | MyNewStorage | in-use |    1 | Attached to NovaLaunchedInstance on /dev/vdc  |
+--------------+--------------+--------+------+-----------------------------------------------+
{% endBgBox %}

OpenStack adds the volume as the lowest available device name: For a standard flavor VM (with a primary & secondary drive) the first volume will be attached as */dev/vdc*. You can see where your device has been mapped to in the last column of the output.


To detach a volume, you will use a similar command:

```openstack server remove volume <Server> <Volume>```


{% BgBox important %}
{% include /docLinks.markdown %}
Before you detach a volume, you have to unmount it! (See [Module 7][ModDoc7] for how to mount/unmount a drive).
{% endBgBox %}

Now if you run

```openstack volume list```

you will see that the status of the volume is not "in-use" any more, but now “avalibale” again.


#### Backup a volume

You will need to source your openrc file, if you haven’t done so yet.

The difference between backup and snapshot has been explained in Module 6/7?

##### 1. Backup

To create your Volume Backup, you will use the *cinder backup-create *command.

You can type

  *cinder help backup-create* 

to display the help and the syntax of the command.

To create a backup of the instance <Volume-ID> into the container "Backups" and name it “Backup1”, type:

  cinder backup-create --container Backups --display-name Backup1 <Volume-ID>

You can get your Volume-ID by typing 

   cinder list

XXX Test: the object container has to exist (?)

After creating the backup, your volume will be in in the status "backing-up", which can take a while. Type 

   cinder list

to see the status of your Volume backup.

After the backup has been created, you can see it with:

  cinder backup-list

<Insert Output example>

 

##### 2. Snapshot

XXX insert examples

Before taking a snapshot, you have to observe two things:

1. Your volume has to be detached. You can check this with "cinder list" or “nova volume-list”, it has to be in in “*available*” status.

2. The original volume that you want to take the snapshot of may not be deleted - if you delete it, then the snapshot will become unusable!

Create the snapshot:

nova volume-snapshot-create --display_name <Snapshot-Name> <Volume-ID>

Now, you should be able to see your snapshot with:

nova volume-snapshot-list

You can see the *snapshot ID *in the output.

If you want to create a new volume of this snapshot, use the command: 

nova volume-create --snapshot_id <snapshot-id>  --display_name <NewVolumeName> <Size-in-GB>

XXX TEST: Does it have to have the same size?

Wow, you can see your new volume with:

  nova volume-list


