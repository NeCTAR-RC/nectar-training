---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


In Module 4, we have discussed *horizontal scalability*. Horizontal scalability entails that you may run several instances of your application on separate virtual machines, all processing different parts of your data, or processing the same data in a different way (e.g. with different parameters). The Cloud is suitable for such a scenario. Distributing your problem over multiple instances is certainly an advanced topic as it requires knowledge about parallel programming. However we will give a brief overview of the possibilities with the cloud here and the key factors to look out for in your application. For more details, we refer to related literature at the end of this document.

## Data partitioning

If your data or your problem set can be split into several pieces for processing, for example with a framework like *MapReduce*, you may dispatch the processing to several instances. These instances are then called "*Workers*". Again, it depends on your problem that you are trying to solve: into how many pieces can the data or problem be split? A limitation will also be the number of virtual machine instances that you have been granted in your resource allocation. Also, you should consider the communication demands for distributing the problem to the workers -- if you chop the problem or data into very small pieces, distributing it to many compute nodes may not be beneficial. The time to split the problem is also a factor. You may not even benefit from splitting the problem into many pieces.

![image alt text](image_1.png)

TODO: Do a similar graphic to this, name it with "workers"..

TODO: Put in Background Info Box

MapReduce is a framework for processing parallelizable problems across huge datasets using a large number of computers (nodes).  MapReduce processes and generates large data sets with a parallel, distributed algorithm on a *cluster* (a collection of compute nodes). --- Source, and more details: [http://en.wikipedia.org/wiki/MapReduce](http://en.wikipedia.org/wiki/MapReduce)

End backgroudn info box

For use with OpenStack, you may *Apache Hadoop* through the Sahara project, [http://docs.openstack.org/developer/sahara/](http://docs.openstack.org/developer/sahara/). *Apache Hadoop* is an industry standard and widely adopted MapReduce implementation . The aim of the Sahara project is to enable users to easily provision and manage Hadoop clusters on OpenStack. Using Sahara is not part of this course, we refer to the on-line documentation at this place instead.

*NOTE*: When using Sahara, you don’t launch the instances manually on the Dashboard as we will do in Module 7. You specify templates for the machines, and Sahara will launch the instances for you and set them up so they can be used with your application.

Detailed discussion of MapReduce frameworks or similar programming  models is not within the scope of this course. Instead, we refer to related literature, of which some is listed in [6.3 Literature / Resources](#heading=h.7oyxoxndrq25).

## Message Passing Interface (MPI)

The [Message Passing Interface](http://en.wikipedia.org/wiki/Message_Passing_Interface) (MPI) is another technique which is widely spread in parallel programming. MPI is a standard defining syntax and semantics of library routines that can be used to implement parallel programming in C and other languages. There are several implementations of MPI such as [Open MPI](http://www.open-mpi.org/), [MPICH2](http://www.mcs.anl.gov/research/projects/mpich2/) and [LAM/MPI](http://www.lam-mpi.org/). 

With MPI, you can spread the processing of your application over several instances. Communication between nodes is handled in different ways. Open MPI facilitates communication between nodes via SSH.

TODO: Put in background info box

The MPI interface allows the programmer to manage allocation, communication, and synchronization of a set of processes that are mapped onto multiple nodes. Nodes may be the individual cores in one CPU, or several CPUs in the same machine, or even separate machines which are connected in a network. 

End Background Info Box

If your application uses MPI to support parallelism, you may benefit from several instances. However, your better choice is probably to go for a HPC solution (see discussion in Module 4). MPI performs poorly on common OpenStack networks because communication is slow. 

If your MPI application uses *broadast* or *multicast* in any form, it can not run on OpenStack at the time of writing. This is because some clouds do not support broadcast or multicast in any form (at the time of writing, neither Amazon EC2 and OpenStack do).[ ](http://blogs.cisco.com/datacenter/investigating-openstacks-multicast-capabilities-part-1-of-3)

You can run MPI programs across OpenStack instances as long as your instances are allowed to communicate with each other over the fixed IPs, and your security group settings allow traffic across the ports that your MPI implementation is using.


