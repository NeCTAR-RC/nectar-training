---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


On the Dashboard, you can see the amount of resources you are using. You can also see how long your instances have been up and running. 

![image alt text](images/dashboardUtilization.png)


You may want to *monitor* your virtual machine(s), i.e. keep track of CPU usage, memory usage, etc. You may also want to set up system alerts. The Dashboard does not provide any tools to do this; you will have to use tools for virtual machine *monitoring*. 
Because the NeCTAR cloud uses OpenStack to manage the cloud, we require a monitoring tool which is compatible with OpenStack.

#### Ceilometer

OpenStack has a tool called *Ceilometer* which collects measurements within OpenStack. *Ceilometer* is actively developed and is now an integrated part of OpenStack. The Ceilometer project is a framework for monitoring and metering the OpenStack cloud. Other tools, which provide extended functionality and graphical interfaces, query Ceilometer for usage statistics. 

Ceilometer collects and monitors:

1. Compute resources (e.g. CPU, Memory use)

2. Network activity, including data transfer (in/out) by location.

3. Storage (including swift storage and volumes, discussed in Module 6).

Ceilometer is a service offered by OpenStack which you can query via the command line. It does not offer a convenient graphical interface for you.

Ceilometer command line reference:

[http://docs.openstack.org/cli-reference/content/ceilometerclient_commands.html](http://docs.openstack.org/cli-reference/content/ceilometerclient_commands.html) 

*Note*: Ceilometer commands require installation of the client package. On a Ubuntu image, you can do this with the command *sudo apt-get install python-ceilometerclient*. You will also need to source your OpenRC credentials file. We do this in Module 7 and 9 when setting up and accesing our storage as well.

#### DynaTrace Server

One example of a monitoring plugin which queries performance statistics provided by Ceilometer is *DynaTrace Server*. At the time of writing, this tool is relatively new. Gathered measures are configurable and can be set up dynamically depending on VM flavors. DynaTrace also offers a graphical interface.

DynaTrace Server link:

[https://community.compuwareapm.com/community/display/DL/OpenStack+Monitoring+Plugin](https://community.compuwareapm.com/community/display/DL/OpenStack+Monitoring+Plugin) 

#### Zabbix

Zabbix is an enterprise-class open source distributed monitoring solution which monitors several parameters of a network and the health and integrity of servers. It is one of the most popular system monitor tools.

Zabbix allosw users to configure e-mail based alerts for virtually any event. This allows a fast reaction to server problems. Zabbix also offers data visualisation features. All Zabbix reports, statistics and configuration parameters are accessed through a web interface. Zabbix is released unter the GPL General Public License and is free of cost. 

A snapshot of Zabbix web console is shown in the following figure.

![image alt text](images/zabbix.jpg)

TODO: apparently zappix can be used with OpenStack, but still need to verify this and try it out. May not be trivial to set up for inexperienced users. 

Useful article for advanced readers:

[https://www.mirantis.com/blog/openstack-metering-using-ceilometer/](https://www.mirantis.com/blog/openstack-metering-using-ceilometer/) 



