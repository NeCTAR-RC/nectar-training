---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


In [Module 4][ModDoc4], we have discussed *horizontal scalability*. Horizontal scalability entails that you may run several instances of your application on separate virtual machines, all processing different parts of your data, or processing the same data in a different way (e.g. with different parameters). The Cloud is suitable for such a scenario. Distributing your problem over multiple instances is certainly an advanced topic as it requires knowledge about parallel programming. However this section will give a brief overview of the possibilities with the cloud and the key factors to look out for in your application. For more details, we refer to related [Literature](literature.html).

### Data partitioning



If your data or your problem set can be split into several pieces for processing, you may dispatch the processing to several instances. These instances are then called "*Workers*". A software framework like *MapReduce* can be used to split and dispatch your problem set. 

{% img src=images/SplitProblemDataset.png, w=50, dim=percent, align=center %}
{% col 255,0,0 %} TODO: Do a similar graphic to this, name it with "workers".. {% endcol %}


{% BgBox definition %}

**MapReduce** is a framework for processing parallelizable problems across huge datasets using a large number of computers (nodes).  MapReduce processes and generates large data sets with a parallel, distributed algorithm on a *cluster* (a collection of compute nodes). --- Source, and more details: [Wikipedia](http://en.wikipedia.org/wiki/MapReduce)

{% endBgBox %}


Whether you benefit from this model, depends on the problem that you are trying to solve: 

* Into how many pieces can the data or problem be split? 

* You should also consider the communication demands for distributing the problem to the workers --- if you chop the problem or data into very small pieces, does it still pay off to distribute it to many compute nodes, considering communication demands for the distribution? 

* The time to split the problem is also a factor: You will benefit from splitting the problem into many pieces if the process of splitting takes longer than solving the problem.

* A limitation will also be the number of virtual machine instances that you have been granted in your resource allocation. 

Detailed discussion of MapReduce frameworks or similar programming  models is not within the scope of this course. Instead, please refer to related [Literature](literature.html).

For use with OpenStack, you may *Apache Hadoop* through the [Sahara Project](http://docs.openstack.org/developer/sahara/). *Apache Hadoop* is an industry standard and widely adopted MapReduce implementation. The aim of the Sahara project is to enable users to easily provision and manage Hadoop clusters on OpenStack. Using Sahara is not part of this course, we refer to the on-line documentation at this place instead.

{% BgBox info %}
When using *Sahara*, you don’t launch the instances manually on the Dashboard as we will do in Module 7. You specify *templates* for the virtual machines, and Sahara will launch the instances for you and set them up so they can be used with your application.
{% endBgBox %}


### Use of Message Passing Interface (MPI)

The [Message Passing Interface](http://en.wikipedia.org/wiki/Message_Passing_Interface) (MPI) is a technique which is widely spread in parallel programming. MPI is a standard defining syntax and semantics of library routines that can be used to implement parallel programming in C and other languages. There are several implementations of MPI such as [Open MPI](http://www.open-mpi.org/), [MPICH2](http://www.mcs.anl.gov/research/projects/mpich2/) and [LAM/MPI](http://www.lam-mpi.org/). 

With MPI, you can spread the processing of your application over several instances. Communication between nodes is handled in different ways. Open MPI facilitates secure communication between nodes via *ssh*.

{% BgBox info %}
The MPI interface allows the programmer to manage allocation, communication, and synchronization of a set of processes that are distributed over multiple *Nodes*. Such *Nodes* may be:

* the individual **cores** in one CPU, or 
* several **CPUs** in the *same* machine, or even 
* **separate machines** which are connected in a network. 
{% endBgBox %}

If your application uses MPI to support parallelism, you may benefit from several instances. However, your better choice may be to go for a HPC solution (see discussion in [Module 4][ModDoc4]). MPI performs poorly on common OpenStack networks because communication between the nodes is slow. 

You can run MPI programs across OpenStack instances as long as your instances are allowed to communicate with each other over their fixed IPs, and your instances' firewall settings allow traffic across the ports that your MPI implementation is using.
There is however one exception: If your MPI application uses *broadast* or *multicast* in any form, it can not run on OpenStack. This is because some clouds do not support broadcast or multicast in any form (at the time of writing, neither Amazon EC2 nor OpenStack do).



You are now finished with Module 6. 
Before you continue, you may take a brief look at the [related literature](literature.html) for this Module.
Go on with [Module 7][ModDoc7] to start getting some hands-on experience with launching and using virtual machines. 
