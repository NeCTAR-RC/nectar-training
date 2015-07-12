---
layout: package-part-ext
part: Documentation
---

{% include /docLinks.markdown %}


Using virtual machines (VM) in the Cloud is the right choice if you want to process one data set with a variety of parameters, or when you can split the data set into several pieces for parallel processing.

In other words, you have an **Embarassingly Parallel Problem (EEP)**. The application does not rely on fast shared memory or storage so it can be distributed into many independent processing units. With the Cloud, you just use the resources you actually need at the time. You can't do that in HPC, you reserve a large number of resources and use them (maybe pay for it) for the whole time.     
One often cited example is digital rendering, in which many non-interacting jobs can be distributed across a large number of nodes. These applications often work well with standard Ethernet and do not require a specialized interconnect for high performance.

In HPC, we may need to wait for the resources to become available, in the Cloud they are typically **instantly available**. With Cloud computing, you can get a whole lot of resources for a time, without the need of big capital investments. With HPC on the other hand, you have a specialized machine with its limits, which can only do so much.

Another reason to choose the Cloud can be the possibility of **software choice**: users can design virtual machines to suit their needs, including choice of OS and installed applications. In HPC, installing specialized software can be more problematic. On the other hand, on HPC systems, specialized software may already be pre-installed and ready to use for you, sometimes including the license to use it. When using the Cloud, you *can*, but also *have to* install the software yourself and pay for the license. You have to evaluate this depending on which software you require.


Last but not least, your requirements may be a simple case of needing easy access to computing infrastructure (already connected to the Internet) which you cannot easily get at your research organisation. You may not even need to use a specialized application which runs across several computers, and only need access to one or a few computers that you can use for your research or teaching. Using the cloud will save you the need to invest in local facilities and configuring access from various remote locations. In such cases, the Cloud is the right choice for you: You get **compute and storage infrastructure quickly and easily**, and the virtual machines already are accessible over the Internet. 

There are a number of reasons why the Cloud may be the right choice. See also [Module 3][ModDoc3] for a discussion of common use cases.




