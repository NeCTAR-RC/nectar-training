---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


## 7.3.3. Connect with X2GO

We will first install the X2Go Server on your instance, and afterwards the X2Go client on your local computer. Then you can access the virtual machine’s desktop.

### Server installation

NOTE: In this tutorial we are using Ubuntu Version 14.10 on our instance and the following instructions are going to assume this. If you are using an earlier version of Ubuntu, or another Linux distribution, you may need to do other steps. This will be commented on in the following instructions at the relevant places. See the official X2go documentation for details on the steps to perform ([http://wiki.x2go.org/doku.php/doc:installation:x2goserver](http://wiki.x2go.org/doku.php/doc:installation:x2goserver)).

1. Add the x2go repository and refresh the software package system by typing into your *ssh shell*:  *sudo add-apt-repository ppa:x2go/stable*and confirm this with [Enter]. Then, type:  *sudo apt-get update*

2. Install the x2Go server. Type into your *ssh terminal*:  *sudo apt-get install x2goserver x2goserver-xsession*Confirm the question on whether to use up the said disk space with ‘**Y**’

3. We now have to install extra bindings for our desktop environment which add extra features for X2Go (e.g. file sharing). Follow the instructions for the environment you want to use (if it is not listed, see official documentation:[ http://wiki.x2go.org/doku.php/wiki:advanced:desktopbindings](http://wiki.x2go.org/doku.php/wiki:advanced:desktopbindings))

* **LXFE**:  *sudo apt-get install x2golxdebindings*(Note: If the installer package complains about unmet dependencies and suggests to remove lxde, say yes to this. Afterwards, re-install lxde again with the command "*sudo aptitude install lxde*".)

* **GNOME** (Note: only works for versions earlier than gnome 3.10, better earlier than gnome 3.08, as pointed out earlier):  *apt-get install x2gognomebindings*

* **KDE**:  *sudo apt-get install plasma-widget-x2go*

4. The X2Go server should now be running. You can check this with  *service --status-all | grep x2go*The result should show a line like this:   [ + ]  x2goserverIf the service is running. If it isn’t, you can start the server by typing:  *service x2goserver start*

If in doubt, or anything is not working, try restarting your instance before you try anything else (see [7.2.3. Re-starting your instance](#heading=h.u6cc46miv6v3)).

### Client installation

You will now install the X2Go *client* on your local computer. Depending on which OS you are using, instructions will differ. Go to the instructions below for your OS. If you have a platform not listed here, you can find additional documentation on how to install the client on the official x2go website:[ http://wiki.x2go.org/doku.php/doc:installation:x2goclient](http://wiki.x2go.org/doku.php/doc:installation:x2goclient) .A good instruction can also be found here:[ https://wiki.physik.fu-berlin.de/it/services:remote-access:x2go](https://wiki.physik.fu-berlin.de/it/services:remote-access:x2go)

* **Ubuntu**: Install the client by typing into a terminal on your local computer:  *apt-get install x2goclient*

* **Windows**: Download and install the newest windows client from[ http://code.x2go.org/releases/binary-win32/x2goclient/releases/](http://code.x2go.org/releases/binary-win32/x2goclient/releases/) 

* **Max OS X**:

    * The X2Go Mac client uses the OSX X11 server called *Xquartz. *If you don’t have it yet, you can get it here:[ http://xquartz.macosforge.org/landing/](http://xquartz.macosforge.org/landing/).  Download and install it (Note: there is also a download of the file on cnet ([download.cnet.com](http://download.cnet.com/), search there for "XQuartz"). If the download speed on the original website is painfully slow, you may download XQuartz from here. Just make sure you download the newest version.

    * At the end of the installation, it will point out that you will have to log out and log back in again for changes to take effect. You can also do this after we have changed some settings in the next step.

    * You have to enable a few settings for Mac. Start the XQuartz server. You can find it in the spotlight search (open it with Cmd+Space), and type in "xquartz" to find it. Click on it to start.In the Preferences, go to the “Security” tab and enable “**allow connections from network clients**”. ![image alt text](image_9.png)*NOTE*: If you start XQuartz after already having logged out and in again, you can access the settings (or exit full screen mode) with     *CMD + ,* (command and comma)*Important:* Because this may change any time, please refer to the most current documentation:[ http://wiki.x2go.org/doku.php/doc:installation:x2goclient](http://wiki.x2go.org/doku.php/doc:installation:x2goclient)

    * Download and install the newest x2go client from[ http://code.x2go.org/releases/binary-macosx/x2goclient/](http://code.x2go.org/releases/binary-macosx/x2goclient/)

### Connecting the X2Go client

We will now start the X2Go client application that you installed in the last step and connect it to the instance.

Step 1: Start the client

On Ubuntu, you simply type   *x2goclient *

in the command line on your local computer. On Windows and Mac, start the application as you do with any other program (find the x2goclient application).

E.g. on Mac, bring up the spotlight (Cmd + Space) and search for "x2goclient".

Step 2: Start a new session

The session settings should come up right away if you are using the client for the first time (if you are not, click on "New session", which is the top left button that looks like a blank sheet of paper). The session preferences window should look similar to this:

![image alt text](image_10.png)

1. Specify your **session name** in the first field (In the screenshot, we called it "NeCTAR Tutorial session").

2. In the "**host**" field,  type in your IP address

3. In the "**Login**" field, specify the username (in this tutorial, it is “ubuntu”).

4. Select your private SSH key in the field "**Use RSA/DSA key for ssh connection**". You may click on the little folder symbol behind the field to browse for your private ssh key file*Note for Mac/Linux:* earlier in this tutorial, we have put the key in the .ssh folder in your home directory. If you cannot see this directory, you have to create a shortcut to it. Open a terminal on your local computer, and type:   *ln -s .ssh ssh*You should now have a folder “ssh” in your home directory which you can see from the “select file” dialogue.

5. As a "**Session type**", select the Desktop environment you installed earlier (e.g. LXDE, Gnome, KDE). You may also have installed several desktop environments, in this case select which one you wish to start.

6. Click "**OK**" to get to the X2Go Start Window. If asked whether to trust the host, click “Yes” .

*Hint for Mac users: *the x2go windows may be sized too large for your screen initially, so you cannot see the usual "OK" and “Cancel” buttons in the dialogue windows. To resolve this, you simply have to select the window by clicking on the top window bar and holding the left mouse button to move the window a little bit. When you release the mouse button, the window should be automatically resized to fit your screen.

Step 3: Connect to the desktop

We will now connect to our remote desktop. On the right side of the X2Go Start Window (the window you should be seeing now, as in the screenshot below), you can see a shortcut to your session. Note that you can quickly change the desktop environment and screen resolution in the box. Don’t do this now however, let’s first try to connect with the default. You can change this next time you log in.

Click on the box with your session name, and the client is going to try to connect to your instance’s remote desktop. You will have to type in your ssh key passphrase. 

This may take a while, especially if it is the first time you connect. Don’t get impatient. This is a good time to grab a cup of coffee.

![image alt text](image_11.png)

A window will then come up which shows your desktop. Below is an image of an example when XFCE was used:![image alt text](image_12.jpg)

You can increase the screen size and the resolution of your desktop should adapt to it. Resizing the window can sometimes be a bit slow, therefore you may try different screen resolutions in the login box (which displays your session name) so you don’t have to resize the window every time.

To close your remote desktop, you should *log off.* This is in most desktop environments a power button somewhere on the desktop, or it is accessible with a right click on the desktop. Choose "logout" as an option, not “restart” or “shutdown”. If in doubt, just close the window in which the remote desktop is displayed (this is the “dirty” option, but it will also work).

When you log back in, you don’t have to specify a password for the ubuntu user, as we are using your ssh key instead.

*Important Note if you are using KDE**: *

KDE does not adapt the screen size that we set in the client. Therefore, we have to disable the "KScreen KDED module". We will do this right away. 

1. On your remote KDE desktop, go to "system settings". You can right-click on the desktop and then select “Run command…” from the drop down. 

2. In the text input field that comes up,  type "*System Settings*" and the drop-down should show the System Settings which you can click on. 

3. Go to System Settings → Startup and Shutdown → Service Manager, and uncheck "KScreen 2". 

4. Log out (Right click on desktop →  Leave →  Log out) and log back in again (You don’t have to specify a password for the ubuntu user when you log back in, as we are using your ssh key instead). You should now see your full desktop. Your screen size should adapt to what you have set in the session settings of your X2go client (default is 800x600).

### File sharing with X2Go

One nice thing about X2Go is that you can do file sharing between your local computer and your instance easily on the desktop.

Let’s now enable file sharing so we can drag and drop files between our computer to the instance’s desktop.

#### Step 1. Enable file sharing

We have to enable file sharing for our instance’s user "*ubuntu*". For this, you have to add the user to the group “fuse” on your instance. Go to your *ssh command line *to your instance (or open a terminal on your remote desktop) and type:   *sudo adduser ubuntu fuse*

*Important if your local computer is a Mac:*

You also have to enable remote login to support file sharing.

To enable file sharing, you also have to change your system preferences. Go to the Apple (on top left of your screen) → System preferences, and then select "*Sharing*":![image alt text](image_13.png)Activate the checkbox for “Remote login”:![image alt text](image_14.png)Should you have problems connecting in the following steps, try restarting your Mac computer for the changes to take effect.

*All platforms: Configure X2Go client session.*

First, let’s create a folder on the desktop (or elsewhere if you like) which we are going to use as our "shared folder". Name it for example “x2goSharedFolder”.

Think of this folder as a place where you can put files which you can then access from within your instance also. You can drag&drop files into this folder, and it will be easy to access them from your instance’s remote desktop. Conversely, you can drag&drop files from within your remote desktop into this folder, and they will appear on your local computer as well. 

 

First, we have to change the session preferences in our X2Go Client to enable file sharing. 

Close your remote desktop by logging off (or just shutting the window in which your remote desktop is displayed).

Then, go back to the X2Go Start Window in the X2Go client (If you aren’t  there already, click ‘cancel’ button in the login field). You should now see this X2Go Start Window:![image alt text](image_15.png)Via the little arrow on the right bottom of your session box, select "**Session preferences**" as shown in the screenshot above.Here you can change preferences of your session. Go to the Tab “Shared folders”, and click on the little folder symbol to select a folder of your choice which you want to use for sharing (earlier we have named this “*x2goSharedFolder*” and put it on our desktop):![image alt text](image_16.png)When you have selected the folder, don’t forget to click on the “**Add**” button next to the path to your file. Next to the new element added to the box, enable the “**Automount**” check box. Finally, click “**OK**” to close the window. 

TODO: Add a screenshot of how it should look in the end

#### Step 2. Logging in.

Now you can open your remote desktop by clicking on your session box and logging in again. You don’t have to specify a password for the ubuntu user, as we are using the ssh key instead.You will typically find the shared folder of your computer as a link on the remote desktop (see comments below for your desktop environment). 

#### Step 3. Remaining configurations for individual desktops.

Some desktop environments require some extra settings to make file sharing work. Refer to the documentation below for your desktop environment.

*If you are using LXDE:***No extra settings required. Your shared folder should be on the desktop now.*If you are using KDE:* 

Your shared folder will be visible on your remote machine by adding the "X2Go plasmoid applet" to the desktop. To add, right-click on the desktop and select “Add widget…”. In the search window that comes up, type x2go and the x2goplasmoid should come up in the list. Double-click on it to add it to the desktop. You can change the size of the widget by dragging it if it looks graphically wrong. You should then see something like this on your desktop:![image alt text](image_17.png)You can access your shared folder on your local computer via the link on the plasmoid.*If you are using XFCE*: 

File sharing has to be set up manually.The shared folder can most likely be found in the folder */tmp/.x2go-ubuntu/media/disk*. Check what the name of your folder may be:  *ls  /tmp/.x2go-ubuntu/media/disk*you should recognize your folder name, which is named after the path where it is located on your computer (if you named your folder x2GoSharedFolder, the name should end with this). Then, Do  *ls /tmp/.x2go-ubuntu/media/disk/<your-folder-name>*to see all the files you have in your shared folder (if your folder is empty, no files will be listed, of course).Right-click on the desktop and select "**Open Terminal Here**". Then, type  *ln -s /tmp/.x2go-ubuntu/media/disk/<your-folder-name> MySharedFolder*into the terminal, replacing *<your-folder-name>* with the name you found above. Be careful with spelling (it’s case sensitive) --  if you don’t get the path to the folder right, it will not work. You can also change the name *MySharedFolder* in the command to something else. When you click on the desktop again, the link to the shared folder should appear.![image alt text](image_18.png)*Note: *You can verify where your shared folder has been made available by looking into the file “*/var/log/syslog*” on your instance. You should see a line that contains the following:*“… successfully mounted <username>@127.0.0.1:30003/<path-to-your-shared-folder> to /tmp/.x2go-ubuntu/media/disk/<path-to-your-shared-folder>*

#### Step 4: Exchange files

Your shared folder can now be accessed both from your instance and your local computer.

First, on your local computer, create a text file in your shared folder (*x2GoSharedFolder*), write some text in it, and save it to the shared folder.

For example on a Mac:

1. Open TextEdit (Cmd+Space, type "textedit" and open the TextEdit program)

2. Write a message into the window

3. Click "File ->Save" and select the shared folder as a place to save the file to. Name it for example “x2goTest”.![image alt text](image_19.png)

Now, go to your remote desktop. Open your shared folder (you should have found where it is in the last step). For example, when you are using the LXDE desktop environment, your shared folder will be on your desktop.

 ![image alt text](image_20.png)

Now if you open the shared folder, you should see the text file you have just created. You may open it to see what’s in there:

![image alt text](image_21.png)

Depending on which text editor you used to create your file, it may not look the same on the remote machine. This is because it uses a Linux Operating system, and the default editor on your instance may not open the file with the program which supports this file format. For example, in the screenshot above, you can see that the *RTF* file we created on a Mac contains formatting instructions as well (you can see it is an RTF file because it is called *x2goTest***_.rtf_**). Because Linux opens it in a "plain text editor", you can see the formatting instructions as well.

This should not worry you at this point, because we are just testing how to share files with your remote desktop, but this is a good place to notice some differences between operating systems and text files.

Now, we are going to do it the other way round: We are going to create a text file on our remote desktop, copy it to the shared folder, and see that we can access it in our shared folder on our local computer as well.

On your remote desktop, **right click** on your desktop, and select "**Create new → empty file**" (This may be called different in your desktop environment, but it should not be too hard to find how to create a new file. If there is no such command on the desktop, open your file explorer, go to your Desktop in the navigation pane on the left, and try to do it there).

![image alt text](image_22.png)

Name the file "*TestOnVM.txt*".

Open the file by double-clicking on it.

A text editor will open. Write a message into the file, save it (File → Save), then close it.

![image alt text](image_23.png)

Now, drag the file from the desktop to your shared folder. A message will appear that it is being copied, and then you should see it in your shared folder:

![image alt text](image_24.png)

Now, you can open your shared folder on your *local machine* (the *x2goSharedFolder* on your desktop).

It will have the new file in it! You may double-click on it to open it and find the message you typed on your remote desktop inside.

![image alt text](image_25.png)

### Troubleshooting

If you ever run into trouble with the desktop environment, try first to log out and log back in again. If that does not work, you may have to restart the X2go server. You can do this in the *ssh command line* of the instance (you may also open a terminal on your remote desktop to do this):* sudo service x2goserver restart*

or

 *sudo /etc/init.d/x2goserver restart*

### Resources

[http://wiki.x2go.org/doku.php/doc:installation:x2goserver](http://wiki.x2go.org/doku.php/doc:installation:x2goserver)

[https://www.howtoforge.com/how-to-install-x2goserver-on-ubuntu-14.04-as-vnc-alternative](https://www.howtoforge.com/how-to-install-x2goserver-on-ubuntu-14.04-as-vnc-alternative)

[http://support.ersa.edu.au/cloud/linux-remote-desktop.html](http://support.ersa.edu.au/cloud/linux-remote-desktop.html)

