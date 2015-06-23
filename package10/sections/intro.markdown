---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

{% include /disclaimer.markdown %}


This last module is designed for advanced users who want to learn more about command line tools you may use to help you automate things. Worked examples of the OpenStack command line tools *glance* and *cinder* are included.

* * *

### How to track utilization

On the Dashboard, you can see the amount of resources you are using. You can also see how long your instances have been up and running. 

![image alt text](images/dashboardUtilization.png)


You may want to *monitor* your virtual machine(s), i.e. keep track of CPU usage, memory usage, etc. You may also want to set up system alerts. The Dashboard does not provide any tools to do this; you will have to use tools for virtual machine *monitoring*. 
Because the NeCTAR cloud uses OpenStack to manage the cloud, we require a monitoring tool which is compatible with OpenStack.

#### Ceilometer

OpenStack has a tool called *Ceilometer* which collects measurements within OpenStack. *Ceilometer* is actively developed and is now an integrated part of OpenStack. The Ceilometer project is a framework for monitoring and metering the OpenStack cloud. Other tools, which provide extended functionality and graphical interfaces, query Ceilometer for usage statistics. 

Ceilometer collects and monitors:

1. Compute resources (e.g. CPU, Memory use)

2. Network activity, including data transfer (in/out) by location.

3. Storage (including swift storage and volumes, discussed in Module 6).

Ceilometer is a service offered by OpenStack which you can query via the command line. It does not offer a convenient graphical interface for you.

Ceilometer command line reference:

[http://docs.openstack.org/cli-reference/content/ceilometerclient_commands.html](http://docs.openstack.org/cli-reference/content/ceilometerclient_commands.html) 

*Note*: Ceilometer commands require installation of the client package. On a Ubuntu image, you can do this with the command *sudo apt-get install python-ceilometerclient*. You will also need to source your OpenRC credentials file. We do this in Module 7 and 9 when setting up and accesing our storage as well.

#### DynaTrace Server

One example of a monitoring plugin which queries performance statistics provided by Ceilometer is *DynaTrace Server*. At the time of writing, this tool is relatively new. Gathered measures are configurable and can be set up dynamically depending on VM flavors. DynaTrace also offers a graphical interface.

DynaTrace Server link:

[https://community.compuwareapm.com/community/display/DL/OpenStack+Monitoring+Plugin](https://community.compuwareapm.com/community/display/DL/OpenStack+Monitoring+Plugin) 

#### Zabbix

Zabbix is an enterprise-class open source distributed monitoring solution which monitors several parameters of a network and the health and integrity of servers. It is one of the most popular system monitor tools.

Zabbix allosw users to configure e-mail based alerts for virtually any event. This allows a fast reaction to server problems. Zabbix also offers data visualisation features. All Zabbix reports, statistics and configuration parameters are accessed through a web interface. Zabbix is released unter the GPL General Public License and is free of cost. 

A snapshot of Zabbix web console is shown in the following figure.

![image alt text](image_1.jpg)

TODO: apparently zappix can be used with OpenStack, but still need to verify this and try it out. May not be trivial to set up for inexperienced users. 

Useful article for advanced readers:

[https://www.mirantis.com/blog/openstack-metering-using-ceilometer/](https://www.mirantis.com/blog/openstack-metering-using-ceilometer/) 



### Puppet and heat

You can create a template which describes what resources you need. Heat takes care

of provisioning the resources and handling and recovering from any failures or issues.

Tools like puppet and heat help you build scalable applications without worrying about creating and configuring the underlying infrastructure.

*Heat* manages the whole lifecycle of the application. When you need to change your infrastructure, you can modify the text template. Heat knows how to make the necessary changes. It will also delete all of the resources when you are finished with the application. Heat primarily manages infrastructure, but the templates integrate well with *software configuration management tools* such as *Puppet *and *Chef*.

*Puppet* is an open source platform for provisioning, configuring and patching applications and

operating system components. Puppet manages your servers: you describe machine configurations and dependencies in a text file, and Puppet will bring your systems into the desired state and keep them there.


### Extensions

An extension to modules 6), 7) and 9), now here we will work out details about how to 

1. change OpenStack password (create new users?)

