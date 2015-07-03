---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

Recently, a lot of people are reporting that they cannot launch NeCTAR instances.  The typical behavior is that the launch fails with a cryptic error message "no valid host was found".

The fundamental meaning of the "no valid host was found" error is that there is no compute node in the relevant availability zone (or zones) that can satisfy your instance launch request.  

- General availability of unallocated compute resources in the availability zone that you requested.  (Or if you didn't specify a specific availability zone, then across the entire cluster.)
- Availability of enough compute resources on a single compute node.
- If you are requesting a non-standard flavor, unavailability of resources that satisfy the constraints of that flavor.  (For example, if you are requesting a special instance with a GPU and all GPU nodes are in use.)


The resource shortage problem is exacerbated by the fact that most NeCTAR instances are seriously underutilized. That is to say, most of the time, most NeCTAR instances are idle.  It has been observed that the average CPU utilization rate across the NeCTAR federation is less that 5%, and many large instances sit idle for days, weeks or months at a time.

The problem is that people typically want the compute resources to be available when *they* are ready to use them.  But they don't make the connection that if they launch and "sit" on an instance to guarantee that, the resources *won't* be available for other people.  

https://wiki.ubuntuusers.de/LUKS

sudo dd if=/dev/urandom bs=1M count=8 of=GERÄTEDATEI

### Hinweis:

GERÄTEDATEI kann statt etwa einer Partition auch eine gewöhnliche Datei sein, welche dann als Container (Image) ebenfalls in den weiteren Schritten verschlüsselt, mit einem Dateisystem formatiert wird und danach geöffnet und mit beliebigen Dateien befüllt werden kann. Dazu gibt man an dieser Stelle für count die gewünschte Größe in MB an.

### Experten-Info:

Bei sehr großen Containerdateien können sehr große bs-Werte wie 200M bei count=1 je nach System die Erzeugung der Datei in der gewünschten Größe stark beschleunigen. In diesem Beispiel wäre die Datei 200M * 1 = 200M groß. Alternativ beschleunigt auch die Verwendung von if=/dev/zero durch Nullen anstelle von Zufallszahlen wie bei urandom.


### Terminating an instance

{% BgBox important %}
You must *detach* any Volumes from your instance before terminating it.  (There is a rather nasty bug in OpenStack that causes serious problems if you attempt to Terminate an Instance while it has Volumes attached. Recovering your volume requires the NeCTAR Node operation staff to manually patch a database, which is a messy and potentially risky procedure.)
{% endBgBox %}


This is the end of Module 9. Continue with [Module 10][ModDoc10].
