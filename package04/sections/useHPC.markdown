---
layout: package-part-ext
part: Documentation
---

{% include /docLinks.markdown %}


HPC is the right choice if you have an application that pushes on *all* levels of performance: 

* computing
 
* fast interconnects, and 

* high-performance storage

This computing environment is not found in a typical Cloud and is unique to HPC. 

**Optimized HPC libraries** (the result of years of research) may be required for your application, working closely with the hardware. The hardware can even be specialized "tuned" hardware which is not available on the simpler cloud computers.

Some applications rely on a technology called **MPI (Message Passing Interface)** which explicitly handles communication between computing nodes within the program code. Such applications may not run efficiently in the Cloud because inter-node communication is slower. Also, some Clouds do not support a technique called *broadcast* or *multicast* in any form. So if your *MPI* implementation uses this, it cannot run in the Cloud. As a rule of thumb, if your application is using *MPI*, then HPC is probably the right choice.

Some applications require very **fast interconnects** (e.g., *Infiniband* or *High-Performance Ethernet*) which require communication that bypasses the OS kernel. This makes the use of the Cloud very difficult because most virtualization schemes do not support this "*kernel bypass*". If high-performance inter-connections are not available, the application runs slowly and get no performance gain when adding more nodes. So if your application demands high-performance inter-connections between the compute nodes, you should choose HPC over the Cloud.

Other specialised hardware which your application may benefit from are **performance accelerators** or *SIMD* units (Single-Instruction Multiple Data processors), available from *NVidia* and *AMD/ATI*. This is not found on typical Cloud infrastructure --- if your application makes use of such performance accelerators, you should choose an HPC infrastructure which provides this.

Some HPC solutions already offer a set of pre-installed **software packages**, sometimes including the license, ready for you to use. When using the Cloud, you have to install specialized software yourself, and pay for the license. 


