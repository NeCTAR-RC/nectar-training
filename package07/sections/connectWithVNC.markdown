---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


## 7.3.4. Connecting with VNC

We will now connect to our remote desktop using VNC. We will first install the *VNC Server* on the instance, and then use a *VNC Client *(also called "viewer") on our local computer to connect to the remote desktop.

 

### Install the VNC Server on your instance

In this tutorial, we will use the VNC Server called  *vnc4server* on our instance. For an overview of other servers, refer to[ https://help.ubuntu.com/community/VNC/Servers](https://help.ubuntu.com/community/VNC/Servers)

#### Step 1. Install VNC server

To install the server, type into your* ssh shell*:

 *sudo apt-get install vnc4server*

Confirm installation of the package with [Enter].

#### Step 2. Configure the VNC server

We will now have to edit a file in order to start up the right desktop environment (see also [7.2.2. Using a command line text file editor](#heading=h.aackovoyqrw2)). The following instructions have been tested for Ubuntu 14.04 and 14.10. If you have another Ubuntu version on your instance, you may have to look online if the following instructions don’t work (see e.g.[ http://www.havetheknowhow.com/Configure-the-server/Install-VNC.html](http://www.havetheknowhow.com/Configure-the-server/Install-VNC.html)).

First, we have to start up the vnc server once, in order to create a password and generate the configuration file. In your *ssh shell*, type:

   *vncserver*

and you will be prompted to choose a password. This is a password which is used for the VNC server only - it is not the same as your ssh key (although you may of course choose the same passphrase)! 

After you finished typing and confirming your password, we will shut down the vnc server again and change some settings. To shut it down, type:

   *vncserver -kill :1*

Then, open the settings file:

*   nano .vnc/xstartup*

In the editor that comes up, make the following changes:

* Uncomment the following lines, by putting a ‘#’ in front of them:# x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &# x-window-manager &

Additionally, make the following changes depending on your desktop environment:

* Gnome :

    * Add the following lines at the bottom of the file:metacity &gnome-settings-daemon &gnome-panel &

* KDE:

    * Add the following line at the bottom of the file:startkde &

* Unity:

    * Not supported in newer Ubuntu versions

* LXDE:

    * Add the following lines at the bottom of the file:lxterminal &/usr/bin/lxsession -s LXDE &

* XFCE

    * Add the following lines at the bottom of the file:xrdb $HOME/.Xresourcesstartxfce4 &

#### Step 3. Start the server

To start the vnc server, you need to configure the resolution which your screen should have (You can change this to another resolution in the command below). To start with, choose a low resolution which will definitely fit into the screen on your local computer with some margin:

 *vncserver -geometry 1024x768 -depth 24*

The result of the command will display a line similar to the following.

 New '*hostname*:**#** (*username*)' desktop is *hostname*:**_#_**

where a number is displayed instead of the hash #. Take note of this **number following the colon (:).** This will be part of the **port number** you will need in the SSH tunnel setup, which we will do in the next steop. This will also be the number you will need to use to eventually terminate the server when you are finished using it (if you want to shut it down at all).

If you want to shut down the VNC server, type into your *ssh shell* (use the number you have taken note of instead of the #):

 *vncserver -kill :#*

For example, if your port number before was 1, type

 *vncserver -kill :1*

*Note: *Whenever you want to change your desktop environment, you have to shut down ("kill") the vnc server, Then, you have to edit your *.vnc/startup* file as discussed in the last step following the instructions for your desktop environment,  and then restart the VNC server again, as we have done above.

### Connect to the remote desktop

Keep in mind that if you try to use a VNC client right now, it will not be accessible from outside, because our instance is protected by a firewall. When we launched our instance (in section [7.1. Launch an instance](#heading=h.82q2u8whbr92)), we have only allowed secure ssh connections on Port 22 (and insecure connections to web services on Port 80). VNC servers usually provide their services on Port 5900 (or 5901, 5902..). This Port is still being blocked by our firewall! Of course, we could open up this port in our firewall and allow an insecure connection. But we don’t want this, we want a secure connection, of course. Therefore, we will see how we can channel ("tunnel") all our VNC communications through SSH.

#### Step 1: Set up ssh tunnelling	

Be sure you have the number (#) you were given in the above vncserver command. We will use this number to determine the **Destination Port**. Use this number and add it to 5900. For example, if your  number is 1, then **5901 **will be you destination port.

##### Linux / Mac

In a terminal on your local computer, create a tunnel from your local machine (Port 5900) to your instance (Port 5901) with this command:

 * ssh -i <path-to-your-keyfile> -L 5900:localhost:5901 -N** -**f -l ubuntu *NNN.NNN.NNN.NNN

where you should replace the NNN.NNN.NNN.NNN with yours instance’s IP address, and <path-to-your-keyfile> the path to where you have your key file stored (this works the same as connecting to your ssh shell, as described in [7.2.1: Connect via ssh](#heading=h.sjzg6xxm63fs)).

*Hint for Linux users:* If you copy your private key to the /home/<your-username>/.ssh folder, as we have done in this tutorial, you won’t have to specify the key every time and can skip the -i option.

*Note: *The **-f -N** options in the above command cause the tunnel to run in the background: once you have typed in the password, the command line prompt returns to your terminal. If you want to close your ssh connection, you have to *kill* it. In your terminal on your local computer, type:

  *ps aux | grep ssh* 

In the printed result, find your ssh tunnelling command and note the number on the left, which is displayed after your user name

TODO: Insert screenshot

  *kill <the-ssh-tunnel-process-number>*

If you *don’t *use the **-N -f** options, you will be logged into an ssh shell to your instance, and can use it as usual to type commands on your instance. If you type *logout* or close the terminal, the ssh tunnel will close as well.

##### Windows

1. Launch PuTTY and load your previously saved configuration by selecting the session name and clicking **Load**. (If you have Putty open, close it and then re-open it to get to this window).

![image alt text](image_26.png)

 

2. Select **SSH → Tunnels** in the left pane. Enter these values:

**Source port**: 5900**Destination:** localhost:5901****

Then, click the **Add** button. Your tunnel will now appear in the list, similar to the figure here.

3. You can save the tunnelling along with your session by selecting "**Session**" in the left pane. Click on your session name in the “Saved Sessions” pane, then click “Save”.  (or create a new name instead by typing in a new name, e.g. called “*TunneledNectarSession*”). 

4. Now you can click **Open **to start the SSH terminal. The tunnel will now be active as long as the PuTTY terminal window stays open. You can use this SSH terminal as a shell into the instance as well (as we have been doing the whole time), while simultaneously having your remote desktop open.

5. The next time you run PuTTY, you must open these saved settings by selecting the name in the "**Saved Sessions**" pane and clicking **Load**, then clicking **Open**. O,r you can simply double-click the session name to load and run the saved session.

See also[ Appendix: SSH Tunnelling](https://docs.google.com/document/d/1Xb--kUFo3jMV-RzpVA0vnA6LNxRUMGxT-zDkCD2nBxo/edit#heading=h.66j2tn80doc6) for more details about the tunnelling and troubleshooting.

#### Step 2: Install the VNC Client on your computer

We can connect to our desktop using a VNC Client (also often referred to as "VNC Viewer"). You may download any VNC viewer you want.

Here, we’ll suggest the following, depending on which OS your home Computer runs:

##### Ubuntu**

You can use the pre-installed "Remmina" client (or alternatively, install “vinagre” with the command *sudo apt-get install vinagre*). We recommend you use the default Remmina client to start with. 

##### Windows

You can use the free RealVNC viewer:[ https://www.realvnc.com/](https://www.realvnc.com/) (see also [Mac/Windows/Linux alternative client: RealVNC](#heading=h.nejgu49cljmu) and [Example client: Using RealVNC](#heading=h.8viodwqe37u5)). 

Alternatively, you can also use UltraVNC ([http://www.uvnc.com/](http://www.uvnc.com/)) or TightVNC ([http://www.tightvnc.com](http://www.tightvnc.com)). Note for TightVNC: Choose the "custom" installation mode and then select to only install the client (de-select the server!).

Choose the client you want and install it. We suggest you use RealVNC for this tutorial.

##### Mac OS X

OS X has a VNC client built in. It's been installed in every version of OS X since 10.4. It's called **Screen Sharing** and it's located in your CoreServices folder, a difficult to find folder which is part of OS X.

The easiest way to  find screen sharing via the "spotlight search": Type Cmd+Space to bring it up. Type “screen sharing” and the app should be found.

Or you can also find the application here: /System/Library/CoreServices/Screen Sharing.app (note: as of OS X 10.10 Yosemite the containing folder is now located in /System/Library/CoreServices/Applications).

You can access it through the terminal (Applications Folder -> Utilities -> Terminal.app). In the terminal, type:  *open /System/Library/CoreServices*

or on OSX > 10.10:

*  open /System/Library/CoreServices/Applications*

That will open a Finder window where you will see Screen Sharing and you can open it or create an alias if you want.

##### Mac/Windows/Linux alternative client: RealVNC

Download the client (**the viewer**) from the website [https://www.realvnc.com/download/](https://www.realvnc.com/download/).  When downloading, it may ask for your E-Mail, but you can specify some random details, the viewer will still work. When installing, choose to only install the client (the viewer):

![image alt text](image_27.png)

When you connect (we will do this in a moment), it asks you whether you accept an insecure connection. Say yes (it will in fact be secure via our tunnel).

RealVNC by default compresses the colours to save bandwidth. To see your screen in full colour, you need to go to "Options" in the initial window, then disable The checkbox for “Adapt to network speed”, and push up the slider to “Best quality”. 

#### Step 3: Connect to the VNC server

Open your VNC client ("viewer") of choice. This will generally be a very simple interface with just a few fields to fill. The following instructions are generic for all clients. There are also some more detailed instructions given below for some examples, see [Example client on Mac: Screen sharing](#heading=h.byzayaytlyzg) and  [Example client: Using RealVNC](#heading=h.8viodwqe37u5).

* Choose "VNC" as a protocol, if the viewer asks for it. 

* As **server** (or "**host**"), specify “*localhost*”. 

* If a **port** specification is required, choose *5900*. If you cannot find a port specification, you probably have to type "*localhost:5900*" instead of just “*localhost*” in the “server” (or “host”) field.

Now connect, and you should get a password prompt, in which you type the password you just chose for the VNC Server (not your ssh passphrase, unless you chose the same!). Then, you should get to the remote desktop.

*NOTE: *Do not use any ssh or security options that clients may offer, because we have just done the ssh tunnel separately ourselves. Your connection will be secure. If you have followed the instructions above, your connection is secure, even if the vnc viewer says it isn’t (The VNC viewer does actually not realise it is running through the ssh tunnel).

![image alt text](image_28.png)

Example: Connecting with TightVNC on a Windows machine. The Putty Terminal is displayed on the left.

##### Example client on Mac: Screen sharing

To connect with the in-built *Screen Sharing* app, open it (Apple+Space and type "screen sharing and open it up). Into the text field, type *localhost:5900 *and then click “connect":

![image alt text](image_29.png)

You will be prompted for your password. That’s the password you selected when you set up the VNC Server in the previous step.

![image alt text](image_30.png)

Now a window should open to the remote desktop. 

##### Example client: Using RealVNC

Start the RealVNC client (on a Mac, you can find it via the spotlight search: Cmd+Space and then type "realVNC". It will open a folder in which you find the executable).

To launch a connection, type "*localhost:5900*" into the text field. Leave the encryption setting on “**Let VNC Server choose**” and click “**connect**”.

![image alt text](image_31.png)

When it asks you whether you accept an insecure connection, say yes (it will in fact be secure via our ssh tunnel).

![image alt text](image_32.png)

You will now have to type in your password. That’s the password you chose when setting up the VNC server on your instance in the last step.

![image alt text](image_33.png)

RealVNC by default compresses the colours to save bandwidth. To see your screen in full colour, you need to go to the realVNC "Options". You can either do this in the initial login window, or when your remote desktop is open, mouse over the top of the window and select “options”.

![image alt text](image_34.png)

In the options, disable The checkbox for "**Adapt to network speed**", and push up the slider to “**Best quality**” (better quality will be slower but mostly you may want it anyway). Also enable the checkbox “**Scale to window size**” if you have issues with the window being too large for your desktop.

##### General troubleshooting

*Your colours look a bit off?*

Some clients (e.g. RealVNC and Remmina) use fewer colours and higher compression in order to reduce latency of your remote desktop. You have to change this settings in the client - each client is different so you might have to find out where you can change this. 

In Remmina, you can create a saved session (by clicking on "new") instead of using the default Quick Connect. You can change the settings there.

RealVNC by default compresses the colours to save bandwidth. To see your screen in full colour, you need to go to "**Options**" in the initial login window, then disable the checkbox for “**Adapt to network speed**”, and push up the slider to “*Best quality*”.

*Problems connecting: *

Make sure your ssh tunnel is open and you have set the right port numbers. On Windows, your PuTTY session must be open and you must have configured the tunnel as described above.

### Start up VNC automatically when instance reboots

With the current settings, you will have to manually re-start the Vnc server on your instance every time after you reboot the instance. We can automate this to save you this work, and start up the Vnc server automatically.

The easiest way is to add an execution command in a file. Log into your instance (via ssh shell) and follow these instructions:

1. Verify the location of your VNC program by typing:  *which vncserver*Most likely you will see */usr/bin/vncserver* as result. We will assume this in the following. If you get something else, you will have to use your own path instead of this one. 

2. Create a file *startVNC.sh* (or call it whatever you want) in directory */etc/init.d:*  *sudo nano /etc/init.d/startVNC.sh*

3. The editor will open. Put the following contents in the file (Note: If your username is other than *ubuntu*, you have to replace it in the 3rd line):#!/bin/bashPATH="$PATH:/usr/bin/"export USER="ubuntu"su ${USER} -c "/usr/bin/vncserver -geometry 1024x768 -depth 24"*(Note: If your vncserver is located somewhere else, as you have found out in step 1, you have to use your own path here instead of /usr/bin/vncserver)*

4. Close the editor with Ctrl+X (and confirm saving the file with yes).

5. Now we have to make this file executable   *sudo chmod +x /etc/init.d/startVNC.sh*

6. Add this file to be executed at startup:   *sudo update-rc.d startVNC.sh defaults* 	

*Optional: *

You may also create a "service" out of the vnc server, which allows you to start the vnc server any time with the following command:

  *service startVNC.sh start*

(or shut it down with *stop* instead of *start*). This is probably the more proper way to do it, but the file *startVNC.sh* is a bit more complex:

#!/bin/bash

PATH="$PATH:/usr/bin/"

export USER="ubuntu"

DISPLAY="1"

DEPTH="32"

GEOMETRY="1024x768"

OPTIONS="-depth ${DEPTH} -geometry ${GEOMETRY} :${DISPLAY} -localhost"

. /lib/lsb/init-functions

case "$1" in

start)

log_action_begin_msg "Starting vncserver for user '${USER}' on localhost:${DISPLAY}"

su ${USER} -c "/usr/bin/vncserver ${OPTIONS}"

;;

stop)

log_action_begin_msg "Stopping vncserver for user '${USER}' on localhost:${DISPLAY}"

su ${USER} -c "/usr/bin/vncserver -kill :${DISPLAY}"

;;

restart)

$0 stop

$0 start

;;

esac

exit 0

### Reconnect to the VNC afresh

Of course, you won’t have to do all the above steps every day when you want to connect to your remote VNC desktop. The only things you need to do each time are:

1. Start the ssh tunnel, as described in [Step 1: Set up ssh tunnelling](#heading=h.absjyuyg00yp) (on Windows, if you are using PuTTY, you may have created a saved session which you can start easily).

2. Open your VNC client and connect, as described in [Step 3: Connect to the VNC server](#heading=h.le0sykllemlj)

Let’s do this now to see how easy this is. Close all your applications (all your terminals / PuTTY, and your open VNC viewer). 

If on Unix/Mac, also kill your ssh tunnel (see notes at the end of [Appendix: SSH Tunnelling on Unix explained](#heading=h.1y6cffi7cx0h)).

Now, do the above steps 1. and 2. to get back to your remote desktop.

*Troubleshooting on Windows/Putty:*

If you are Windows and PuTTY, check whether you have properly saved your session last time. When you click on your session and then click "**Load**", you can check whether all the settings we have done in [7.2. Connect to the instance](#heading=h.r3c9ouqu9h79) and [Step 1: Set up ssh tunnelling](#heading=h.absjyuyg00yp) are still there. If you do not have all the details saved, change them now and save your session again (click on “Session” in the navigation panel on the left, select your session in the “Sessions” pane, and click “Save”).

Then, try again. 

### Resources

[http://en.wikipedia.org/wiki/Virtual_Network_Computing](http://en.wikipedia.org/wiki/Virtual_Network_Computing)

[https://help.ubuntu.com/community/VNC](https://help.ubuntu.com/community/VNC)

[https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-14-04](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-14-04)

[https://help.ubuntu.com/community/VNC/Servers](https://help.ubuntu.com/community/VNC/Servers)

[http://www.stuartellis.eu/articles/vnc-on-linux/](http://www.stuartellis.eu/articles/vnc-on-linux/)

[http://www.havetheknowhow.com/Configure-the-server/Install-VNC.html](http://www.havetheknowhow.com/Configure-the-server/Install-VNC.html)

[http://askubuntu.com/questions/304017/how-to-set-up-remote-desktop-sharing-through-ssh](http://askubuntu.com/questions/304017/how-to-set-up-remote-desktop-sharing-through-ssh)


