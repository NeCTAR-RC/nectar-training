---
layout: package-part-ext
part: Documentation 
---

{% include /docLinks.markdown %}

Through a series of "town hall" meetings in 2010, the Australian research community voiced their need for a flexible, low cost computing resource that they could access on demand. A cloud solution quickly became the sought after approach, with its low barriers to entry well matched for the collaborative nature of academic research.

The Australian government is now funding a cloud that is making it simple for researchers across disciplines to access IT resources, collaborate, and share their findings: **NeCTAR** (short for **N**ational **e**Research **C**ollaboration **T**ools and **R**esources) is an Australian Government project conducted as part of the Super Science initiative and financed by the Education Investment Fund. 

The NeCTAR project aims to support the connected researcher who has access to a full suite of digitally enabled data and resources, specific to their research. The vision is to enhance research collaboration by building information and communications technology infrastructure. NeCTAR is building:

* Virtual Laboratories	

* eResearch Tools

* The Australian Research Cloud

We will talk about *Virtual Laboratories* and *eResearch Tools* in [Module 2][ModDoc2]. 
The majority of this course will deal with the *Australian Research Cloud*. So at this point let's have a glimpse at what the Research Cloud (RC) is.  
The Australian Research Cloud is offering a *secure and robust hosting service*:

* The main function of the Research Cloud is to provide **"Infrastructure as a Service" (IaaS)**. **Virtual machines** and **cloud storage** can be provisioned on demand through a web Dashboard or an API.

* The Research Cloud is available for research use to any academic researcher in Australia. 

    * Access to the NeCTAR Cloud dashboard is done through the **Australian Access Federation (AAF)** (or Tuakiri in New Zealand). This allows you to login using your institiutional username and password.

    * Any researcher who logs in to NeCTARs web Dashboard can immediately have access to a small Project Trial allocation (2 cores for 3 months).

    * To obtain a larger allocation you need to submit an allocation request through the web Dashboard.

* The Cloud consists of **8** ***Nodes***  and around 32,000 processor cores distributed across Australia and New Zealand

    * A *Node* can be seen as a data center at a physical location which provides the services. All Nodes are part of a *federated cloud*. A user may specify the zone in which their virtual machines will be situated, so they can get the best network responsiveness.    

* The completed cloud will be a very significant Australian resource and one of the largest *OpenStack* based clouds in production worldwide.

    * *OpenStack* is a set of software tools for building and managing cloud computing platforms. Backed by some of the biggest companies in software development and hosting, as well as thousands of individual community members, many think that OpenStack is the future of cloud computing.

Today, NeCTAR enables Australian researchers to easily put their ideas, tools, research applications and data online. The new cloud capabilities have equipped researchers with the ability to easily share and manipulate their data, and publish it to other researchers anywhere around the world.

For a more detailed story about NeCTAR using OpenStack, please refer to  
[the OpenStack NeCTAR user story](https://www.openstack.org/user-stories/nectar/).



{% BgBox info %}
The NeCTAR services are free to you, however you need to request the amount of resources you need in advance. When you have used up your resources (e.g. processing time), you will have to request an extension.
{% endBgBox %}
