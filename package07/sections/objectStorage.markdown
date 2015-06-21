---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}



## Object Storage

You can connect to your object store with a variety of clients, as long as they support* OpenStack Swift *or* Amazon S3*. We will discuss some example clients here.

**Security Warning**

Swift does NOT provide encryption of the data it stores.

If you have sensitive data that requires encryption you must encrypt the data files before upload them to your object store.

Access to your object store requires your password, but this may be saved in a file that people who have access to your account on your local computer can read. You must be careful to not give anyone access to your computer - similarly, they would get access to your private ssh key that you save on your computer to log in to your instance, so be careful with giving people access to your computer.

### Get your OpenStack credentials

Before you start, you should get your login data from the dashboard. Note that you won’t need to do this if you just want to upload files via the Dashboard (described in the next section), but to complete this tutorial, you may download your credentials now.

1. Your **tenant ID** is the name of your project as reported in the left hand panel of the dashboard (e.g. *pt-12345*)

2. Your **username** is reported at the top of the dashboard on the right (e.g, logged in as: *user@uni.edu.au*)

3. Look up what is specified for the *'Identity'* Service in the[ dashboard security API tab](https://dashboard.rc.nectar.org.au/project/access_and_security/?tab=access_security_tabs__api_access_tab) (look it up on the Dashboard here: Compute →  Access & Security →  API Access). This will be a URL like   *https://**keystone.rc.nectar.org.au**:**5000**/v2.0/* Take note of the text between *https:// *and the colon (*keystone.rc.nectar.org.au* in the example). This will be the **Server**. Take note of the number (*5000* in the example). This will be the **Port**. You will need the **Keystone Server and Port **to authenticate your access. Also take note of the keystone version which you are using, in this case its v2.0.

4. For some access methods, you will also need the credential files (OpenRC and EC2) which you can download by clicking on the buttons on the top right on the same window (eg ‘**Download OpenStack RC File**’). Save them somewhere on your computer where you can easily find them later.

5. You will also need your *OpenStack password*. This is **not** the same password that you use to log in to the Dashboard! If you have never used the OpenStack password before, you need to generate it. You can do this in the **‘Settings’** of the Dashboard (click next to your user name on the top right, which is your email, and a drop down will open. Click on *Settings*). You need to reset your password (‘**Reset Password**’ on the left panel of the settings). This will be a long combination of numbers and letters. 

Your OpenStack password will be a long combination of numbers. At the time of writing, unfortunately this password cannot be changed yet, but this should be changed in a future update of OpenStack on NeCTAR.

### All platforms: Access via the dashboard

We will upload some files to our Object Store using the Dashboard. This is probably the easiest method to upload files.

TODO : Screenshots and more details 

Step 1: Create a container

Step 2: Upload a file

### Windows/Mac: Access with Cyberduck

TODO: Test on Mac

1. Download the newest version possible of the application *Cyberduck* (you need at least version 4.4): [http://cyberduck.ch/](http://cyberduck.ch/) 

2. Install Cyberduck. You may keep the default options, if unsure. You don’t need to install Bonjour, if you are asked.

3. Create a text file on your local computer (e.g. save it on the Desktop) with the following contents. Name it *NeCTARObjectStore.cyberduckprofile* (or any other name, it just has to end with .cyberduckprofile).

 <?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">

 <plist version="1.0">

    	<dict>

		 <key>Protocol</key>

		 <string>swift</string>

		 <key>Vendor</key>

		 <string>NeCTAR Swift (Keystone)</string>

		 <key>Context</key>

		 <string>/v2.0/tokens</string>

    	<key>Region</key>

    	<string>Melbourne</string>

		 <key>Description</key>

		 <string>NeCTAR Swift Melbourne (Keystone)</string>

		 <key>Username Placeholder</key>

		 <string>tenantId:username</string>

		 <key>Password Placeholder</key>

		 <string>password</string>

    	</dict>

 </plist>

3. Double-click on your file *NeCTARObjectStore.cyberduckprofile*.

4. A Dialogue should open where you can specify Server etc. If it does not, open Cyberduck and go to **Bookmarks →  New Bookmark**.

5. Choose *NeCTAR Swift Melbourne (Keystone) *from the drop-down box. If it does not exist, something has gone wrong in importing the NeCTAR profile (your file *NeCTARObjectSTore.cyberduckprofile*).

6. **Nickname**: give the connection a name of your choice, e.g. ‘*NeCTAR Object Store*’

7. As **Server** and **Port**, fill in what you took note of before when looking up the details in the dashboard. (This is probably*keystone.rc.nectar.org.au** and **5000*)

8. **TenantID:Access ID**: Type in your tenant ID and username (you took note of this before) separated by a colon, for example *pt-12345:**user@uni.edu.au*.

9. Expand the window by clicking on "More Options". You can choose a “**Download Folder**” to which your files will be downloaded by default. 

![image alt text](image_36.png)	

10. Leave all other options in the default setting, and close the window (by clicking on the window cross)

11. Double click on the symbol of your connection and Cyberduck will try to connect to your object store. 

You will be asked to type your OpenStack password (not the password you use to login to the Dashboard!)

TODO: Insert screenshot

12. You can drag and drop files into your object store container (drag in on the folder symbol), and from the object store container to your local computer (onto your desktop or into an open folder in your file explorer). You can also right-click and "**Download**" (it will download into the folder you selected as “*Download Folder*” in the connection dialogue).

TODO: Insert screenshot

13. You can synchronize files to a folder on your local computer. Right-click on the container you want to synchronize, and select "**Synchronize**". You will be prompted to select a folder to synchronize into. Select your folder - **Attention!** Do not select the same folder which you have specified as “*Download Folder*” in the connection dialogue! This will create duplicate and nested directories. Not pretty.

14. You can edit files directly by right-clicking on them and select "**Edit**". Then you may choose a program to edit it with.

Resources

[http://support.rc.nectar.org.au/docs/object-storage#Cyberduck](http://support.rc.nectar.org.au/docs/object-storage#Cyberduck) 

[https://trac.cyberduck.io/wiki/help/en/howto/openstack](https://trac.cyberduck.io/wiki/help/en/howto/openstack) 

### Windows only: Access with Cloudberry

1. If you do not already have *CloudBerry Explorer* then[ download](http://www.cloudberrylab.com/free-openstack-storage-explorer.aspx) and install it on your computer from here: [http://www.cloudberrylab.com/free-openstack-storage-explorer.aspx](http://www.cloudberrylab.com/free-openstack-storage-explorer.aspx) 

2. Open *CloudBerry Explorer*

3. Click File → OpenStack →  New Account. Then, click "**Add**".

4. **Display name:** use a meaningful name to this account (e.g., the name you supplied as your container in the step above)

5. **User name:** your username (e.g., *xxxxx@unimelb.edu.au*)

6. **API key:** your OpenStack password

7. **Authentication Service: **This is the server, port and version of keystone that you took note of with your credentials, e.g. *https://keystone.rc.nectar.org.au:5000/v2.0*

8. Tick **Use Keystone authentication**

9. Select the *Tenant name* option from the drop-down menu and insert your *tenant ID* (e.g., *pt-12345*)

10. Close the Window with ‘**OK**’, and close the next Window with "**Close**".

11. On the right window, select your display name from the drop down box. CloudBerry will connect to your object store. On the left window, you see your files of your local computer. 

![image alt text](image_37.png)

12. You can drag and drop files between both windows.

13. You can directly edit a file by Right click →  Open.

### Linux (Mac?): Using any FTP client

XXX TEST ON MAC ALSO

Prerequisite: You should know how to use an FTP client.

You can use any FTP client, for example *Filezilla*. For this, we will have to run a program that acts like a FTP server on our own local machine. This FTP server will then communicate with the the SWIFT object storage on our cloud and provide the file exchange via the FTP service.

Open a Terminal on your local computer to type in the following commands.

1. Install the ftp server package:

   *sudo apt-get install ftp-cloudfs*

 2.  Start the local FTP server:

  *ftpcloudfs **--foreground** --keystone-auth --auth-url https://keystone.rc.nectar.org.au:5000/v2.0 --keystone-tenant-separator=: **&*

3. Start your favourite FTP client, for example FileZilla. If you don’t have FileZilla, you can install it with

  *sudo apt-get install filezilla*

Your login details for the FTP client are as follows:

  **Server (or Host): **127.0.0.1

     This IP address is the one of your local computer (not an IP address you can use to access your computer from outside though) ---  Remember, you are connecting to the FTP server we just launched on our local machine.

  **User: **<tenant>:<username>

    Replace <tenant> and <username> with your OpenStack credentials. 

   **Password:** Your OpenStack password

   **Port: **2021

4. You can now browse your files and drag and drop them between both windows, as you are used to when using the FTP client. On the left side, you can see the file system of your local computer, and on the right side, you can see your object store.

![image alt text](image_38.png)

You will have to do steps 2 and 3 every time you restart your local computer.

### Linux (experienced users): Access with CloudFuse

*CloudFuse* is a lightweight open source application that may be installed on Linux servers to create a local mount point to a customer’s existing Cloud Files container. 

More infos about cloudfuse: [http://redbo.github.io/cloudfuse/](http://redbo.github.io/cloudfuse/) 

To set up cloudfuse for access to your object store, launch a terminal on your local computer and follow the steps below.

1. Install necessary packages

    *sudo apt-get install build-essential libcurl4-openssl-dev libxml2-dev libssl-dev libfuse-dev git*

2. Clone the CloudFuse source

    *cd*

*    git clone git://github.com/redbo/cloudfuse*

3. Compile the source code and install it

    *cd cloudfuse*    *./configure*      *make*      *sudo make install*     *modprobe fuse*

4. Create a file called $HOME/.cloudfuse and copy the following into this file 

    *sudo nano $HOME/.cloudfuse*

5. Put the following contents into your file (replace <your-tenant-name>, <your-username> and <your-password> with your own credentials):

authurl=https://keystone.rc.nectar.org.au:5000/v2.0/tenant=<your-tenant-name>username=<your-username>api_key=<your-password>cache_timeout=60

6. Set the right permissions:

*chmod 600 $HOME/.cloudfuse*

7. Mount your Swift storage with the following commands

*    sudo mkdir /mnt/cloudfiles/    cloudfuse /mnt/cloudfiles/*

Of course you may choose another name instead of *cloudfiles*, and/or create the directory somewhere else.

You should now be able to access your files on the directory /mnt/cloudfiles just as if they were on your local computer.

*ls -l /mnt/cloudfiles/*

Or open your file explorer to find your mounted drive there:

![image alt text](image_39.png)

You may even drop and drag files to and from your object storage, as if it was a regular drive or folder on your computer.

8. Every time you restart your computer, you will have to re-connect the object store with the command:

  *cloudfuse /mnt/cloudfiles/*

Troubleshooting: 

Your username may need to be part of the *"fuse"* group on your local computer. This can be accomplished with the following command:

*sudo usermod -a -G fuse <username>*

### All platforms: Access with the swift command on the command line

You may also use the *swift* command to list the files in our object storage that we just created.

You can do the following steps either (1) on your local computer via the command line (if you are using Linux or Mac), or (2) connect via ssh to your instance and follow the steps below using your *ssh shell*. 

If you choose option 2), you will first have to copy the openrc file (which you downloaded in [Get your OpenStack credentials](#heading=h.9clb3nq07o7l)) to your instance as well. You can do this with

  *scp <path-to-your-openrc-file> ubuntu@*NNN.NNN.NNN.NNN*:*

(replacing N’s with your instance’s IP address.)

Both options work with the following commands in the terminal (either your local terminal with option (1), or the ssh shell with option (2) ).

Step 1: Install swift

In your terminal, type

  sudo apt-get install python-swiftclient

Step 2: Load your credentials

Make your openrc file executable so that we can use it to load the credentials:

  *chmod u+x <path-to-your-openrc-file>*

Load your credentials by typing:

  *source <path-to-your-openrc-file>*

 Step 3: Llst your files

Type

  *swift list*

and you should see the container for your object files which you uploaded to the container.

  *swift list <your-container-name>*

will list the file(s) you have just uploaded to this container.

In Module 10 we will learn more about the *swift* command.

### Access via APIs

We will discuss more options on how to connect to the object store in Module 10.


