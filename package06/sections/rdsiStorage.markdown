---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


You may also get access to the [Research Data Storage Infrastructure (RDSI)](https://www.rdsi.edu.au/). The aim of the RDSI Project is that researchers will be able to use and manipulate significant collections of data that were previously either unavailable or difficult to access and that there will be a consistent means of accessing this data. 

The Project is realised through the creation and development of data storage infrastructure. Specifically, the intention is to increase the sharing and re-use of research related data.

{% comment %}
The resulting data environment is not intended to be exclusive to the use of RDSI Project stakeholders. Rather, it is expected to contribute to the development of an open infrastructure that institutions, disciplines and research facilities can expand or extend. Researchers will be able to use the consistent interface established by this project for access to data collections at participating institutions and other locations as well as data held at the nodes.
{% endcomment %}

The RDSI Project will deliver a national infrastructure able to hold significant collections of research data. That infrastructure will comprise:

* A small number of high capacity *nodes* where each *node* will contain multiple petabytes of storage;

* A dedicated high speed inter-connection network with high bandwidth low latency connections that will support replication and data transfer between nodes;

* A common access infrastructure to provide a uniform experience for common researcher access to all the data held; and

* Appropriate specialist access infrastructure hosting specialist access tools appropriate to the disciplines closely related to these national collections.

RDSI is funding the setup of eight data centres or 'Nodes' as we call them, around Australia.  These Nodes are capable of storing petabytes of research data from researchers and institutions around the country. The map below shows the Node locations and the organisations who operate them:

{% img src=images/RDSIAustralia.jpg, w=70, dim=percent, align=center %} 

You may get access to data that other researchers have shared in *collections*. A large amount of discipline-specific collections are already available. To see the collections which are currently available, follow this link: [https://www.rdsi.edu.au/collections-stored](https://www.rdsi.edu.au/collections-stored). 


If you have particularly high demands on the size of your storage, the NeCTAR storage may not be sufficient for your purposes. The largest "flavor" will give your 480GB of On-Instance storage, and to get access to a large Volume storage, you need good reasons in your allocation request. 

If you have high storage demands, an alternative to the NeCTAR storage may be to lodge a request for "Collection" storage through the RDSI merit allocation scheme. You will have to contact your local RDSI node to find out how you will be able to access your storage, as this varies between the nodes among the following:

You may get access to:

* an Object Storage.
* a Volume Storage.
* a specific VM which has access to the storage.
* NFS storage which you can *mount* from your local instance.
* or other forms of access.

If you need to add RDSI storage to a NeCTAR VM, here are a couple of articles describing how to do it:

* Pierre Chaumeil's article ["How to mount RDSI storage on NeCTAR virtual machines"](http://www.qfab.org/2013/11/26/how-to-mount-rdsi-storage-on-nectar-virtual-machines/) which is on the QFAB Bioinformatics Blog.

* Kim Olson's article ["NFS mounting collection storage in Linux"](https://qriscloud.zendesk.com/hc/en-us/articles/200106199-NFS-mounting-collection-storage-in-Linux) from the QRIScloud site.

Note that some details in these articles may be specific to the respective NeCTAR nodes / providers. 

Also note that *mounting* (=setting up access) a collection with *NFS* from a virtual machine in a *different* node than the one where the RDSI collection resides will not work.  
