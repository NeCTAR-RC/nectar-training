---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

{% youtube Y9JVdyRPlcg %}

{% youtube cVX3e_bYee8 %}

{% youtube eDDVUj1qyC0 %}

{% youtube EjloQRNoMT0 %}

{% youtube XrlHNvQMTN4 %}

{% youtube 7V8XB6_qR98 %}


In this module we are going to learn how to launch an instance and how to connect to it. We are going to discuss two ways to connect: (a) with the command line and (b) to a remote desktop, with the benefits of having a graphical interface. We will briefly take a look at how to run graphical applications via the command line (instead of the remote desktop), and we will also set up a web server to publish a very simple website. Finally, we will set up the different cloud storage types, so we can access the storage remotely and directly from our instance.

### General notes


**What is an "instance"?**

In Module 5 we have already discussed in more detail what an instance is, but let’s do a little recap at this point. 
In the NeCTAR Research Cloud, an instance is a virtual machine.
Instances running inside the Research Cloud are just like real-life computers, except that they run remotely, "in the Cloud". Here and when learning about them on the web, you will often find them referred to as "instances". 

**Instance _vs_ "local computer"**

In this document we will often talk about the "local computer" as opposed to the “instance”. The local computer is the one you are probably sitting in front of right now: It is your home or office computer that you use to connect to the instance. The instance is your virtual machine that is running in the NeCTAR cloud.

You may be familiar with connecting to remote computers already. You may have connected to a remote desktop, or used a command line. The same tools and techniques apply when connecting to running instances. Your instance has a public IP address and can be reached and controlled with any remote access tools you wish to use, after you have set it up for remote access. For example, you can use an SSH terminal, or alternatively connect to your remote desktop. 

In this module we will create and launch an instance (a virtual machine, short: VM) and go through the two options on how you can connect to your instance (terminal and remote desktop). 

**Use of Terminals**

Throughout the exercises, we will use a Terminal to type commands. To prepare, make sure you know how to open your Terminal by following instructions below for your Operating System. 


On **Windows**, you will use two terminals:

* The **PuTTY** terminal to connect to and type commands for the instance. You will need to download PuTTY:
You will need the files *PuTTYgen.exe* and the file *Putty.exe* from the
[official PuTTY website](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html).
This Terminal will be referred to as the **"ssh terminal"**.

* The **Windows command line** on your computer.  You can open it by typing "cmd" into the search field (on Windows < 8 on "Start"; on Windows 8 in the "App search" field). 
This Terminal will be referred to as your **"local Terminal"**.
 

On **Mac and Linux**, there are built-in terminals available. You can access them as follows:

* On **Linux** Systems, depending on your desktop environment, opening a terminal is usually achieved by clicking on the terminal symbol, or by right click on the desktop and select "*Open Terminal*". 

* On a **Mac**, you can open a terminal as follows: 

    1. Bring up "Spotlight Search" by holding down the "Command" and Spacebar" keys simultaneously.

    2. In the search box that appears, type "Terminal" and press the Return key.

    Alternatively, in the *Finder*, go to *Applications > Utilities* and you will find the Terminal app there.


{% include /disclaimer.markdown %}
{% include /disclaimerCmd.markdown %}

