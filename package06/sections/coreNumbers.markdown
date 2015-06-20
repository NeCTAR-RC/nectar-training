---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

Virtual machine (VM) instances in the Research Cloud are available in standard sizes:

* Small (1 core), Medium (2 cores), Large (4 cores), Extra-large or XL (8 cores), XXL (16 cores)

* Each VM instance has 4 GB of memory (RAM) and 30 GB of local disk storage per core, so an XL VM instance has 8 processing cores, 32 GB RAM and 240 GB of local disk storage (called instance storage)

You may be unsure how many CPU cores and how much memory you need for your instance. You will have to take a closer look at your application or data analyzer to find out how much you can benefit from several cores.

Some applications are *single-threaded*, which means they only use one core anyway. In this case, you will not benefit from launching an instance with several cores. However many applications are *multi-threaded*, and support a certain number of *threads *(you may regard a thread as a working process that can run on its own core). The documentation of your application should reveal more information about that. Say your application supports 6 threads. You may then select up to the same number of cores, if you choose more you will not experience any performance gains. It is ok to select a lower number of cores, say 2 cores if your application supports 6 threads. In this case, the workload of the 6 threads will be distributed across the 2 cores, and your appication will run times slower (6 threads / 2 cores) than it could be at its maximum performance.

## OpenMP

OpenMP is an API that can be used for multi-thread handling on shared memory systems (a computer, or virtual machine, with several CPUs is a shared memory system when all CPUs may access the same memory). It uses a set of compiler directives (within the C code) that at compile time generate a multi-threaded version of your code. You can think of OpenMP as a slightly more automated way to create multi-threaded programs than if low-level thread libraries as pthread were used.

As such, also OpenMP programs gain maximum performance when it is given the same amount of cores as it uses threads (the cores may be distributed over several CPUs of the same machine).


