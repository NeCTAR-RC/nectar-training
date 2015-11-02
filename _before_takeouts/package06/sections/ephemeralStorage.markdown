---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


Each instance you start on the cloud comes with a certain amount of On-Instance storage, also called **ephemeral storage**, which appears as two separate hard disks: The *primary* and *secondary* disk. When you launch an instance (which you will do in [Module 7][ModDoc7]), you will choose a *"flavor"*. The flavor determines the number of CPUs of your VM and also the sizes of the two disks on the On-Instance storage. The primary disk is saved with Snapshots which you take of the instance. The secondary disk is *not* backed up with Snapshots!    

**Example:** In the flavor *"m1.small"*, you get a primary disk of 10GB.  The secondary disk is 30GB---480GB depending on the flavor you select and your allocation. The first disk (10GB) is backed up when you take a Snapshot, whereas the second, larger disk is *not* included in the snapshot.

You can use the On-Instance storage as *block storage*, for example for your programs to read/write files to, or to operate your databases.

{% BgBox important %}
On-instance storage is regarded as *ephemeral* --- when you terminate your VM, or an unplanned re-start of the Hypervisor takes place in the NeCTAR Node, the data will be lost and cannot be recovered! You should treat it as **scratch space** and keep important data in either volumes or the object store.
{% endBgBox %}


{% BgBox info %}
Not all flavors provide a secondary disk. At the time of writing, the following do:

* Collection of images called *"standard-v2"*: Starting from flavor *m2.large* and bigger.
* Collection of images called *"standard"*: Starting from flavor *m1.small* and bigger. 

{% endBgBox %}

For more information on on-instance storage, please refer to the [NeCTAR support website](http://support.rc.nectar.org.au/docs/instance-storage)


