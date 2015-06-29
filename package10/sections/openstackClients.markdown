---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}




In the previous modules, we have used the NeCTAR Dashboard to perform simple management tasks such as launching instances, creating volumes, accessing the object store, etc. 
In this module we are going to take a look at how you can do the same tasks with other *"clients"*. For example, there are some command line "clients" --- so you can manage your instances, volumes and object store via command line tools only. For the *swift* object store also offers application programming interfaces (API).

The following *clients* are available:

| Service | Client package     | Purpose |
| :------- | :------------------ | :---------------------------------------------- | ------- |
| nova	  | python-novaclient  | Nova is the primary OpenStack cloud management API |
| glance  | python-glanceclient| Glance is the OpenStack Image management API. |
| cinder | python-cinderclient | Cinder provides services and libraries for access to Block Storage. |
| keystone | python-keystoneclient | Keystone is the OpenStack Authentication API. |
| swift	  | python-swiftclient  | Swift is the ObjectStack Object Store API. |
| ------- | ------------------ | ---------------------------------------------- | ------- |



Official source repository URLS are composed of the github URL [https://github.com/openstack/](https://github.com/openstack/) followed by the client package name listed above. For example, the repository for *nova* is [https://github.com/openstack/python-novaclient](https://github.com/openstack/python-novaclient).

### Step 1. Installation of clients

This section is going to cover installation of the clients listed above. All clients are command line tools. Installation for all packages is the same, only the package name has to be replaced.

Installation is simple. On our ubuntu instance, you may install the packages with the package manager.

```sudo apt-get install <package-name>```

For example, if you wanted to install *swift*, use the client package name *python-swiftclient*:

```sudo apt-get install python-swiftclient```

This will install swift with all the depending packages.

{% BgBox info %}
If you need a newer version of an OpenStack client than is available on the package manager *apt-get*, you can use Python's package installer *pip*.

If you don't have installed *pip* yet, do so:    
```sudo apt-get install python-pip```

Then, install the client package with the command:    
```sudo pip install <package-name>```    
For example, if you wanted to install *glance*, type:    
```sudo pip install python-glanceclient```    
{% endBgBox %}

There are **good news for Linux and Mac OSX users**: You may even install the command line tools on your local computer and manage your instance and volumes from your local command line!    

On **Linux** systems, use the same steps described above.    
When installing a client, you will be prompted for the password of your local Linux user account (this will *not* be the OpenStack password!).

On **Mac OSX**, you need to do a bit more:

1. Install python's *pip* (unless you already have it) using the *homebrew* package manager:    
    ```brew install python```    
    {% BgBox info %}  *Alternative:* If you don't have *homebrew*, you may use the *easy_install* command, however there may be problems with running the clients with this. You may try anyway, and if it does not work, then uninstall pip again (*sudo pip uninstall <client-package-name>*) and get homebrew instead.    
    ```sudo easy_install pip```    
    {% endBgBox %}

2. Upgrade setuptools    
    ```sudo pip install --upgrade setuptools```    
    
3. Install your client    
    ```sudo pip install <package-name>```    
    For example, if you wanted to install *swift*:    
    ```sudo pip install python-swiftclient```    
    You will be prompted for the password of your Mac's user account (this is *not* the OpenStack password!).

### Step 2. Get your OpenStack credentials 

Before you can use any of the clients, you will need to get your *OpenStack credentials*. In particular, you will need a script filed called the *OpenStack RC file*. You will need to load the information from within this script before you can use the tools. While you are at it, you may also write down all your OpenStack login details.

You may already have done this in [Module 7][ModDoc7] when setting up access to your Object Store. In this case, make sure you have downloaded your *OpenStack RC file*, as you will need it now. You may then skip this step.

{% include getCredentials.markdown %}

#### Step 3: Upload your RC file to the instance

{% BgBox important %}
If you are configuring the client access on your **_local_ Linux or Mac OSX** computer, you can skip this step. If you are using the ssh terminal to your instance instead, you need to follow the instructions below.
{% endBgBox %}

Before you continue, you need to copy the *OpenStack RC file* which you downloaded from the Dashboard to your instance. 

You may use method to copy files on your instance, as discussed in [Module 7](/package07/sections/copyFiles.html), e.g. using the FTP client *FileZilla*. In the following instructions, we are going to apply the *command line* option to copy our OpenStack RC file accross.

On **Linux or Mac OSX**, you can use the *scp* command to do this:

``` scp -i ~/.ssh/Nectar_Key <path-to-your-openrc-file> ubuntu@NNN.NNN.NNN.NNN:```

replacing the N's with your IP address.
This will have copied your openrc file in your ubuntu instances *home* directory.

On **Windows**, you may use the *PuTTY* command line tool *pscp*.  Please refer to instructions in [Module 7](/package07/sections/copyFiles.html) on how to install and use *pscp*. 

{% BgBox info %}
If you don't feel comfortable using the command line, you may use an FTP client like *FileZilla* to drag and drop your file into your *ubuntu* users *home* directory (the *home* directory is the directory which opens up first when you connect with FileZilla). Instructions on how to use FileZilla are also included in [Module 7](/package07/sections/copyFiles.html). 
{% endBgBox %}

Open the Windows Command prompt and type:

``` pscp.exe -i <path-to-ssh-key> <path-to-openrc-file> ubuntu@NNN.NNN.NNN.NNN:```

replacing the N's with your IP address. Specify path where you have saved to your nectar ssh key in &lt;path-to-ssh-key&gt; and the path to your *OpenStack RC* file in &lt;path-to-openrc-file&gt;.

This will have copied your *OpenStack RC* file in your ubuntu instances *home* directory.


#### Step 4: Load your OpenStack credentials from the RC file

You now have to **make your *OpenStack RC file* executable** so that we can use it to load the credentials. 

Go to your ssh terminal and type:

```chmod u+x <path-to-your-openrc-file>```

For example, if your RC file is called *pt-12345-openrc.sh* and is located in your *ubuntu* users *home* directory, type:    
```chmod u+x ~/pt-12345-openrc.sh```

Then, **load your credentials** by typing:

```source <path-to-your-openrc-file>```

Using the above example for your RC files location:    
```source ~/pt-12345-openrc.sh```

You will be prompted for your OpenStack password.

{% BgBox info %}
You can try to copy and paste your passowrd into the command line prompt. If this does not work in your command line, you may edit the OpenStack RC file and assign the password directly by replacing *$OS_PASSWORD_INPUT* by your password, and removing the line above (the *read* command). Then, do the *source* command above again.

**Attention**: Be aware that if you do this, your OpenStack password will be openly stored in the OpenStack RC file which everyone who may gain access to your computer can read! You are creating a **potential security leak**, so do this only if you are absolutely sure your computer is well protected and nobody else can read the file from where it is stored. 
{% endBgBox %}


You will have to load your credentials **every time** after you reboot your computer or open up a new terminal, otherwise you cannot use the clients.     
Use the same *source* command as above to load them afresh:    
```source <path-to-your-openrc-file>```


#### Step 5: use your OpenStack client

You are now ready to use your OpenStack client *on the command line which you have used to load your OpenStack RC file* in the last step.

Keep this terminal open to follow the instructions for the individual clients in the next sections.

{% BgBox info %}
Whenever you start over (e.g. after you close the terminal), you only need to load your OpenStack RC file as described in the last step in order to get ready to use the OpenStack client.
{% endBgBox %}
