---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

Using the command line may not feel very intuitive, especially for beginners. Aside from that, sometimes we need to run software that has a graphical interface. 

As an alternative to connecting with a ssh terminal, we can also connect to the *desktop* of our instance and get a graphical interface as we know it from our own computers. A **remote desktop login** allows users to connect to their desktop while being physically away from their computer. 

You can also connect to your own home computer's desktop while you are away, if you set up your home computer accordingly with remote access. This may be a bit difficult to do from your organisation or from your home, as you need access to the computer via the internet from outside, which may require the permission of firewalls used on the premises, and you need a fixed IP address.

However on your NeCTAR instance, it is easy to set up a remote desktop, because the instance is already accessible from outside.

{% BgBox info %}
Some remote desktop solutions allow only one user to see the desktop at the same time. Other software also allows *desktop sharing* in which several users can see a desktop simultaneously. Such a shared desktop can be used as a platform for *real-time collaboration*. This mostly requires a separate setup, which is not part of this tutorial.
{% endBgBox %}

To connect to a remote desktop, the remote machine (your instance) has to have a **remote desktop server** installed and running. On your home or office computer, you have to install a **remote desktop client** (sometimes called *"viewer"*) which connects to the remote desktop server on your instance. The client then displays the desktop of your remote machine. It is like a "window" into your instances desktop; The desktop environment itself is running on the instance.

### Terminals on remote desktop *vs* SSH shell terminal

We have previously connected to the instance with via a *ssh terminal*. When we get a window into the desktop of our instance, we can open a terminal on the desktop as well. 

The image below shows both (1) a ssh terminal (left) and (2) a desktop with an open terminal (right):

{% img src=images/scrTerminalOnRemoteDesktop.png, w=80, dim=percent, align=center %}

So what is the difference between the two terminals? When you type **commands** in either of them, it **will have the same effect**. They are both terminals that you can use to control your instance. However, the difference is that 

1. is set up through a secure ssh communication line with your instance. If we use a ssh terminal, **only text** is being transferred (the commands you type and the responses you get). This is very fast, but you cannot run graphical applications, because you can only communicate with the instance via text.    
*Note*: it actually is possible to run graphical applications via the terminal as well, with some disadvantages. This is discussed [later in this module](guiViaSSH.html), but this is very slow and usually not recommended. 

2. is connected securely as well (at least the way we will set it up in this tutorial). But instead, the communication includes graphical data and events (e.g your mouse clicks, and the windows displayed). This is slower than using the terminal only, but you may find it is still fast enough to work with. You can run graphical applications and use the OS menu to find programs and change settings, which may be easier for many of us.

### Remote desktop protocols

When you are connected to a remote desktop, everything you do to interact with the system, for example clicking the mouse, moving a window or typing on your keyboard, is communicated to the remote machine (in this case, your instance). For this kind of communication, computers use *"protocols"* which are designed for this purpose. 

The type of protocol determines properties of the remote desktop, for example how secure it is, how fast it works and what kind of desktop environments it supports. In this tutorial we will use two different protocols to connect to our remote desktop: *NX* and *VNC*.

{% BgBox info %}
Some wide-spread protocols include:

* RDP (Remote Desktop Protocol)
    * Originally developed by Microsoft to connect to Windows machines.
    * The protocol is **not very secure**, therefore setting up *"tunnelling"* through a secure connection is required.
* NX
    * NX compresses the data to minimize the amount of information transmitted. NX also caches data to make the session as responsive as possible. For example the first time a menu is opened it may take a few seconds, but on each subsequent opening the menu will appear almost instantly. Therefore, NX allows **fast speed** even with slow internet connections.
    * NX uses the SSH protocol to send its data and is therefore **secure**.