2. automate backups [http://support.rc.nectar.org.au/forum/viewtopic.php?f=3&t=854](http://support.rc.nectar.org.au/forum/viewtopic.php?f=3&t=854) 

3. 


### OpenStack clients
Maybe discuss use OpenStack clients?

[http://espaces.edu.au/vwrangler/nectar-topics/nectar-how-tos/openstack-clients-for-nectar](http://espaces.edu.au/vwrangler/nectar-topics/nectar-how-tos/openstack-clients-for-nectar)

### NCI NeCTAR node

Discuss using the NCI nectar node?

[http://nci.org.au/services-support/training/using-nci-nectar-node/](http://nci.org.au/services-support/training/using-nci-nectar-node/)


### Managing volumes with nova and cinder

Discuss how to manage volumes via command line

Before you can create a volume, you need to install cinder:

  sudo apt-get install python-cinderclient

You also need to download your OpenStack credentials (XXX COPY TEXT FROM Module 7) and your openrc file.

Copy your OpenRC file to your instance

  scp -i <yourkey> <path-to-your-openrc> ubuntu@<your-IP>:

(or use an FTP client connected to your object store, then you have to have your object store mounted as well on your instance, see Module 7)

On your VM:

soucre <your-openrc.sh>

Now, you can list the volumes you already have with:

  cinder list

+--------------------------------------+----------+--------------+------+-------------+----------+--------------------------------------+

|              	ID              	|  Status  | Display Name | Size | Volume Type | Bootable |         	Attached to          	|

+--------------------------------------+----------+--------------+------+-------------+----------+--------------------------------------+

| 494e6104-a282-...            |  in-use  | AnotherTest      |  1     |  intersect         |  false        | a87a...                       |

+--------------------------------------+----------+--------------+------+-------------+----------+--------------------------------------+

#### Create a new volume

Create a new volume using the "*cinder create*" command.

You can type 

   cinder help create 

to see the syntax of the command and some optional switches you can use.

Create a volume:

 cinder create --display-name MyNewStorage --display-description "whats on this image" --availability-zone <eg melbourne-qh2> <size-in-GB>

(of course you can choose another name than MyNewStorage and add your own description)

A summary will be printed which shows the details of the volume you have just created:

+---------------------+-----------------------------------------------------------------------+

|   	Property  	|            	Value         			|

+---------------------+-------------------------------------------------------------------------+

| 	attachments 	|              	[]              			|

|              availability_zone  |          	intersect				|

|   	bootable  	|            	false     				|

|  	created_at 	|  	2015-05-19T11:42:49.496209 	|

|           display_description |     	whats on this image   		|

| 	display_name	|         	MyNewStorage 			|

|  	encrypted  	|            	False 				|

|      	id     	                |               bc9df14c...            			|

|   	metadata  	|              	{}              			|

|     	size    	|              	2               				|

| 	snapshot_id 	|             	None             			|

| 	source_volid	|             	None             			|

|    	status   	|           	creating           				|

| 	volume_type 	|          	intersect           			|

+---------------------+------------------------------------------------------------------------+

Now when you type

  cinder list

you should see your new volume in the list.

#### Attaching/Detaching a volume to an instance

To attach / detach a volume to an instance, you will use the command *nova volume-attach* and *nova volume-detach*.

You will have to install the nova client on your VM:

  sudo apt-get install python-novaclient

Find the instance ID that you want to attach the volume to by listing all your instances:

  nova list

+--------------------------------------+-----------------+-------------+----------------+---------------+----------------------------+

| ID                              	| Name        	| Status  	| Task State     | Power State | Networks                  |

+--------------------------------------+-----------------+-------------+----------------+---------------+----------------------------+

| a87afa…		 | TestIntersect01 | ACTIVE  | -          	          | Running 	| intersect-01=XX.XX.XX.XX |

+--------------------------------------+-----------------+-------------+----------------+---------------+----------------------------+

Similarly, with 

   cinder list

( or nova volume-list )

you can get the ID of the volume you want to attach.

The ID is the long combination of letters and numbers.

Now, to attach the volume:

    nova volume-attach <Server> <Volume-ID> [<Device-ID>]

**Server **: the instance ID that you just looked up with *nova list*.

**Volume-ID**: The volume ID that you just looked up with *cinder list* or *nova volume-list*.

**Device-ID**: The name that the device will be named, e.g. /dev/mydevice. OpenStack currently ignores the specified device when attaching volumes, you can skip this option, or specify 'auto' to let openstack decide. OpenStack adds the volume as the lowest available device name: For a standard flavor VM (with a primary & secondary drive) the first volume will be attached as /dev/vdc.

For example, type:

   nova volume-attach a87a…  bc9df..

The command will take a while to execute.

Example output:

+----------+-------------------------+| Property | Value                    |+----------+-------------------------+| device   | /dev/vdc 		|| serverId | a87a… 		|| id            | e19d0d2f-28b1-451c-ab60-e19d658df5d0 || volumeId |  bc9df..		|+----------+-------------------------+

Now if you run the 

  nova volume-list 

command you should see the output which shows that your volume is attached:

XXX insert example output

To detach a volume, you will use a similar command:

    nova volume-detach <Server> <Volume>.

**IMPORTANT**: Before you detach a volume, you have to unmount it! (See XXX on how to mount/unmount a drive).

Now if you run the 

  nova volume-list 

command you will see that the status of the volume is not "in-use" any more, but now “avalibale” again.

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

### Object store

Access with SWIFT, Boto, Java clients. See http://support.rc.nectar.org.au/docs/object-storage

