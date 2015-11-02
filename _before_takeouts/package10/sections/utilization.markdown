---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


On the Dashboard, you can see the amount of resources you are using. You can also see how long your instances have been up and running. 

![image alt text](images/dashboardUtilization.png)


You may want to *monitor* your virtual machine(s), i.e. keep track of CPU usage, memory usage, etc. You may also want to set up system alerts. The Dashboard does not provide any tools to do this; you will have to use tools for virtual machine *monitoring*. 
Because the NeCTAR cloud uses OpenStack to manage the cloud, we require a monitoring tool which is compatible with OpenStack.

OpenStack has a tool called *Ceilometer* which collects measurements within OpenStack. *Ceilometer* is actively developed and is now an integrated part of OpenStack. The Ceilometer project is a framework for **monitoring and metering** the OpenStack cloud. 

Ceilometer is a service offered by OpenStack which you can query via the command line. 
It collects and monitors *performance* and *usage* data:

* Compute resources (e.g. CPU, Memory use, number of instances used)

* Network activity, including data transfer (in/out) by location.

* Storage (including object storage and volumes).


Ceilometer commands require installation of the client package. Given you have already used the *openstack* command in the previous sections, all you need to do is
 
```pip install python-ceilometerclient```

or if you haven't used *pip* but your Linux package manager, install the client with your package manager as well, e.g. on Debian/Ubuntu:

```sudo apt-get install python-ceilometerclient```

You will also need to *source* your OpenStack RC file as described [earlier](openstackClients.html).

If you haven't installed any OpenStack command line clients, follow instructions described [earlier](openstackClients.html) and replace *openstackclient* with *ceilometerclient*.

Detailed instructions on how to use *ceilometer* is out of scope of this tutorial.
You can read up on the ceilometer command line reference in the [official OpenStack documentation][OpenStackCeilometer] and [command line reference](http://docs.openstack.org/cli-reference/content/ceilometerclient_commands.html). Good documentation and useful links are also given on the [NeCTAR support website](http://support.rc.nectar.org.au/docs/ceilometer) and in [this good introductory article](https://www.rdoproject.org/CeilometerQuickStart).

