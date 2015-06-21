---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


Each instance you start on the cloud comes with a certain amount of On-Instance storage, which appears as two separate hard disks: The primary and secondary disk. When you launch an instance (in [Module 7][ModDoc7]), you will choose a *"flavour"*, which also determines the sizes of the two disks on the On-Instance storage. The primary disk is saved with Snapshots you make of the instance. The secondary disk is *not* backed up with Snapshots!    
**Example:** In the flavour *"m1.small"*, you get a primary disk of 10GB.  The secondary disk is 30GB to 480GB depending on the flavour you select and your allocation. The first disk (10GB) is backed up when you make a Snapshot, whereas the second, larger disk is not included in the snapshot.

{% BgBox info %}
Not all flavours provide a secondary disk. At the time of writing, the following do:

* Collection of images called *"standard-v2"*: Starting from flavour *m2.large* and bigger.
* Collection of images called *"standard"*: Starting from flavour *m1.small* and bigger. 

{% endBgBox %}

{% BgBox important %}
On-instance storage is regarded as *ephemeral*. You should treat it as scratch space and keep important data in either volumes or object store.
{% endBgBox %}

For more information, please refer to the [NeCTAR support website](http://support.rc.nectar.org.au/docs/instance-storage)


