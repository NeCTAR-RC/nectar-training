---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


This last module is designed for advanced users who want to learn more about command line tools you may use to help you automate things. Worked examples of the OpenStack command line tools *glance* and *cinder* are included.

{% include /disclaimer.markdown %}



### OpenStack clients

In the previous modules, we have used the NeCTAR Dashboard to perform simple management tasks such as launching instances, creating volumes, accessing the object store, etc. 
In this module we are going to take a look at how you can do the same tasks with other *"clients"*. For example, there are some command line "clients" --- so you can manage your instances, volumes and object store via command line tools only. For the *swift* object store also offers application programming interfaces (API).

The following *clients* are available:

| Service | Client package     | Official Source Repository URL                 | Purpose |
| ------- | ------------------ | ---------------------------------------------- | ------- |
| nova	  | python-novaclient  | https://github.com/openstack/python-novaclient	| Nova is the primary OpenStack cloud management API |
| glance  | python-glanceclient| https://github.com/openstack/python-glanceclient | Glance is the OpenStack Image management API. |
| cinder | python-cinderclient | https://github.com/openstack/cinder | Cinder provides services and libraries for access to Block Storage. |
| keystone | python-keystoneclient | https://github.com/openstack/python-keystoneclient | Keystone is the OpenStack Authentication API. |
| swift	  | python-swiftclient  | https://github.com/openstack/python-swiftclient | Swift is the ObjectStack Object Store API. |
| ------- | ------------------ | ---------------------------------------------- | ------- |

{% col 255,0,0 %}
Cover general installation for all packages here!!
{% endcol %}






