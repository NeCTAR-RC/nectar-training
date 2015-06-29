---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

*Prerequisite*: You need to have installed the *python-novaclient* using the instructions given earlier.


You may display information about all the instances you are running:

```nova list```

This will output a line like this one for each running instance:

{% BgBox terminal %}
|   |   |  |  |  |   |
|--------------|-----------------|--------|------------|-------------|----------------------------|
|\| ID           |\| Name            |\| Status |\| Task State |\| Power State |\| Networks                   |
|\| be2ev... |\| MyInstance |\| ACTIVE |\| \-          |\| Running     |\| zone=&lt;your-ip&gt; |\|
|-- | --|--|--|--|--|
{% endBgBox %}


You can display more information about your instances with:

```nova show <instance ID>```

Where the instance ID is the long combination of numbers, dashes and letters shown in the *nova list* command. Alternatively, you may use the *name* of the instance, e.g.:

```nova show MyInstance```

in the example above. This will display a lot of information about this particular instance.

You can display help for the *nova* command with:

``` nova help ```

In the following, we are going to discuss *nova* commands for 

* Launching an instance

* Taking a snapshot of an instance

* Create an image from an instance

* Re-launch the instance from an image

### Launch an instance with *nova*

You can also launch an instance with *nova* instead of using the [Dashboard][Dashboard] as we have done in [Module 7][ModDoc7].

First, you may want to take a look at the flavors which are available and pick the one you'd like:

```nova flavor-list```

In this tutorial, let's pick the flavour *m1.small*.
Take note of the ID (first column of the printed information). When compiling this tutorial, the ID for the flavor *m1.small* was *0*, but in your case it may also be a long string of characters. 

Now, you should pick an image to launch your instance from. Just as in [Module 7][ModDoc7], we will use the Ubuntu 14.10 image.

```nova image-list```

Because there are a lot of images, the list will be very long. To make it easier to find the right Ubuntu 14.10 image, type:

```nova image-list | grep 14.10```

Find the image *NeCTAR Ubuntu 14.10 (Utopic) amd64" and take note of the ID, which may be a number or a long string of characters. When compiling this tutorial, the ID was *fc48b5bb-e67d-4e39-b9ba-b6725c8b0c88*.

You now have to configure the ssh keys you want to use. Your *Nectar_Key* should show up in the following command (with another name if you chose another launching the instance in Module 7):

```nova keypair-list```

We will use the same key in this tutorial, so take note of the *Name* (first column).

{% BgBox info %}
You may also add a new key. The command

```nova keypair-add <name>```

will generate a key with a &lt;name&gt; you may choose, and print the private key to the terminal. You have to copy and save this output **now** to a file and store it somewhere as your private key.

If you want to select an existing key that you generated earlier, you have to specify the path to your *public* key, which you must be able to access from your terminal:

```nova keypair-add --pub-key <path-to-your-pub-key> <name>```

Display the help for *keypair-add* with

``` nova help keypair-add```
{% endBgBox %}

You may display information about a specific key with:

```nova keypair-show <keypair-name>```

using the keypair name which is displayed with the *nova keypair-list* command.

Now, you may launch your instance with the command:

```nova boot --flavor <flavour-id> --key-name <keypair-name> --image <image-id> <name-of-instance>``` 

As a name for the instance, choose *NovaLaunchedInstance*. At the time this tutorial was created, this was:

```nova boot --flavor 0 --key-name Nectar_Key --image fc48b5bb-e67d-4e39-b9ba-b6725c8b0c88 NovaLaunchedInstance```

It will display information about the instance being created. The state (*vm_state*) will probably still be *"building"*.

Once the instance has been created, it will show up in the output of *nova list* and details can be retrieved with *nova show*.

Again, check if the instance is in status **Active** with the command:

```nova list```

Once it is active, you may look up the IP address for *NovaLaunchedInstance* with

```nova show NovaLaunchedInstance```


XXX security groups!


You may now try to login to your instance with the SSH command, as described in [Module 7](/package07/sections/connectViaSSH.html). 
Use the IP address which is displayed for your new instance to login via ssh. For example, on a Linux or Mac:

```ssh -i .ssh/Nectar_Key ubuntu@NNN.NNN.NNN.NNN```

replacing the N's with the IP address. 

For more information, display the help for *nova boot* with

``` nova help boot```

XXX Insert link to OpenStack doco and official git

XXX AVAILABILITY ZONE!


### Reboot

nova reboot


Also see this:

https://espaces.edu.au/vwrangler/nectar-topics/nectar-how-tos/changing-a-nectar-virtuals-mac-address


Using nova for rescue?
https://espaces.edu.au/vwrangler/nectar-topics/nectar-how-tos/using-nova-rescue-to-repair-a-nectar-instance

