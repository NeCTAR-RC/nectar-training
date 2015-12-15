---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

{% BgBox prerequisite %}
{% include /docLinks.markdown %}
*Prerequisite*: You need to have installed the *python-openstackclient* using the instructions given earlier. You should also be familiar with the terminology and concepts involved with the object store, as described in [Module 6][ModDoc6] and [Module 7][ModDoc7]. You also must have *sourced* your OpenStack RC file on the command line you are using, as described [earlier in this module](openstackClients.html).
{% endBgBox %}

{% BgBox info %}
{% include /docLinks.markdown %}
Before the **openstack** client was introduced, access to the object store was managed with the **swift** command, so you may still find references to it on the Internet. While you still can use *swift*, in this tutorial we stick to the more uniform and intuitive *openstack* client, which works similarly to the *swift* command.
For more details, refer to the [official OpenStack swift][OpenStackSwift] documentation.
{% endBgBox %}

You can display help for the *openstack* command with:

``` openstack help ```

This will print a list of options for this command. Each option listed can be seen as a 'sub-command'. You may print more information about usage of the particular sub-command, e.g. for *object* and *container* which we are going to use in this section:

``` openstack help object```    
``` openstack help container```

For supporting and further documentation, please refer to the [official openstack client documentation][OpenStackClientDoc]. 


In this section, we are going to learn how to

* List your containers and files
 
* Create and delete Containers

* Upload and download files

{% BgBox info %}
The following instructions will assume that all the *Names* you choose for containers and files have **no whitespaces** in them. If the names *do* include white spaces, you have to put the name in quotation marks when using them in the commands, e.g. "Name of container".
{% endBgBox %}



### List your files

Type

```openstack container list```

and you should see the containers which you have already created.

{% BgBox terminal %}
+-------------------+
| Name              |
+-------------------+
| MyObjectContainer |
+-------------------+
{% endBgBox %}

To display the contents of a container:

```openstack object list <your-container-name>```

will list the file(s) you have just uploaded to this container. If you have followed the tutorial in [Module 7][ModDoc7], you should see the file which you uploaded via the Dashboard.

{% BgBox terminal %}
+------------------+
| Name             |
+------------------+
| SampleObject.txt |
+------------------+
{% endBgBox %}



### Manage containers and transfer files

To upload an object to the store, the file must be on the computer which you use to type the commands in the terminal. 

As an example, create a text file named *MyNewTextFile.txt*, write some text in it, and save it in your home directory (or on Windows, place it in *D:\Users\&lt;YourUserName&gt;*). First, create the new container:

```openstack container create MyTestContainer```

You can now see your new container is listed with

```openstack container list```


{% BgBox terminal %}
+-------------------+
| Name              |
+-------------------+
| MyObjectContainer |
| MyTestContainer   |
+-------------------+
{% endBgBox %}

You may **upload a file** with the command:

```openstack object create <container name> <path to local file>```

In the example, upload the file you have created to the new container *MyTestContainer*:

```openstack object create MyTestContainer ~/MyNewTextFile.txt```

*Note:* On **Windows**, you have to use the Windows command line syntax to specify the path to the file. This tutorial assumes you are familiar with how to modify the commands to use the conventions of the Windows command line.

This will have created a new container called *MyTestContainer* (unless you had a container with this name already). List the files which are there now:

```openstack object list MyTestContainer```

{% BgBox terminal %}
+-----------------------------------+
| Name                              |
+-----------------------------------+
| /home/yourname/MyNewTextFile.txt  |
+-----------------------------------+
{% endBgBox %}

Note that the path to your filename has been included in the name, which is not very convenient. Unfortunately, the only way around this is to upload a file which is in the *current working directory*. So let's delete the file, and then upload it without the path:

```openstack object delete MyTestContainer /home/yourname/MyNewTextFile.txt```    
```cd ~```    
```openstack object create MyTestContainer MyNewTextFile.txt```

And list the files again to see that the file name stands alone now:

```openstack object list MyTestContainer```

{% BgBox terminal %}
+-----------------------------------+
| Name                              |
+-----------------------------------+
| MyNewTextFile.txt                 |
+-----------------------------------+
{% endBgBox %}


You may display information about your file with:

```openstack object show MyTestContainer MyNewTextFile.txt```

This will display properties and metadata of your file, e.g. *content-length* displays the length in bytes.
{% BgBox terminal %}
+----------------+--------------------------+
| Field          | Value                    |
+----------------+--------------------------+
| accept-ranges  | bytes                    |
| account        | None                     |
| container      | MyTestContainer          |
| content-length | 112                      |
| content-type   | text/plain               |
| etag           | d41d8cd98f00b204e98...   |
| last-modified  | Thu, 02 Jul 201...       |
| object         | MyNewTextFile.txt        |
| x-timestamp    | 1435842936.81309         |
| x-trans-id     | tx42ec77c1403b47c...     |
+----------------+--------------------------+
{% endBgBox %}


Now, let's **download** that same file again and save it as another name, to see that it still has the right content:

```openstack object save --file <destination path> <container name> <file name>```

The argument ```--file``` specifies the destination path on your computer where you want to save the file. If you want to keep the name of the file, this path can be the destination folder only. If you want to rename the file at the same time, specify a file name also. 
In our example, if we want to save the file as *MyDownloadedFile.txt* into our home directory, the command becomes:

```openstack object save --file ~/MyDownloadedFile.txt MyTestContainer MyNewTextFile.txt```

You may now open the file *MyDownloadedFile.txt* in your home directory and see that it has the same text it contained originally.

Finally, let's delete the container which we used for this example:

```openstack container delete MyTestContainer```

{% BgBox important %}
This will **delete all the files** which you have uploaded to this container!
{% endBgBox %}

### Access to the Object Store from APIs


It is also possible to access your files in the Object Store from within program code. For example, there are APIs for C++ and Java. 

Access via APIs is not part of this tutorial. Please refer to the [NeCTAR support website][NectarObjectStorage] and the [official OpenStack SDKs website][OpenStackSDKs] for more information.


