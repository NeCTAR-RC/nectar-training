---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


On the Dashboard, you can see the amount of resources you are using. You can also see how long your instances have been up and running. 

![image alt text](images/dashboardUtilization.png)


You may want to *monitor* your virtual machine(s), i.e. keep track of CPU usage, memory usage, etc. You may also want to set up system alerts. The Dashboard does not provide any tools to do this; you will have to use tools for virtual machine *monitoring*. 
Because the NeCTAR cloud uses OpenStack to manage the cloud, we require a monitoring tool which is compatible with OpenStack.

#### Zabbix

Zabbix is an enterprise-class open source distributed monitoring solution which monitors several parameters of a network and the health and integrity of servers. It is one of the most popular system monitor tools.

Zabbix allosw users to configure e-mail based alerts for virtually any event. This allows a fast reaction to server problems. Zabbix also offers data visualisation features. All Zabbix reports, statistics and configuration parameters are accessed through a web interface. Zabbix is released unter the GPL General Public License and is free of cost. 

A snapshot of Zabbix web console is shown in the following figure.

![image alt text](images/zabbix.jpg)

TODO: apparently zappix can be used with OpenStack, but still need to verify this and try it out. May not be trivial to set up for inexperienced users. 


https://www.digitalocean.com/community/tutorials/how-to-install-zabbix-on-ubuntu-configure-it-to-monitor-multiple-vps-servers
cat /usr/share/doc/zabbix-server-mysql/README.Debian

Last post!
http://stackoverflow.com/questions/24038157/zabbix-frontend-webinterface-gives-error-404-ubunutu-server-14-04


https://wiki.openstack.org/wiki/Zabbix-agent-adoption
http://www.zawmin.com/blog/?p=953

https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux_OpenStack_Platform/3/html/Installation_and_Configuration_Guide/chap-Monitoring_OpenStack_using_Nagios.html
https://wiki.openstack.org/wiki/Operations/Tools

#### Ceilometer

OpenStack has a tool called *Ceilometer* which collects measurements within OpenStack. *Ceilometer* is actively developed and is now an integrated part of OpenStack. The Ceilometer project is a framework for **monitoring and metering** the OpenStack cloud. Ceilometer is sometimes used by other tools (e.g. DynaTrace) which provide extended functionality and graphical interfaces, to query Ceilometer for usage statistics. 

Ceilometer collects and monitors:

1. Compute resources (e.g. CPU, Memory use)

2. Network activity, including data transfer (in/out) by location.

3. Storage (including swift storage and volumes, discussed in Module 6).

Ceilometer is a service offered by OpenStack which you can query via the command line. It does not offer a convenient graphical interface for you.

You can read up on the ceilometer command line reference in the [official OpenStack documentation][OpenStackCeilometer] and [command line reference](http://docs.openstack.org/cli-reference/content/ceilometerclient_commands.html).

*Note*: Ceilometer commands require installation of the client package. Follow instructions described [earlier](openstackClients.html) and replace *openstackclient* with *ceilometerclient*, e.g. ```pip install python-openstackclient```.


Useful article for advanced readers:

[https://www.mirantis.com/blog/openstack-metering-using-ceilometer/](https://www.mirantis.com/blog/openstack-metering-using-ceilometer/) 
