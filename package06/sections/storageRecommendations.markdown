---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

In summary, here are a few recommendations on how you may use the different storage types:

* Use On-Instance Storage as "scratch space" and/or to keep copies/clones of data (e.g. websites) which are mainly stored elsewhere. Because On-instance storage is *ephemeral*, you will lose access to your data when an unplanned restart of the hypervisor takes place, or after you terminate your instance. Therefore, the main motivation to use this storage should be to have it readily available on the instance without requiring extra Volumes, or using up your Volume storage quota for it. 

* Use Volumes or the Object Store for all data which should survive an instance termination (or an unplanned restart of hypervisor). 
You may need *Volumes* for data access from your programs which require block storage, for example to read files from a disk and write results onto it. If you have control over the source code of your program, you may instead consider to use *object storage* instead of Volumes; APIs for many programming languages are available (more information in [Module 10][ModDoc10] and [the OpenStack SDKs website][OpenStackSDKs]). 

* Use the Object Store for individual files which you want to have easy access to from many locations, or which you would like to easily share with collaborators.


* For very large data demands, you may consider using Volumes, or try to get an RDSI allocation. Check with the individual RDSI node if the data is backed up, or if users need to take care of it themselves.

{% BgBox important %}
{% include /docLinks.markdown %}
Especially with Volume storage, but also Object Storage (albeit with less urgency), you should **back up your data** at regular intervals, for example at important stages of its life cycle. If you use On-Instance storage for data which is *not* a copy of a dataset mainly kept elsewhere, backing up is extremely important.
[Module 9][ModDoc9] will guide you through a few options to back up and restore your data.
{% endBgBox %}






