---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


The widely spread perception is that cloud computing poses a whole lot of new risks. What is often overlooked however, is that security can improve with cloud computing: Security is often as good as or better than in traditional systems, because the provider’s data center is maintained by a team of experts which are looking after the data center security around the clock. Cloud providers are able to devote their resources to solving security issues that many of their customers could not afford --- and evidently it is the provider’s top priority to keep their data center safe, or they would lose their reputation and their customers. More trust is needed in the competence of the administrators of cloud computing data centers in ensuring security with as much competence as any good IT department could do. Unfortunately, 100% security does not exist in IT --- a security breach can happen in any organisation, whether it is a cloud provider, a research organization or a business. It is a matter of trust in which IT department can ensure maximum security best.

Perhaps the biggest security concern among cloud computing customers is *data loss*. Here are some figures from the 2014 Data Health report ([www.databarracks.com](http://www.databarracks.com)), in which a number of small and large organisations report the causes of data loss:

 

21% Hardware failure

19% Software failure

18% Human error / accident

15% Corruption

7%  Theft

7%  Internal security breach

6%  External security breach

5%  Natural disaster

TODO: Create infographic from this? Perhaps bar chart?

As the numbers show, human error is still a leading case of data loss! Internal and external security breaches are not far removed from the figures for natural disasters. Let’s say you can trust your cloud provider in ensuring the best protection against software and hardware failures. This still leaves one very important factor in keeping your virtual machine and data safe: yourself! There are some parts which you are responsible for when ensuring the security of your virtual machine and data. This holds in particular for *IaaS* services (in *SaaS* services, the cloud provider is responsible for security control, *PaaS* services have shared responsibility between provider and customer). Your virtual machine is an *IaaS* Service, so there will be things you need to observe to make your services secure.

There are a few security issues which are particular to cloud computing, but they are usually not a major security concern, if actions are taken by the cloud provider and yourself to protect against these threats.

It is not difficult to ensure the best possible security for your virtual machine and data, but you have to be aware of which the steps involved are. We will talk through this in this Module.

## Main threats

Main threats to cloud computing are posed by:

   --- conforming with the Cloud Security Alliance

* **Cyber attack**: Risks include 

    * a) *nefarious* use of cloud computing: hackers can upload malware to a public cloud and use the power of the cloud to attack other computers. For example, they may use hundreds of cloud computers to hack passwords.

    * b) Distributed Denial of Service (*DDoS*) attacks. Denial-of-service attacks are attacks meant to prevent users of a cloud service from being able to access their data or their applications. Clouds are of particular interest to hackers because bringing down the services affects a wide group of people. Therefore, cloud providers must invest in robust measures to protect against such attacks.

    * c) Phishing, fraud and exploitation of software vulnerabilities to get access to your data.

Although most cloud providers have stringent security measures, as technology becomes more sophisticated, so do cyberattacks. Clouds also have additional vulnerabilities: Virtual switches and the hypervisor are two examples of points of attack that are not present in the traditional data center. Protection from the provider: The team of experts at the cloud’s data center have to take measures to protect against this extra risk. Traditional physical technical controls such as firewalls, Intrusion Detection Systems (IDS), Intrusion Prevention Systems (IPS) or Network Access Control (NAC) products that ensure access control continue to be critical components of the security architecture.Protection from your side: You should not install potentially harmful software on your virtual machine. Be sure you can trust the software vendor.

* **Insecure Interfaces **and API's: 3rd parties can create an insecure application to interact with the cloud services, e.g. to provision, manage, orchestrate and monitor the VMs through such interfaces. Protection from the provider: Set up the cloud platform such that external software does not have privileges to provision, manage and orchestrate VMs (or only allow this for trusted software).

* **Access to your Data**The cloud provider can potentially access the data that is on the cloud at any time. They can even be obliged to share information with third parties if necessary for purposes of law and order, even without a warrant. Protection from you: You can encrypt data that is processed or stored within the cloud to prevent unauthorized access.

