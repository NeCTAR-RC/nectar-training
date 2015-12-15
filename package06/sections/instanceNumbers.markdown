---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


In [Module 4][ModDoc4], we have discussed *horizontal scalability*. Horizontal scalability entails that you may run several instances of your application on separate virtual machines, all processing different parts of your data, or processing the same data in a different way (e.g. with different parameters). 

{% img src=images/HorizontalScale.png, w=300, dim=px, alt=, align=center %}

The Cloud is suitable for such a scenario. Distributing your problem over multiple instances is certainly an advanced topic as it requires knowledge about parallel programming. However this section will give a brief overview of the possibilities with the Cloud and the key factors to look out for in your application. For more details, we refer to related [Literature](literature.html).

### Data or problem partitioning

If your data or your problem set can be split into separate units for processing, you may dispatch the processing to several instances. For example, if you can split the data set into several chunks, then you could send one chunk to one instance each, where each instance runs the same program to analyse a chunk in the same fashion; when all instances are finished, results are summarized. 
Or if your problem can be split into several operations (which may or may not use the same data), for example different operations to perform on a dataset, each operational task can then be dispatched to one instance each. 

The instance which splits the problem set and dispatches the tasks is called the "Master", while the instances to which tasks are dispatched are called "*Workers*". A software framework like *MapReduce* can be used to split and dispatch your problem set. 

{% img src=images/SplitProblemDataset.png, w=500, dim=px, alt=, align=center %}


{% BgBox definition %}

**MapReduce** is a framework for processing parallelizable problems across huge datasets using a large number of computers (nodes).  MapReduce processes and generates large data sets with a parallel, distributed algorithm on a *cluster* (a collection of compute nodes). --- Source, and more details: [Wikipedia](http://en.wikipedia.org/wiki/MapReduce)

{% endBgBox %}


Detailed discussion of MapReduce frameworks or similar programming  models is not within the scope of this course. Instead, please refer to related [Literature](literature.html).

For use with OpenStack, you may use *Apache Hadoop* through the [Sahara Project](http://docs.openstack.org/developer/sahara/). *Apache Hadoop* is an industry standard and widely adopted MapReduce implementation. The aim of the Sahara project is to enable users to easily provision and manage Hadoop clusters on OpenStack. Using Sahara is not part of this course, we refer to the [on-line documentation](http://docs.openstack.org/developer/sahara/) at this place instead.

***Note:*** The use of *Sahara* in the NeCTAR Cloud is ***currently not available yet***, but it will be coming soon.

{% BgBox info %}
When using *Sahara*, you don't launch the instances manually on the Dashboard as we will do in Module 7. You specify *templates* for the virtual machines, and Sahara will launch the instances for you and set them up so they can be used with your application.
{% endBgBox %}



Whether you benefit from this model, depends on the problem that you are trying to solve. There are limitations and trade-offs: 

* Into how many pieces can the data or problem be split? This limits the number of instances you can use. 

* You should also consider the communication demands for distributing the problem to the workers: if you chop the problem or data into very small pieces, does it still pay off to distribute it to many compute nodes, considering communication demands for the distribution? 

* The time to split the dataset is also a factor: You will *not* benefit from splitting the problem if the process of splitting, distributing to workers and then summarizing the results takes longer than solving the problem itself on only one instance.

* A limitation will also be the number of virtual machine instances that you have been granted in your resource allocation. 

### Auto-scaling with OpenStack Heat

Sometimes, you just need to *replicate* your resources at times when heavy workloads are experienced. For example, if you are deploying a webserver, and at a certain time lots of users access your website and create a lot of traffic and workload on your server, you can *scale up* and create a second (or third, etc.) webserver with the same configuration. The workload can then be distributed across the identical servers, and users don't experience delays any more. 

The OpenStack framework (used by NeCTAR to run the Cloud) provides a means to *orchestrate* your resources: The **Heat** project. You specify your resources in a human-readable text file, which is called a "template". *Heat* then manages the entire lifecycle of your infrastructure and applications, from creating the resources until deletion when your application has finished. The templates provide a lot of options to specify and configure your resources. It therefore has a bit of a learning curve, but it is worth the effort: After you have defined the template, you may launch your services within a matter of minutes, without having to go through the whole setup process again. You can repeatedly use the template to start up your services --- with the template, you have *automated* the process of setting up the resources you require for a particular research application.

A *Heat* template can include the instances you want to launch (and which image they should be launched from), volumes to create, security groups to use, and more. It may also include applications to be installed on the servers, e.g. the webserver application.

Most importantly for this section, Heat also provides an **autoscaling service**: You may include a "scaling group" in the template. This group is controlled by a set of *"alarms"* you define. For example, an alarm may be triggered if the CPU-workload exceeds a certain percentage. 
In which case you specify to launch an additional server. Heat takes care of this type of autoscaling for you, according to what you specify in the template.

A detailed discussion of *Heat* is not part of this tutorial, instead please refer to the [OpenStack Heat wiki](https://wiki.openstack.org/wiki/Heat) and the [NeCTAR support website](http://support.rc.nectar.org.au/docs/heat) which includes a lot of useful information and links.


### Use of Message Passing Interface (MPI)

The [Message Passing Interface](http://en.wikipedia.org/wiki/Message_Passing_Interface) (MPI) is a technique which is widely spread in parallel programming. MPI is a standard defining syntax and semantics of library routines that can be used to implement parallel programming in C and other languages. There are several implementations of MPI such as [Open MPI](http://www.open-mpi.org/), [MPICH2](http://www.mcs.anl.gov/research/projects/mpich2/) and [LAM/MPI](http://www.lam-mpi.org/). 

With MPI, you can spread the processing of your application over several instances. Communication between nodes is handled in different ways. *Open MPI* facilitates secure communication between nodes via *ssh*.

{% BgBox info %}
The MPI interface allows the programmer to manage allocation, communication, and synchronization of a set of processes that are distributed over multiple *Nodes*. Such *Nodes* may be:

* the individual **cores** in one CPU, or 
* several **CPUs** in the *same* machine, or even 
* **separate machines** which are connected in a network. 
{% endBgBox %}

If your application uses MPI to support parallelism, you may benefit from several instances. However, your better choice may be to go for a HPC solution (see discussion in [Module 4][ModDoc4]). MPI performs poorly on common OpenStack networks because communication between the nodes is slow. 

You can run MPI programs across OpenStack instances as long as your instances are allowed to communicate with each other over their fixed IPs, and your instances' firewall settings allow traffic across the ports that your MPI implementation is using.
There is however one exception: If your MPI application uses *broadast* or *multicast* in any form, it can not run on OpenStack. This is because some clouds do not support broadcast or multicast in any form (at the time of writing, neither Amazon EC2 nor OpenStack do).


A detailed discussion of MPI is outside the scope of this course---setting up an MPI program on the cloud requires previous experience and in-depth knowledge of MPI and the application to run. Please refer to related [Literature](literature.html).

### Summary: Using several instances

In summary, you may use several instances, but it depends on the application whether this is beneficial.

* You may **split the problem or data set** and distribute it, for example using *MapReduce* frameworks.

* You may configure **auto-scaling** for your resources with *Heat* in order to adapt to current workload demands.

* You may be able to run your **MPI** application on the NeCTAR Research Cloud.

Distributing your application over several instances is an advanced topic which was only described on a high level in this course. For more details, please refer to the related [Literature](literature.html).