* VNC (Virtual Network Computing)
    * The VNC Protocol (called the RFB protocol) is very simple. It is based on graphic primitives from server to client ("Put a rectangle of pixel data at the specified X,Y position") and event messages from client to server. This makes VNC **a bit slow**.
    * By default, this is **no secure protocol**. Therefore, you need to *"tunnel"* the connection via a secure SSH connection to make it secure. This may seem a bit complicated to achieve for beginners. Alternatively, some clients like [UltraVNC](http://www.uvnc.com/)) support the use of an encryption plugin which encrypts the entire VNC session.
    * Because VNC is quite popular, the **client software options** are pretty good for Unix and Windows platforms.
    * VNC allows multiple users to see (share) the same desktop.
    * To transfer files, printing or audio requires separate services. The VNC only handles displays and inputs, such as interaction with keyboard and mouse.
    * Users may access desktops with VNC through their Web browser, without needing to install separate viewer applications. VNC displays a desktop within a browser window by running a Java applet, and this facility should work on any system that has a JVM installed.
    * VNC does not support the newer "3D desktops" (e.g. the newer GNOME/Unity or KDE desktops environments. The desktop environments have to be run in classical 2D mode for it to work (e.g. GNOME Flashback).
    * To learn more about VNC, here is a [good article](http://www.stuartellis.eu/articles/vnc-on-linux/)

**Free remote desktop client and server software** includes:

* Vnc4server
    * the main VNC server software for Linux.
* UltraVNC, RealVNC, TightVNC
    * popular clients for VNC sessions
* X2Go
    * An open source product which is pretty fast.
    * It uses the NX protocol and is operates through a secure SSH connection
    * Supports remote audio, printing, clipboard, file sharing etc.
    * Can share a user's session remotely, but it has to be set up separately.
    * It is fairly easy to set up
    * There is even a readily available browser plugin to make remotely controlling another PC possible from a web browser. *But:* Port forwarding and Dynamic DNS are recommended if you're using this over the Web.
    * Due to the use of older NX libraries, it has problems with the newer "3D Desktops", e.g. Gnome/Unity and newer KDE desktop environments. Only the older environments are supported.
    * No Android / iOS client available, unless using the web interface
* NX Server, free edition
    * Easy to set up
    * Not very fast
    * Only free to 3 users
    * Can't *share* a user's session remotely.
* FreeNX Server
    * A Server for the NX protocol, similar to NX Server, but free.
    * No real good documentation, not easy to install
    * Can't *share* a user's session remotely.
* [NoMachine](https://www.nomachine.com/))
    * A client to connect to an NX server (e.g. FreeNX).
    * Not free for commercial use (only private)
    * Simultaneous connections from only 2 users.
* NeatX (*outdated*)
    * Google has released NeatX, a complete independent implementation of the NX protocol.
    * Neatx was developed as part of an internal project which has now finished. It had no releases and is not being actively developed.
    * Can't *share* a user's session remotely.
* xrdp
    * uses the RDP protocol (which is not very secure)
    * Servers are also available for Unix and Mac.

**Commercial products** may be better and easier to set up than the free software listed above, but they come at a cost (at least for commercial use). Popular software includes:

* [TeamViewer](https://www.teamviewer.com/en/index.aspx)
    * supports Windows, OS X, Linux, Android, and iOS
    * free for personal use
    * setup very easy
    * pretty expensive for commercial / business use
* [Splashtop](http://www.splashtop.com/)
    * supports Windows, OS X, Linux, Android, and iOS
    * allows you to stream audio and video across computers with minimal latency
    * very easy to use and set up
* [RealVNC](http://www.realvnc.com/)
    * The "Official" VNC software
    * Offers its client and server apps for Windows, OS X, Linux, Android, iOS, Chrome
    * free for basic individual private use, but added features and support come at an extra cost.

Wikipedia offers a good [comparison of remote desktop software](http://en.wikipedia.org/wiki/Comparison_of_remote_desktop_software).

{% endBgBox %}

The options which are easiest to set up and provide a fairly good user experience are **X2GO** (using the NX protocol) and **VNC**. In the following exercises, we will see how we can set up both of these options using freely available software.

**VNC vs X2Go**

X2Go uses the NX protocol, and VNC the RFB protocol. This makes for different properties and advantages of each approach.

The VNC protocol is pixel based. This can make it a bit slow. One advantage is that it is widely used, and several available remote desktop products use this network protocol. This means that you may use *any* VNC viewer (client) to connect to a system that offers remote access with the VNC protocol.

The NX protocol (used by X2Go) has a better understanding of the underlying graphic layout than VNC (which is pixel-based). Therefore, it is often more efficient (faster).

*In summary:*

VNC:

* inherent support of different platforms: you can install it on Unix and Windows servers
* is widely used, hence there is a large number of tools
* is slow
* is inherently insecure, it takes a bit more work to set up a secure connection

NX (X2Go):

* is fast
* easily integrates with security plugins
* there are not many well-maintained servers and clients available (X2Go is one of the few)
* Servers can only be installed on Unix servers, for Windows/Mac there are only clients (no servers)
* On Mac computers, installation of the X2Go client is a bit more work than on Windows and Linux, and usage can also be a little slower.

