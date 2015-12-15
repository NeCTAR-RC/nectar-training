---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


{% BgBox prerequisite %}
{% include /docLinks.markdown %}
*Prerequisite*: You need to have installed the *python-openstackclient* using the instructions given earlier. You should also be familiar with the terminology and concepts involved in launching an instance, as described in [Module 7][ModDoc7]. You also must have *sourced* your OpenStack RC file on the command line you are using, as described [earlier in this module](openstackClients.html).
{% endBgBox %}

{% BgBox info %}
{% include /docLinks.markdown %}
Before the **openstack** client was introduced, managing compute services was done with the **nova** command, so you may still find references to it on the Internet. While you still can use *nova*, in this tutorial we stick to the more uniform and intuitive *openstack* client, which works similarly to the *nova* command.
For more details, refer to the [official OpenStack nova][OpenStackNova] documentation.
{% endBgBox %}


{% BgBox info %}
The following instructions will assume that all the *Names* you choose for instances, volumes, etc. have **no whitespaces** in them. If the names *do* include white spaces, you have to put the name in quotation marks when using them in the commands, e.g. "Name of resource".
{% endBgBox %}

You may display information about all the instances you are running:

```openstack server list```

This will output a line like this one for each running instance:

{% BgBox terminal %}
+--------------+----------------------+--------+----------------------------+
| ID           | Name                 | Status | Networks                   |
+--------------+----------------------+--------+----------------------------+
| be290858-... | MyFirstInstance      | ACTIVE | intersect-01=43.240.96.180 |
+--------------+----------------------+--------+----------------------------+
{% endBgBox %}


You can display more information about your instances with:

```openstack server show <instance ID>```

Where the instance ID is the long combination of numbers, dashes and letters shown in the *openstack server list* command. Alternatively, you may use the *name* of the instance, e.g.:

```openstack server show MyFirstInstance```

in the example above. This will display a lot of information about this particular instance.

You can display help for the *openstack* command with:

``` openstack help ```

This will print a list of options for this command. Each option listed can be seen as a 'sub-command'. You may print more information about usage of the particular sub-command, e.g. for *server* which we are going to use in this section:

``` openstack help server ```

In the following, we are going to discuss *openstack server* commands for 

* Launching an instance

* Taking a snapshot of an instance

* Launching a new instance from a snapshot


For supporting and further documentation, please refer to the [official openstack client documentation][OpenStackClientDoc]. 

### Launching an instance

You can also launch an instance with *openstack server* instead of using the [Dashboard][Dashboard] as we have done in [Module 7][ModDoc7].

First, you may want to take a look at the flavors which are available and pick the one you'd like:

```openstack flavor list```

In this tutorial, let's pick the flavor *m1.small*.
Take note of the ID (first column of the printed information) and name. When compiling this tutorial, the ID for the flavor *m1.small* was *0*, but in your case it may also be a long string of characters.

Now, you should pick an image to launch your instance from. Just as in [Module 7][ModDoc7], we will use the Ubuntu 14.10 image.

```openstack image list```

Because there are a lot of images, the list will be very long. To make it easier to find the right Ubuntu 14.10 image in the NeCTAR images, type:

```openstack image list | grep 14.10```

Find the image *NeCTAR Ubuntu 14.10 (Utopic) amd64" and take note of the ID, which may be a number or a long string of characters. When compiling this tutorial, the ID was *fc48b5bb-e67d-4e39-b9ba-b6725c8b0c88*.

You now have to configure the ssh keys you want to use. Your *Nectar_Key* should show up in the following command (with another name if you chose another launching the instance in Module 7):

```openstack keypair list```

We will use the same key in this tutorial, so take note that the **Keypair Name** (first column) is the one you chose for the key, i.e. *Nectar_Key*.

{% BgBox info %}
You may also add a new key. The command

```openstack keypair create <name>```

will generate a key with the &lt;name&gt; of your choice, and print the private key to the terminal. You have to copy and save this output **now** to a file and store it somewhere as your private key.

If you want to select an existing key that you generated earlier, you have to specify the path to your *public* key, which you must be able to access from your terminal:

```openstack keypair create --public-key <path-to-your-pub-key> <name>```

You can display the help for *keypair create* with

``` openstack help keypair create```
{% endBgBox %}

You may display information about a specific key with:

```openstack keypair show <keypair-name>```

using the keypair name for which you want to display the information.

Let's now display information about the security groups:

```openstack security group list```

This should display something like this:

{% BgBox terminal %}
+-------+---------+-------------+
|    ID | Name    | Description |
+-------+---------+-------------+
| 86498 | default | default     |
| 90284 | http    | Allow http  |
| 86501 | icmp    | Allow icmp  |
| 86504 | ssh     | Allow ssh   |
+-------+---------+-------------+
{% endBgBox %} 

Take note of the security group *names* (2nd column) for *icmp* and *ssh*.

The last thing we may need to specify before we launch an instance is the *Availability Zone*. List all the available zones with:

```openstack availability zone list```

Take note of your *Zone Name* (first column), if you want to use a particular zone. Otherwise, you won't need to specify the availability zone and you will be assigned the most suitable one automatically.

Now, you may launch your instance with the command *openstack server create*. Display help about this command:

```openstack help server create```

which will describe the options available. Launch your instance:

```openstack server create --flavor <flavor-id> --key-name <keypair-name> --image <image-id> --security-group <group name> --availability-zone <zone name> <name-of-instance>``` 

