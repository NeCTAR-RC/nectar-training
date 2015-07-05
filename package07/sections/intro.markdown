---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

In this module we are going to learn how to launch an instance and how to connect to it. We are going to discuss two ways to connect: (a) with the command line and (b) to a remote desktop, with the benefits of having a graphical interface. Then, we will also take a look at how we can set up our storage so we can access it remotely and directly from our instance.

### General notes


**What is an instance?**

In Module 5 we have already discussed in more detail what an instance is, but let’s do a little recap at this point. Instances running inside the Research Cloud are just like real-life computers, except that they run remotely, in the "cloud". Here and when learning about them on the web, you will often find them referred to as "instances".

**My instance vs. my local computer**

In this document we will often talk about the "local computer" as opposed to the “instance”. The local computer is the one you are probably sitting in front of right now: It is your home or office computer that you use to connect to the instance. The instance is your virtual machine that is running in the NeCTAR cloud.

You may be familiar with connecting to remote computers already. Most likely you may have connected to a remote desktop. The same tools and techniques apply when connecting to running instances. Your instance has a public IP address and can be reached and controlled with any remote access tools you wish to use, after you have set it up for remote access. For example, you can use an SSH terminal, or alternatively connect to your remote desktop. 

In this module we will create and launch an instance (a virtual machine, short: VM) and go through the two options on how you can connect to your instance (terminal and remote desktop). 

**Use of Terminals**

Throughout the exercises, we will use a Terminal to type in commands. On Windows, we will need to download a tool called "PuTTY" for this, which we will do in an exercise below.

On Mac and Linux, there are built-in terminals available. You can access them as follows:

On **Linux** Systems, depending on your desktop environment, opening a terminal is usually achieved by clicking on the terminal symbol, or by right click on the desktop and select "*Open Terminal*". 

On a **Mac**, you can open a terminal as follows: 

1. Bring up "Spotlight Search" by holding down the "Command" and Spacebar" keys simultaneously.

2. In the search box that appears, type "Terminal" and press the Return key.

Alternatively, in the *Finder*, go to *Applications > Utilities* and you will find the Terminal app there.

 

### Overview

{% col 255,0,0 %} TODO: Write a more detailed overview about the coming content {% endcol %}

In this section, we are going to create an instance. Before we do this, we need to create an ssh key to allow encryption of our connection.

{% include /disclaimer.markdown %}
{% include /disclaimerCmd.markdown %}



### {% col 255,0,0 %} Additional notes for reviewers {% endcol %}

1. it is possible to generate three versions of this document (e.g. by setting a flag) for the three platforms: Windows, Mac and Linux, so that people can choose their platform in the beginning and don’t need to skim through stuff that’s not relevant for them. This should not take up too much extra work.

2. It should be easy to create a quick how-to for experienced users from this document. From our experience, most researchers feel more comfortable with detailed instructions though, so we will start with this and can then take it from there.

3. The videos are designed to be more compact than the length of this document may suggest. Not everything is going to be covered in the videos (e.g. creating configuration files for convenience), but we will refer to this documentation for this in the videos.

4. The screenshots will be refined to include highlights (e.g. boxes drawing attention to a section on the screen) in the final sweep of this document. Also, screenshots will be replaced by new ones, showing the possible new Dashboard interface. Especially the [Volumes](volumeStorage.html) has only test screenshots in there for now.



