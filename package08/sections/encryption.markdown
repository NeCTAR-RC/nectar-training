---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


For several reasons discussed earlier, you may want to encrypt your file. We can broadly distinguish two types of file encryption: 1) encrypting an entire volume and 2) encrypting individual files. 

Object storage (discussed in [Module 6][ModDoc6]) is very useful for ease of access and data integrity.  Because several copies of your data is kept, availability is very good: The NeCTAR Object Store is geo-distributed across Nodes of the Research Cloud so that availability is not reliant on any one datacentre or network infrastructure. *Only you* have access to your object store using your OpenStack credentials, so only you can select files to download, or upload files to a container. 

While *access* to your Object Store is secured with your credentials, the *transfer* of your files via the network is not necessarily secure: When you upload and download files, it happens via an unencrypted connection (unless you explicitly use a secure client, e.g. an *SFTP* client). At the time when you download or upload your files, somebody could catch the data you are transferring via the Internet. Also, when your files are replicated across NeCTAR nodes, this happens without encryption.

The critical point is the moment of *data transfer*. 
{% BgBox info %}
Extensions to *OpenStack* (the cloud software that NeCTAR is using) for object storage data encryption have been proposed and will probably be available at some point.
{% endBgBox %}

For this reason, you may want to encrypt sensitive data before you upload it to the object storage. With the Object Storage, you upload individual files, so you should do a **per-file encryption**. 

If you want to protect your data on a Volume against *breaches* (someone gaining access to your volume), you may want to do an entire **volume encryption** on the volume which you have attached to your VM. 

There are many tools for data encryption available. Not all of them support both per-file *and* whole volume encryption. When choosing a tool for encryption, it is also important that the encryption algorithm used by the tool is secure and cannot be hacked easily. 

In this section, we will go through a few example tools for file and volume encryption.