* **Data Loss & Leakage** **/ Risks of shared access (Multi-tenancy)**: In a cloud provider platform being shared by different users (a "*multi-tenant*" platform) it is possible that data belonging to different customers resides on same data server. A few issues arise from the fact that resources (CPU, memory, etc) are shared. (a) resources can be fully taken up by one virtual machine (also called a “**noisy neighbour**”), effectively creating a denial-of-service-attack to others sharing the same resources. (b) data can leak from one customer to another:  Researchers have been able to recover other tenants' data from what was supposed to be new storage space. (c) If a multi-tenant cloud is not properly set up, a flaw in one client’s application could allow an attacker access not only to that client’s data, but every other client’s data as well. Protection from the provider: Protecting the cloud platform with good software is a high priority.

    * Transparent Cloud Protection System (TCPS) is a protection system which is effective in detecting most kind of attacks by monitoring the VMs. 

    * The hypervisor can be configured so that when it detects extreme resource consumption from one VM (the "noisy neighbour"), it can evaluate whether an attack is being made and automatically restart the problematic VM. Another way to protect against noisy neighbours is to set a resource limit (machines can only use so much) or a resource reservation (other machines cannot use resources that are reserved for another).

    * A secure infrastructure is required that ensures customer’s virtual machines are isolated in a multi-tenant environment. Isolation can be achieved by using virtual switches and/or VLANs for the networks.

Protection from you:

    * You can encrypt your data to reduce the impact of a data breach. However be careful, because if you lose your encryption key, you’ll lose your data as well.

    * You can keep offline backups of your data to reduce the impact of a catastrophic data loss, however be aware that this increases your exposure to data breaches (because there is a security risk at *two* data centers). Nevertheless, keeping physically separate backups of important data is generally recommended, as you can not protect your data on the cloud against physical disasters as fires or earthquakes leading to the data centres being destroyed.

    * When you release storage space because you don’t need it any more, make sure you securely erase all data (see also Module 9 for how to do this), so it does not leak to other tenants.

* **Hardware Failure and Data loss**: When the hardware fails, all data may be lost, if it has not been backed up. The state of the virtual machine may also be lost. Data loss by physical damage to the data storage is a risk which exists in any data centre.Protection from the provider: Create separate backups of all hard-drives.Protection from you: Backup your data at regular intervals and save it at a different physical location (e.g. your organisation’s data center). Similarly, take Snapshots of your virtual machine and save them as an image on a separate hard-drive, so you can easily re-launch it. Module 9 will discuss how you can do this.

* **Data ownership**: Legal ownership of the data is a risk as well. Many Terms of Service agreements do not mention ownership! There is a high risk that end users don't know this, don't read the many pages of the terms of service agreement, and just click "Accept". Often, the data owner is actually the provider! There can also be a case that the data is owned by the provider only if it was created on the cloud (e.g. by a cloud application), but is owned by you if you have *uploaded* it. Make sure you know how your provider handles this.Question: How does NeCTAR handle this?

* **Access security**: This affects authentication, access control and data encryption. It is important that access is only possible via secure connections. Nobody else except you should be able to see or access your data. What happens when the data is deleted or not needed any more, are copies still kept? Many providers are not clear on that point. Is data encrypted? If so, are the private keys shared among tenants? Be aware also that governments may have the right to access your data even if they get a warrant.Protection by the provider: Encrypt the data and ensure complete deletion of data without keeping any copies. Protection by you: Never share your private key with anyone, and make sure you only use ssh keys which you have created yourself (see Module 7). Be aware of whether several copies of your data are kept, and if so, request a complete deletion from the provider where necessary. Always choose secure passwords (see Module 5 "Mitigating risks")!

