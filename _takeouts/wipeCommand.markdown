#### Using *wipe*

The [wipe](http://wipe.sourceforge.net/) utility which provides an elaborate tool which safely erases data and is installed by default in many Linux distributions. If it is not installed, you can install it on your Ubuntu NeCTAR instance:

```sudo apt-get install wipe```

To make a *quick* wipe of a destination *device file* (e.g. */dev/vdc*), you can do:

```wipe -r -q <device file>```

The option *-q* stands for "Quick", and *wipe* will only do 4 passes, which you may consider enough.

Wipe also allows specification of a particular file instead of *&lt;device file&gt;*, but *this is not secure on journaling file systems* (which most modern Linux file systems are)! Be sure to choose your device mapping file.


Please also refer to the man pages of *wipe*:

```man wipe```

