---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

You can connect to your object store with a variety of clients, as long as they support *OpenStack Swift* or *Amazon S3*. We will discuss some example clients which support *Swift* in this section.

{% BgBox important %}
**Security Warning**

Swift does NOT provide encryption of the data it stores.

If you have sensitive data that requires encryption you must encrypt the data files *before* upload them to your object store.
{% endBgBox %}

Access to your object store requires your password, but this password may be saved in a file that people who have access to your local computer can read. You must be careful to not give anyone access to your computer --- similarly, they would get access to your private ssh key that you save on your computer to log in to your instance, so be careful with giving people access to your computer.

### Get your OpenStack credentials

Before you start, you should get your login data from the [Dashboard][Dashboard]. Note that you will *not* need to do this if you just want to upload files via the Dashboard (as described in the next section). But if you want to use other tools, and to complete this tutorial, you should take note of your credentials now.

1. Your **tenant ID** is the name of your project as reported in the left hand panel of the dashboard (e.g. *pt-12345*)

2. Your **username** is reported at the top of the dashboard on the right (e.g, logged in as: *user@uni.edu.au*)

3. Look up what is specified for the *'Identity'* Service in the[Dashboard API Tab](https://dashboard.rc.nectar.org.au/project/access_and_security/?tab=access_security_tabs__api_access_tab) (you can get there via *Compute >  Access & Security >  API Access*). This will be a URL like    
    *https://**keystone.rc.nectar.org.au**:**5000**/v2.0/*     
    Take note of the text between *https://* and the colon (*keystone.rc.nectar.org.au* in the example). This will be the **Server**. Take note of the number (*5000* in the example). This will be the **Port**. You will need the **Keystone Server and Port** to authenticate your access. Also take note of the keystone version which you are using, in this case its *v2.0*.

4. For some access methods, you will also need the **credential files** (OpenRC for OpenStack, and EC2 for Amazon). You can download by clicking on the buttons on the top right on the same window (e.g. **Download OpenStack RC File**). Download the *OpenStack RC file* and save it somewhere on your computer where you can easily find it later.

5. You will also need your **OpenStack password**. This is **not** the same password that you use to log in to the Dashboard! If you have never used the OpenStack password before, you need to generate it first. You can do this in the **Settings** of the Dashboard (click next to your user name (your e-mail) on the top right and a drop down menu will open. Click on *Settings*). You need to reset your password by clicking **Reset Password** on the left panel of the settings. A long combination of numbers and letters will be displayed. This is your OpenStack password. Copy the text and save it somewhere safe.    
    {% BgBox info %} Your OpenStack password will be a long combination of numbers. At the time of writing, unfortunately this password cannot be changed yet, but this should be changed in a future update of OpenStack on NeCTAR.    
    {% endBgBox %}

### All platforms: Access via the Dashboard

We will upload some files to our Object Store using the Dashboard. This is probably the easiest method to upload files.

#### Step 1: Create a container

First, select any file on your computer --- some image, text file, or anything not so important. If you are unsure which to choose, just create a new text file, write something in it, and save it to the Desktop (or anywhere else where you can find it.

In this example, we are using a file called *SampleObject.txt* with the text "I am a sample object file" in it, saved on the Desktop. 

Go to the [Dashboard][Dashboard] and then to *Object Store > Containers*. You will get to a page which shows the overwiew of your containers.

{% img src=images/scrDashboardObjectStore1.png, w=70, dim=percent, align=center %}

First of all, you will have to create a *Container*. 
{% BgBox definition %}
A **Container** is like a folder in which you can put files. The difference to a normal folder is that a Container is intendet for a flat hierarchy, so you cannot create containers within a container --- however you may create "Pseudo Containers" within the Container, so you can still organize your files hierarchically.
{% endBgBox %}
Click on **Create Container**. As a **Name**, type in  *MyObjectContainer* (or you may use your own container name, in which case you have to consider this in the instructions below). Keep the access on **private**.

{% img src=images/scrDashboardObjectStore2.png, w=70, dim=percent, align=center %}

Click on **Create Container**. Your Container *MyObjectContainer* will then be listed on your Dashboard:

{% img src=images/scrDashboardObjectStore3.png, w=90, dim=percent, align=center %}


#### Step 2: Upload a file

Click on **Upload Object** on the right side of your container overview. A window will open in which you can **Browse** for your file. 

*Note:* If you cannot see the "Upload Object" field, you have to click on your container *MyObjectContainer* to select it.

{% img src=images/scrDashboardObjectStore4.png, w=70, dim=percent, align=center %}

You may also rename it in the given text field if you wish, for now we are going to keep the name *SampleFile.txt*.

Click **Upload Object** to close the window and upload the file to your object store. It will now be displayed on the right side of the overview. We can see that it has 27 Bytes. 

{% img src=images/scrDashboardObjectStore5.png, w=90, dim=percent, align=center %}

If you wanted to download this file (e.g. when accessing the store from another computer), you can do this here by clicking on **Download**.


### Windows/Mac: Access with Cyberduck


1. Download the newest version possible of the application *Cyberduck* (you need at least version 4.4): [http://cyberduck.ch/](http://cyberduck.ch/) 

2. Install Cyberduck. 
    - On a Mac, you will download a .zip file which contains the app. Save it to the Desktop (or any other folder). Extract the zip file by double-clicking on it.
    - On Windows, you will download an installer. You may keep the default options, if unsure. You don’t need to install Bonjour, if you are asked.

3. Create a text file on your local computer (e.g. save it on the Desktop) with the following contents. Name it *NeCTARObjectStore.cyberduckprofile* (or any other name, it just has to end with .cyberduckprofile).    
    {% BgBox edit %} &lt;?xml version="1.0" encoding="UTF-8"?&gt;    
&lt;!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"&gt;    
&lt;plist version="1.0"&gt;    
&nbsp; &nbsp; &lt;dict&gt;    
&nbsp; &nbsp; &nbsp; &nbsp; &lt;key&gt;Protocol&lt;/key&gt;    
&nbsp; &nbsp; &nbsp; &nbsp; &lt;string&gt;swift&lt;/string&gt;    
&nbsp; &nbsp; &nbsp; &nbsp; &lt;key&gt;Vendor&lt;/key&gt;    
&nbsp; &nbsp; &nbsp; &nbsp; &lt;string&gt;NeCTAR Swift (Keystone)&lt;/string&gt;    
&nbsp; &nbsp; &nbsp; &nbsp; &lt;key&gt;Context&lt;/key&gt;    
&nbsp; &nbsp; &nbsp; &nbsp; &lt;string&gt;/v2.0/tokens&lt;/string&gt;    
&nbsp; &nbsp; &lt;key&gt;Region&lt;/key&gt;    
&nbsp; &nbsp; &lt;string&gt;Melbourne&lt;/string&gt;    
&nbsp; &nbsp; &nbsp; &nbsp; &lt;key&gt;Description&lt;/key&gt;    
&nbsp; &nbsp; &nbsp; &nbsp; &lt;string&gt;NeCTAR Swift Melbourne (Keystone)&lt;/string&gt;    
&nbsp; &nbsp; &nbsp; &nbsp; &lt;key&gt;Username Placeholder&lt;/key&gt;    
&nbsp; &nbsp; &nbsp; &nbsp; &lt;string&gt;tenantId:username&lt;/string&gt;    
&nbsp; &nbsp; &nbsp; &nbsp; &lt;key&gt;Password Placeholder&lt;/key&gt;    
&nbsp; &nbsp; &nbsp; &nbsp; &lt;string&gt;password&lt;/string&gt;    
&nbsp; &nbsp; &lt;/dict&gt;    
 &lt;/plist&gt;
{% endBgBox %}

3. Double-click on your file *NeCTARObjectStore.cyberduckprofile*.

4. A Dialogue should open where you can specify Server etc. If it does not, open Cyberduck and go to **Bookmarks >  New Bookmark**.    
    {% img src=images/scrCyberduckMac1.png, w=400, dim=px, align=right %}

5. Choose *NeCTAR Swift Melbourne (Keystone)* from the drop-down box, if it is not selected yet. If it does not exist, something has gone wrong in importing the NeCTAR profile (your file *NeCTARObjectSTore.cyberduckprofile*). The image shows how it looks on a Mac, on Windows your interface will look a bit different, but the fields are the same.    

6. **Nickname**: give the connection a name of your choice, e.g. ‘*NeCTAR Object Store*’

7. As **Server** and **Port**, fill in what you took note of before when looking up the details in the dashboard. (This is probably *keystone.rc.nectar.org.au* and *5000*)

8. **TenantID:Access ID** (or **username** on a Mac): Type in your tenant ID and username (you took note of this before) separated by a colon, for example *pt-12345:user@uni.edu.au*.

9. Expand the window 
{% img src=images/scrCyberduckWindows2.png, w=400, dim=px, align=right %}
by clicking on **More Options**. You can choose a **Download Folder** to which your files will be downloaded by default. As Path you *can* (but do not have to) specify the version number of keystone, e.g. */v2.0/*. 

10. Leave all other options in the default setting, and close the window (by clicking on the window cross)

11. Double click on the symbol of your connection and Cyberduck will try to connect to your object store.     
    You will be asked to type your OpenStack password (not the password you use to login to the Dashboard!)    
    {% img src=images/scrCyberduckMac3.png, w=400, dim=px, align=right %}

12. You can now **drag and drop** files into your object store container (drag in on the folder symbol), and from the object store container to your local computer (onto your desktop or into an open folder in your file explorer). You can also right-click and **Download** (it will download into the folder you selected as *Download Folder* in the connection dialogue).


13. You can synchronize files to a folder on your local computer. Right-click on the container you want to synchronize, and select **Synchronize**. You will be prompted to select a folder to synchronize into. 
    {% BgBox important %}  **Attention!** Do not select the same folder which you have specified as *Download Folder* in the connection dialogue! This will create duplicate and nested directories. 
    {% endBgBox %}    
    Select your folder, and it will start to synchronize your files. You can then access your object store files in this folder, edit them from there, synchronize with Cyberduck again (you have to select the same folder again), and your Object Store will be up-to-date! 

14. You can edit files directly by right-clicking on them and select "**Edit**". Then you may choose a program to edit it with.

**Resources**

[NeCTAR support website][NectarCyberduck]

[Cyberduck and OpenStack HowTo](https://trac.cyberduck.io/wiki/help/en/howto/openstack) 


### Windows only: Access with Cloudberry

1. If you do not already have *CloudBerry Explorer* then download and install it on your computer from the [official website](http://www.cloudberrylab.com/free-openstack-storage-explorer.aspx).

2. Open *CloudBerry Explorer*

3. Click *File > OpenStack >  New Account*. Then, click **Add**.

4. **Display name:** use a meaningful name to this account (e.g., the name you supplied as your container in the step above)

5. **User name:** your username, which is your e-mail (e.g., *user@uni.edu.au*)

6. **API key:** your OpenStack password

7. **Authentication Service:** This is the server, port and version of keystone that you took note of with your credentials, e.g. *https://keystone.rc.nectar.org.au:5000/v2.0*

8. Tick **Use Keystone authentication**

9. Select the *Tenant name* option from the drop-down menu and insert your *tenant ID* (e.g., *pt-12345*)

10. Close the Window with ‘**OK**’, and close the next Window with "**Close**".

11. On the right window, select your display name from the drop down box. CloudBerry will connect to your object store. On the left window, you see your files of your local computer.     
    {% img src=images/scrCloudBerry.png, w=400, dim=px, align=center, css=margin-top:10px %}

12. You can drag and drop files between both windows.

13. You can directly edit a file by **Right click >  Open**.

### Linux and Mac OS X: Using any FTP client

*Prerequisite*: You should know how to use an FTP client.


You can use any FTP client, for example *Filezilla*. For this, we will have to run a program that acts like a FTP server on our own local machine. This FTP server will then communicate with the the SWIFT object storage on our cloud and provide the file exchange via the FTP service.

The following instructions are for a Debian based distribution, e.b. *Ubuntu*.
For more information, refer to the [official project page](https://pypi.python.org/pypi/ftp-cloudfs/).

Open a Terminal on your local computer to type in the following commands.

1. Install the ftp server package    
**Linux**     
    ```sudo apt-get install ftp-cloudfs```    
    or use your other package manager if you are on another distribution than ubuntu.   
**Mac OS X**
    * Install python's *pip* (unless you already have it) using the *homebrew* package manager:    
         ```brew install python```    
        {% BgBox info %}  *Alternative:* If you don't have homebrew, you may use the *easy_install* command, however there may be problems with running the *ftp-cloudfs* command with this. You may try anyway, and if it does not work, then uninstall pip again (*sudo pip uninstall python-swiftclient*) and get homebrew instead.    
        ```sudo easy_install pip```    
        {% endBgBox %}
    * Upgrade setuptools    
    ```sudo pip install --upgrade setuptools```    
    * Install python-swiftclient    
    ```sudo pip install python-swiftclient```    
    ```sudo pip install python-keystoneclient```
    * Install ftp-cloudfs
    ```pip install ftp-cloudfs```    

 2.  Start the local FTP server   
```ftpcloudfs --foreground --keystone-auth --auth-url https://keystone.rc.nectar.org.au:5000/v2.0 --keystone-tenant-separator=: &```

3. Start your favourite FTP client, for example FileZilla. If you don’t have FileZilla, you can install it with     
```sudo apt-get install filezilla```    
Your login details for the FTP client are as follows:    
    * **Server (or Host):** 127.0.0.1    
        This IP address is the one of your local computer (not an IP address you can use to access your computer from outside though) ---  Remember, you are connecting to the FTP server we just launched on our local machine.
    *  **User:** &lt;tenant&gt;:&lt;username&gt;    
        Replace &lt;tenant&gt; and &lt;username&gt; with your OpenStack credentials. 
    *  **Password:** Your OpenStack password
    *  **Port:** 2021


4. You can now browse your files and drag and drop them between both windows, as you are used to when using the FTP client. On the left side, you can see the file system of your local computer, and on the right side, you can see your object store.


{% img src=images/scrFtpCloudFS.png, w=90, dim=percent, align=center %}


You will have to do steps 2 and 3 every time you restart your local computer.

### Linux [Advanced]: Access with CloudFuse

*CloudFuse* is a lightweight open source application that may be installed on Linux servers to create a local mount point to a customer’s existing Cloud Files container. 

You can find more information and documentation about cloudfuse on the [cloudfuse github page](http://redbo.github.io/cloudfuse/) 

To set up cloudfuse for access to your object store, launch a terminal on your local computer and follow the steps below.

1. Install necessary packages    
```sudo apt-get install build-essential libcurl4-openssl-dev libxml2-dev libssl-dev libfuse-dev git```

2. Clone the CloudFuse source    
```cd```   
```git clone git://github.com/redbo/cloudfuse```

3. Compile the source code and install it    
    ```cd cloudfuse```    
    ```./configure```    
    ```make```    
    ```sudo make install```     
    ```modprobe fuse```

4. Create a file called *$HOME/.cloudfuse*     
    ```sudo nano $HOME/.cloudfuse```

5. Put the following contents into your file (replace &lt;your-tenant-name&gt;, &lt;your-username&gt; and &lt;your-password&gt; with your own credentials):
    {% BgBox edit %} authurl=https://keystone.rc.nectar.org.au:5000/v2.0/    
tenant=&lt;your-tenant-name&gt;    
username=&lt;your-username&gt;    
api_key=&lt;your-password&gt;    
cache_timeout=60
{% endBgBox %}

6. Set the right permissions:    
```chmod 600 $HOME/.cloudfuse```

7. Mount your Swift storage with the following commands    
```sudo mkdir /mnt/cloudfiles/```    
```cloudfuse /mnt/cloudfiles/```   
    Of course you may choose another name instead of *cloudfiles*, and/or create the directory somewhere else.

8. You should now be able to access your files on the directory /mnt/cloudfiles just as if they were on your local computer.    
    {% img src=images/scrCloudFuse.png, w=400, dim=px, align=right, css=margin-left:10px; %}
    ```ls -l /mnt/cloudfiles/```    
    Or open your file explorer to find your mounted drive there (see image to the right).
    You may even *drag and drop* files to and from your object storage, **as if it was a regular hard drive** or folder on your computer.

9. Every time you restart your computer, you will have to re-connect the object store with the command:    
```cloudfuse /mnt/cloudfiles/```


**Troubleshooting:**

Your username (of your local computer) may need to be part of the *fuse* user group. This can be accomplished with the following command in your computer's terminal:

```sudo usermod -a -G fuse <username>```


### All platforms: Access with the *swift* command

You may also use the *swift* command to list the files in our object storage that we just created.

You can do the following steps either 

1. If you are using **Linux** or **Mac OS X**: run *swift* on your local computer via the command line

2. Connect via ssh to your instance and follow the steps below using your *ssh terminal*.     
    In this case, you will first have to copy the OpenRC file (which you downloaded from the Dashboard in an earlier step) to your instance as well. You can do this with    
    ```scp <path-to-your-openrc-file> ubuntu@*NNN.NNN.NNN.NNN*:```    
    (replacing N’s with your instance’s IP address.)

Both options work with the following commands in the terminal. Only the terminal to  use varies for the two options: 

1. Use your local terminal

2. Use the ssh terminal

#### Step 1: Install swift

* **Linux**    
    In your terminal, type    
    ```sudo apt-get install python-swiftclient```

* **Mac**    
    1. Install python's *pip* (unless you already have it) using the *homebrew* package manager:    
        ```brew install python```    
        {% BgBox info %}  *Alternative:* If you don't have homebrew, you may use the *easy_install* command, however there may be problems with running the *swift* command with this. You may try anyway, and if it does not work, then uninstall pip again (*sudo pip uninstall python-swiftclient*) and get homebrew instead.    
        ```sudo easy_install pip```    
        {% endBgBox %}
    2. Upgrade setuptools    
    ```sudo pip install --upgrade setuptools```    
    3. Install python-swiftclient    
    ```sudo pip install python-swiftclient```    
    ```sudo pip install python-keystoneclient```

#### Step 2: Load your credentials

Make your openrc file executable so that we can use it to load the credentials:

```chmod u+x <path-to-your-openrc-file>```

Load your credentials by typing:

```source <path-to-your-openrc-file>```

You will be prompted for your OpenStack password.

{% BgBox info %}
You can try to copy and paste it into the command line prompt. If this does not work in your command line, you may edit the openrc file and assign the password directly by replacing $OS_PASSWORD_INPUT by your password, and removing the line above (the *read* command). Then, do the *source* command above again.
{% endBgBox %}

#### Step 3: List your files

Type

```swift list```

and you should see the container for your object files which you uploaded to the container.

```swift list <your-container-name>```

will list the file(s) you have just uploaded to this container.

In [Module 10][ModDoc10] we will learn more about the *swift* command.


### Access via APIs

We will discuss more options on how to connect to the object store in [Module 10][ModDoc10].