* **Malicious insiders**: CERT defines a malicious insider as follows ([http://www.cert.org/insider_threat](http://www.cert.org/insider_threat)): "A malicious insider threat to an organization is a current or former employee, contractor, or other business partner who has or had authorized access to an organization's network, system, or data and intentionally exceeded or misused that access in a manner that negatively affected the confidentiality, integrity, or availability of the organization's information or information systems."

* **Availability / Lack of Internet**: Service interruptions can happen and they can go for hours or in the worst case even days. Another factor for loss of availability can be lack of Internet.Protection from the provider: Ensure service availability best as possible.Protection from you: Choose a reliable Internet Provider.

* **Lack of full control**: Especially in ready-to-use *SaaS* services, customers often have no control over updates or upgrades. They can find a new version of the service was provided overnight, removing a feature they needed, or adding one that raises new security issues.

* **Insufficient knowledge**: Many organisations rush into the cloud without knowing about the potential issues and risks and how to mitigate them.Protection by you: Pay attention in this Module and you will have the required knowledge.

VM-specific vulnerabilities:

Virtual machines have a number of their own vulnerabilities. A malicious virtual machine can potentially access other instances through shared memory, network connections, and other shared resources. Fortunately, these security concerns are being addressed. Most intrusions can be prevented by the users applying traditional security measures, as we have discussed in Module 5 ("Mitigating Risks").

Most VM specific vulnerabilities stem from the *hypervisor*. There are a number of different types of security breaches on the hypervisor level:

* **Hyperjacking**: This involves modifying the hypervisor to be malicious, or inserting a malicious hypervisor (a "rogue" hypervisor). In theory, a hacker with control of the hypervisor could control any virtual machine running on the physical server.

* **VM Escape**: A malicious program manages to "escape" out of a virtual machine and compromising the hypervisor. Then the program can assume control over all other VMs running on the physical computer.

* **VM Theft:** This is the ability to steal a virtual machine file electronically, which can then be run elsewhere. It is an attack that is the equivalent of stealing a complete physical server without having to enter a secure data center and remove a piece of computing equipment.

Luckily, hypervisors are generally more secure than regular operating systems; The Hypervisor is a fairly simple program, which helps to limit such vulnerabilities.

The NeCTAR cloud uses the KVM Hypervisor with OpenStack. KVM is a good choice in terms of security. The virtual machines managed by KVM run as unprivileged processes, which makes it safe. Techniques for Hypervisor protection include* sVirt, Intel TXT, and AppArmor, cgroups*, and *MAC Policy*. KVM has all these techniques in-built. 

See also: [http://docs.openstack.org/security-guide/content/hypervisor-selection.html](http://docs.openstack.org/security-guide/content/hypervisor-selection.html)

Regular patching of the Hypervisor is important to refresh security. Also, appropriate security policies have to be applied. The NeCTAR cloud administration team (TODO: Ask how to call the team if IT experts managing the cloud) is aware of the high security demands of Australia’s researchers and regularly updates the systems and applies a strict security policy to ensure maximum safety.

However part of the security is also your responsibility, as not only the Hypervisor, but also your VM has to be secure (for example, to help prevent a *VM Escape* attack). 

Since it is easy to restore an infected VM,  many users do not go through the effort to secure them with an anti virus protection. Linux, Unix and other Unix-like computer operating systems are generally regarded as very well-protected against computer viruses, but they are not immune. So better safe than sorry: Install an anti virus protection.

TODO: Recommend Anti-Virus for Linux! Maybe show the apt-get command to install it.

It is also very important that you regularly update your VM’s operating system to ensure it has the newest security patches, eg. on Ubuntu this can be done with the command:

   *sudo apt-get dist-upgrade*

TODO Put in an "important" box

Keep in mind:

Most cloud vendors do a better job securing data than their customers do. But a lot of security issues are also up to you -- e.g. use a firewall and apply strict rules to it;  install an anti-virus protection on your VM; use secure passwords; don’t share your private key, etc. All factors you need to observe to ensure security have also been discussed on a more abstract level in Module 5 ("Mitigating Risks").

End "Important" box

## Security *b**enefits* of the cloud and virtual machines

The nice part is that using a the cloud and a virtual machine does also comes with some security *benefits*.

* **Abstraction**: The hardware abstraction and isolation of the virtual machine makes it much more difficult for the attacker to gain unauthorized access on the physical machine. The OS and software running on the virtual machine are not even aware it is virtual, and does not know the cloud platform’s OS or hardware configuration. An attacker of the virtual machine does therefor also not know details of the cloud platform environment, therefore manipulating and compromising the machine is much more difficult.

* **State restore**: It is easy to restore the state of a virtual machine: A Snapshot can be created and the virtual machine can be re-launched from this Snapshot, thereby returning to a state prior to attack or data loss. This is an easy method to remove malware and restore data. 

* **External monitoring**: The hypervisors runs outside the virtual machine and may also monitor for malware, in addition to the protection which is running inside the VM, e.g. the installed anti-virus protection. If the virtual machine is being monitored, and an attack is detected, then the instance can be shut down or disabled. The paradox of physical machines is that if they have a virus, they cannot reliably detect whether they have a virus. VMs do not have this problem.

* **Transience**: An advantage of a VM is that it may be started remotely only when they are needed. Physical servers on the other hand often run permanently, even if they are not in use. This increases their likelihood for a malicious attack. 

* **Simplicity of Hypervisors:** Hypervisors are much simpler than traditional operating systems, and are therefore much easier to secure. This makes it easier for software developers to minimize bugs and vulnerabilities.

* **Off-premise data storage:** Storing your data off-premise has it’s benefits too. If someone wanted to steal your data from the data center, they would have to break in there, which is a difficult task for itself, since data centers are well guarded. Also, they would be faced with banks of thousands of storage systems with meaningless lables on it, e.g. 1DC45-R7. They would not know where your data is stored, and which machine to steal.

* **Data availability: **Object Storage (described in Module 6) has a great data integrity. Because copies of your files are spread over several physical locations, you will have access to it even if one data center has an outage.