As a name for the instance, choose *ClientLaunchedInstance*.
For the flavor, you may specify either the *name* or the *id* of that flavor. 
If you assign several security groups, you must repeat the *--security-group* argument before each group name. 
If you don't want to use a specific availability zone, you may skip the *--availability-zone* argument.
At the time this tutorial was created, the command (without availability zone) was:

```openstack server create --flavor m1.small --key-name Nectar_Key 
    --security-group icmp --security-group ssh --image fc48b5bb-e67d-4e39-b9ba-b6725c8b0c88 ClientLaunchedInstance```

It will display information about the instance being created, similar to these *extracts* of output:
{% BgBox terminal %}
+-------------------------------+--------------------------------------------+
| Field                         | Value                                      |
+-------------------------------+--------------------------------------------+
| OS-DCF:diskConfig             | MANUAL                                     |
| OS-EXT-AZ:availability_zone   | intersect                                  |
| OS-EXT-STS:power_state        | 0                                          |
| OS-EXT-STS:task_state         | scheduling                                 |
| OS-EXT-STS:vm_state           | building                                   |
| flavor                        | m1.small (0)                               |
| hostId                        |                                            |
| id                            | b720630a-e0dd-4ecd-9ceb-5e3519e69edc       |
| image                         | NeCTAR Ubuntu 14.10 (Utopic) amd64 (fc4..) |
| key_name                      | Nectar_Key                                 |
| name                          | ClientLaunchedInstance                       |
| security_groups               | [{u'name': u'icmp'}, {u'name': u'ssh'}]    |
| status                        | BUILD                                      |
+-------------------------------+--------------------------------------------+
{% endBgBox %}

The state (*vm_state*) will probably still be *"building"*.
Once the instance has been created, it will show up in the output of *openstack server list* and *openstack server show*.

You can check if the status of the instance is **Active** with the command:

```openstack server list```

Once it is active, you may look up the IP address for *ClientLaunchedInstance* with

```openstack server show ClientLaunchedInstance```


**Congratulations!! You have now launched your instance.**


You may now try to login to your instance with the SSH command, as described in [Module 7](/package07/sections/connectViaSSH.html). 
Use the IP address which is displayed for your new instance to login via ssh. For example, on a Linux or Mac:

```ssh -i .ssh/Nectar_Key ubuntu@NNN.NNN.NNN.NNN```

replacing the N's with the IP address. 

For more information, see also the [official OpenStack Client documentation][OpenStackClientDoc].

You can now go to the Dashboard and observe that your new instance will be listed there as well.



You may reboot the instance with

```openstack server reboot <instance-name>```

and *terminate* (delete) it with

```openstack server delete <instance-name>```


If you want to add a new security group, you can easily do this after launching as well:

```openstack server add security group <group name>```

To get more information about the *openstack server* command:

```openstack help server```


### Taking a snapshot of an instance

Taking a snapshot of the instance is easy. Using your *Instance Name*:

```openstack server image create --name <Image-Name> <Instance-Name>```

The snapshot will be **saved as an Image** with the name you choose. In the example given in this tutorial, the command is:

```openstack server image create --name ClientLaunchedSnapshot ClientLaunchedInstance```

This process may take a while. In the beginning, the 'status' of your snapshot will be *queued*. 

You can check on the status of your snapshot with:

```openstack image show <Image-Name>```

{% BgBox important %}
It is possible to take a **"Live snapshot"** (take a snapshot of the machine that is currently running). In most cases, there should be no problem. However, if the instance is running while the snapshot is being taken, the resulting snapshot *may* be inconsistent. This is due to programs writing on the file system while a snapshot is taken. There are a few options to prevent this inconsistency from happening:

* running "sync" before starting the snapshot, or
* using a "file system freeze" utility which block programs writing on the filesystem,
* shutting down or pausing the instance before snapshotting.

The easiest option is probably to pause or shut down the instance and then take the snapshot. For more information, refer to the [OpenStack documentation](http://docs.openstack.org/trunk/openstack-ops/content/snapshots.html).
{% endBgBox %}


### Launch an instance from a snapshot


Because your snapshot was saved as an *Image*, you can easily launch the instance from this image. Instead of the *NeCTAR Ubuntu Image* which we used earlier, you can now specify your own image to launch a new instance. The new instance will have all the software you installed before taking the snapshot, and all the data you saved the on-instance storage (on the primary disk, *not* the secondary!).

You can print a list of all the images (instance and volume snapshots) you have created, if you would like a reminder for the snapshot name:

```openstack image list --private```

And more details about the images can be displayed with

```openstack image show <Image Name>```

You may launch an instance from your own image with the same command we used earlier to launch an instance:

```openstack server create --flavor <flavor-id> --key-name <keypair-name> --image <snapshot-name> --security-group <group name> --availability-zone <zone name> <name-of-instance>``` 

In our particular example, the command becomes:

```openstack server create --flavor m1.small --key-name Nectar_Key 
    --security-group icmp --security-group ssh --image ClientLaunchedSnapshot CopyOfClientLaunchedInstance```

List the details of your new instance with

```openstack server show CopyOfClientLaunchedInstance```

You have now two copies of your original instance running. You may log in with ssh to *CopyOfClientLaunchedInstance* as well.

{% BgBox important %}
Note that you may also choose a **different flavor** when you launch a new instance from the snapshot! This allows you to expand your resources (though you can do this more easily by following the process outlined in *openstack help server resize*). You should not choose a flavor with less storage available on the primary on-instance disk, otherwise the launching of your instance may fail due to lack of disk space.
{% endBgBox %}

