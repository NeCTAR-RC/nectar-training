---
layout: package-part-ext
part: Documentation 
---

{% include /docLinks.markdown %}

Cloud providers offer a variety of services, the most common of which are:

* Compute

    Computing resources made available to you in form of a virtual server. 
We will talk more about such *virtual machines* in a moment.

* Storage

    Storage is made up of many distributed resources, but the storage still acts as one.		
You can dynamically extend or decrease requirements.

    Storage includes the traditional "Volume storage" (which acts as a hard disk) and also “Object storage” (storage of individual files). 
We will talk more about storage in the later training packages starting from [Module 6][ModDoc6].

* Networking

    Virtual servers of several users may be connected through a network just as with physical computers networked together.
This is called "Virtual Lan" ([VLAN](http://en.wikipedia.org/wiki/Virtual_LAN)). 
Virtual networking is not covered in this course.

* Databases

    Cloud computing can be used to provision relational and non-relational database engines. 
Discussion of databases is not going to be covered in this course.

<!--
* Administration and security

    * Identity management	

    * Access control

    * Monitoring & logs

    * and more..
-->

* Various software services

* Development & deployment platforms


### Examples of cloud computing

Some examples of cloud computing you are probably already using include

**Google Services**: *Google Drive* handles on-line storage on the google servers, which works with the cloud apps *Google Docs, Google Sheets, Google Slides* and more. You can use *Drive* on computers, iPads or smartphones.

**Apple iCloud**: Mainly used for online storage, backup, and synchronization of mail, contacts, calendar, and more. Apple offers cloud-based versions of its word processor *Pages* and other software like *Keynote* for presentations and *Numbers* for spreadsheets. They can be used by *iCloud* subscribers.

**Amazon Cloud Drive**: Storage at the big retailer is mainly for music, preferably MP3s that you purchase from Amazon, and images. The *Cloud Drive* also holds anything you buy for the *Kindle* eReader.

**Dropbox** and similar services offer on-line storage. You can choose to only store your files on-line, or additionally keep a synced version of them on your local hard-drive. Because of the synchronization of local and online storage, these services can be characterized as a *hybrids* of cloud and local storage.

**Facebook, Instagram** and other social media platforms.

**Chromebook**: This is an example of a device that is *completely* based on the cloud. This is a kind of laptop which has very simple hardware: It runs the *Chrome OS*, but everything else is online: Apps and storage are in the cloud. The main drawback of such devices is that they are basically useless if there is no Internet connection. Currently, at the time of writing (*April 2015*), work is being done to address this issue by expanding the offline capabilities of the Chromebook.

### Types of cloud services

There are 3 different types of cloud services which can be distinguished. They provide different levels of abstraction to computing services to the user.


**Software-as-a-Service (SaaS)**

The customer (the user or business) subscribes to an application which they then access over the Internet. This is sometimes referred to as *on-demand software* and is usually priced on a pay-per-use basis, or using a subscription fee. Users do not manage the infrastructure and platform where the application runs. This eliminates the need for them to install and run the application on the user's own computers, simplifying maintenance and support.

*Examples*: Dropbox, Salesforce.com, Google Docs.


**Platform-as-a-Service (PaaS)**

The customer can create its own custom applications. Specialized application programming interfaces (*APIs*) are provided for building applications on the Internet. *PaaS* services provide a platform on which businesses can create and deploy custom apps, databases and services integrated into one platform. 

*Examples*: Windows Azure and Google App Engine.

**Infrastructure-as-a-Service (IaaS)**

Computing resources are provided to the consumer. Users are free to set the resources to use as they want. Providers of *IaaS* services offer computers (most typically *virtual machines*) and other resources (like storage, firewalls, networking and software bundles).

*IaaS* services provide a "backbone" that others can rent. For example, *Netflix* provides their services by using *Amazon*'s cloud services.


*Examples*: Amazon Web Services, Rackspace, and Google Compute Engine and the NeCTAR services.


{% BgBox definition %}

–-- Definition of service types according to [ "The National Institute of Standards and Technology](http://csrc.nist.gov/publications/nistpubs/800-145/SP800-145.pdf) (PDF, retrieved April 21st, 2015).

*Software as a Service(SaaS).*  
The capability provided to the consumer is to use the providers applications running on a cloud infrastructure. The applications are accessible from various client devices through either a thin client interface,such as a web browser (e.g., web-based email), or a program interface. The consumer does not manage or control the underlying cloud infrastructure including network, servers, operating systems, storage, or even individual application capabilities, with the possible exception of limited user-specific application configuration settings.

*Platform as a Service (PaaS).* 
The capability provided to the consumer is to deploy onto the cloud infrastructure consumer-created or acquired applications created using programming languages, libraries, services,and tools supported by the provider (this capability does not necessarily preclude the use of compatible programming languages, libraries, services, and tools from other sources). The consumer does not manage or control the underlying cloud infrastructure including network, servers, operating systems, or storage, but has control over the deployed applications and possibly configuration settings for the application-hosting environment. 

*Infrastructure as a Service(IaaS).* 
The capability provided to the consumer is to provision processing, storage, networks, and other fundamental computing resources where the consumer is able to deploy and run arbitrary software, which can include operating systems and applications. The consumer does not manage or control the underlying cloud infrastructure but has control over operating systems, storage, and deployed applications;and possibly limited control of select networking components (e.g., host firewalls) 

{% endBgBox %}




Researchers will probably find *IaaS* services most useful, while *SaaS* tools are broadly useful for individual work and collaboration. 

The 3 service types can be characterized with two properties: 

* Constrainedness (how much the user can control) and 

* Automation 

Services which are less constrained give the user more control, but instead also offer less automation, and more work is required to get the desired applications up and running. The figure below shows examples of services along the scales of constrainedness and automation. Services to the left are less constrained, but also provide less automation. Towards the right end of the scale, capabilities are provided "out of the box," but are also more constrained in how they can be used.

{% img src=images/serviceTypesConstrainedness.png, w=80, dim=percent, align=center %}






