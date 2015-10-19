---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


In the previous modules, we have used the NeCTAR Dashboard to perform simple management tasks such as launching instances, creating volumes, accessing the object store, etc. 
In this module we are going to take a look at how you can do the same tasks with other *"clients"*. 

* OpenStack provides **command line clients** which allow you to manage your instances, volumes and object store and more via command line tools only. In this tutorial, we will discuss usage of command line clients to control your resources. 
* There are also **application programming interfaces (APIs)** available, mainly for Python, but also for other programming languages like e.g. C++ and Java. This is not part of this tutorial --- for a list of known software development kits see [OpenStack Python API Bindings][OpenStackPythonBindings] and [other OpenStack SDKs][OpenStackSDKs].

In a previous version of OpenStack, command line clients were split into several tools, called **nova, glance, cinder, swift, keystone** and more. Each of the tools was dedicated to certain tasks, e.g. *nova* for compute services, *swift* for accessing the object store, etc. Refer to the [official OpenStack clients website][OpenStackClients] for more details.
These tools have later been brought together to **one** command line tool called **openstack**, which brings command sets for Compute, Identity, Image, Object Store and Volume APIs together in a single command set with a uniform command structure.

The next sections are going to discuss installation and usage of the **_openstack_ command line client** with some working examples.

{% BgBox info %}
If you want to use the traditional OpenStack clients like *glance, cinder*, etc. you still can. The following instructions for installation and configuration also apply to the traditional clients. Only the name *openstack* in the package name *python-openstackclient* has to be replaced by the respective tool's name in the installation command. For example, if you want to install *glance*, replace *python-openstackclient* by *python-glanceclient*.
{% endBgBox %}

{% BgBox important %}
You may install the command line tools on **any computer** connected to the Internet --- this may be a Linux, Mac or Windows computer. Windows users must have access to the Windows command line (it may sometimes be blocked to users without administrator privileges). The following instructions are going to assume you are familiar with using the command line. 

Of course, you may also install the clients on your **Ubuntu instance** --- follow the instructions for a Linux system below and use the ssh terminal to your instance to type the commands.
{% endBgBox %}


### Step 1. Installation of clients

This section is going to cover installation of the OpenStack command line clients. Installation for all packages is the same, only the package name has to be replaced.
Please also refer to the [Official OpenStack documentation][OpenStackClientInstallation] for more information about installation of the OpenStack command line clients.

You will need to have Python installed to run the OpenStack command line clients. You may already have python installed. If you do,
check your version:

```python --version```

You will need to have **at least version 2.7**, however **python 3 is not supported** yet! 

If you don't have Python yet, the following instructions cover the installation as well. When using the Linux package managers, the right version will be installed automatically. On Mac/Windows, you have to manually install it.

* **Linux**: Installation of the OpenStack clients is simple via the built-in package manager: Ubuntu, RDO, openSUSE and SUSE Linux Enterprise have the client packages available through the package manager. For example, on Ubuntu, you may install the package with:   
 
    ```sudo apt-get install python-openstackclient```    

    This will install the *openstack* client with all the depending packages.
    {% BgBox info %} If you need a newer version of an OpenStack client than is available on the Linux package manager, you can use Python's package installer ***pip*** instead.  *pip* is a tool for easily installing and managing Python packages.     
    If you don't have *pip* yet, do so with your package manager (search for *python-pip*). For example on Ubuntu:    
    ```sudo apt-get install python-pip```    
    After installing *pip*, you can use *pip* to install the client package:    
    ```sudo pip install python-openstackclient```      
     To upgrade the client at a later point:    
     ```pip install --upgrade python-openstackclient```
    {% endBgBox %}

* **Mac OS X**:    
    1. Install Python's package manager ***pip*** (unless you already have it). *pip* is a tool for easily installing and managing Python packages. It is recommended over *easy_install*. Python 2.7.9 and later include *pip* by default, so you may have *pip* already. Either of the three options work to get *pip*:
        * If you have the homebrew package manager, *pip* installs together with the Python packages, and conveniently also installs the *setuptools* which you also need:    
        ```brew install python```    
        * If you don't have homebrew, the [official Python download](https://www.python.org/downloads/mac-osx/) of package 2.7.10 or later also installs *pip* (*Note*: Python 3 is *not* supported yet). 
        * *Alternative:* if you already have Python, but not *pip*, you may use the ***easy_install*** command to install *pip* --- however there may be problems with running the clients when using this method. To install *pip* with *easy_install*:    
        ```sudo easy_install pip```     
    2. Install *setuptools* if you don't already have it (*Note*: If you used *homebrew* to install python in the last step, you will already have *setuptools*). Follow instructions on the [setuptools Website][SetupToolsWebsite].
    3. Upgrade *setuptools*    
    ```sudo pip install --upgrade setuptools```    
    4. Install your client    
    ```sudo pip install python-openstackclient```      
     To upgrade the client at a later point:    
     ```pip install --upgrade python-openstackclient```

* **Windows**:
    1. Install Python 2.7 or later (*Note*: Python 3 is not supported yet!) if you don't have it yet. You can download it on the official [Python Website](https://www.python.org/downloads/windows/). You may keep the default options in the installation wizard --- the following instructions assume that you keep the default installation path *C:\Python27*. It is recommended that you install **Python 2.7.10 or later** which includes the *pip* tool which you will need. 
    2. Install *setuptools*: follow the documentation provided on the [setuptools website][SetupToolsWebsite] (the easiest is to download the [ez_setup.py](https://bootstrap.pypa.io/ez_setup.py) file and run it).
    3. Open a Windows Command line terminal (in the "Search" field, type *cmd* --- on older Windows, you may find the search field when clicking on *Start*). 
    4. Make sure you have included the package **pyOpenSSL (version 0.13 or higher)** in your installation:
        ```pip install pyOpenSSL```
    5. Ensure that the *C:\Python27\Scripts* directory is defined in the PATH environment variable. To do this for the currently open terminal run the following command:     
        ```set PATH=%PATH%;C:\Python27\Scripts```
        {% BgBox info %} To *permanently* change an environment variable: On various Windows versions, this can be done in the **Advanced System Settings** (usually you can find it in *Control Panel* > *System* or similar), where you should find a button **Environment Variables**. Scroll through the *System variables* and find *PATH* (it's not case senstitive, so it may be *Path*). Select it and click on *"Edit..."*. At the end of the long text in the *Variable value* field, add the text *";C:Python27\Scripts"* (without the quotation marks). Close all windows with [OK].
{% endBgBox %}
    6. If you have *not* installed Python 2.7.10 or later *including the pip tool*, you will need to install *pip* separately. You can test whether you have *pip* by typing    
    ```pip --version```    
     in your command line. If a version is printed, you have it. Otherwise, you may use the *easy_install* command from the *setuptools* package:    
        ```easy_install pip ```
    7. Install the client:  
    ```pip install python-openstackclient```       
     To upgrade the client at a later point:    
     ```pip install --upgrade python-openstackclient```


### Step 2. Get your OpenStack credentials 

Before you can use any of the clients, you will need to get your *OpenStack credentials*. In particular, you will need a script file called the *OpenStack RC file*. You will need to load the information from within this script before you can use the tools. While you are at it, you may also write down all your OpenStack login details.

You may already have done this in [Module 7][ModDoc7] when setting up access to your Object Store. In this case, make sure you have downloaded your *OpenStack RC file*, as you will need it now. You may then skip the following
step.

{% include getCredentials.markdown %}

#### Step 3: Upload your RC file to the instance

{% BgBox important %}
If you are configuring the client access on your ***local computer***, you can ***skip this step***. If you are using the ssh terminal to your instance instead, you need to do this step.
{% endBgBox %}

Before you continue, you need to copy the *OpenStack RC file* which you downloaded from the Dashboard to your instance. 

You may use any method to copy files to your instance, as discussed in [Module 7](/package07/sections/copyFiles.html), e.g. using the FTP client *FileZilla*. In the following instructions, we are going to apply the *command line* option to copy our OpenStack RC file across.

* On **Linux or Mac OS X**, you can use the *scp* command to do this:    
    
    ``` scp -i ~/.ssh/Nectar_Key <path-to-your-openrc-file> ubuntu@NNN.NNN.NNN.NNN:```
    
    replacing the N's with your IP address.
    This will have copied your openrc file in your ubuntu instance's *home* directory.

* On **Windows**, you may use the *PuTTY* command line tool *pscp*.  Please refer to instructions in [Module 7](/package07/sections/copyFiles.html) on how to install and use *pscp*. 
    {% BgBox info %} If you don't feel comfortable using the command line, you may use an FTP client like *FileZilla* to drag and drop your file into your *ubuntu* user's *home* directory (the *home* directory is the directory which opens up first when you connect with FileZilla). Instructions on how to use FileZilla are also included in [Module 7](/package07/sections/copyFiles.html). 
{% endBgBox %}
    
    Open the Windows Command prompt and type:

    ``` pscp.exe -i <path-to-ssh-key> <path-to-openrc-file> ubuntu@NNN.NNN.NNN.NNN:```

    replacing the N's with your IP address. Specify the path where you have saved your nectar ssh key in &lt;path-to-ssh-key&gt; and the path to your *OpenStack RC* file in &lt;path-to-openrc-file&gt;.     
    This will copy your *OpenStack RC* file to your ubuntu instance's *home* directory.



#### Step 4: Load your OpenStack credentials from the RC file

Before we can use the command line client, we need to load the OpenStack RC file which contains our authentication details.

* **Linux / Mac OS X:**
    Load your credentials:
  
    ```source <path-to-your-openrc-file>```

    using the above example for the RC files, this would be:    
    ```source ~/pt-12345-openrc.sh```

    You will be prompted for your OpenStack password.    
    {% BgBox info %} You can try to copy and paste your password into the command line prompt. If this does not work in your command line, you may edit the OpenStack RC file and assign the password directly by replacing *$OS_PASSWORD_INPUT* by your password, and removing the line above (the *read* command). Then, do the *source* command above again.    
    **Attention**: Be aware that if you do this, your OpenStack password will be openly stored in the OpenStack RC file which everyone who may gain access to your computer can read! You are creating a **potential security leak**, so do this only if you are absolutely sure your computer is well protected and nobody else can read the file from where it is stored. 
At the very least, it is recommended that you restrict access to this file to your user account only:    
```chmod 0600 <path-to-your-openrc-file>```
{% endBgBox %}




* **Windows**:    
    You will need the *Windows PowerShell* installed (available on Windows 7 and later, or on XP with Service Pack 3).


    The OpenStack RC file is a script written for Unix/Mac OSX systems, so it will need to be *modified* to work with the Windows PowerShell. 
    Open your OpenStack RC file in NotePad or WordPad (**not** Word!!) and change it so it looks like the snippet below (with your own values from your OpenStack RC file).     
    {% BgBox edit %}
$env:OS_AUTH_URL="https://keystone.rc.nectar.org.au:5000/v2.0/"
$env:OS_TENANT_ID="f12d34....c"
$env:OS_TENANT_NAME="&lt;your-tentant-name&gt;"
$env:OS_USERNAME="&lt;your-email&gt;"
$env:OS_PASSWORD="&lt;Your-OpenStack-Password&gt;";
$env:OS_REGION_NAME="&lt;Your-Preset-Region-Name&gt;"
{% endBgBox %}
    Make sure to save this as *a powershell* (*.ps1*) file in *plain text* (pre-select *.txt* if necessary and then change the suffix to *.ps1*). For simplicity, save the file as *openrc.ps1* in your user folder, which usually is *C:\Users\&lt;Your-User-Name&gt;*.    
    Then, open the **Windows Powershell** by typing into the Windows Command line:    
    ```powershell.exe```    
    And load your credentials:    
    ```C:\Users\<Your-User-Name>\openrc.ps1```    
    *Note:* Alternatively, you may use the Windows PowerShell Terminal directly. Search for "powershell" in the App Search. 
   {% BgBox important %} Make sure only you can read the *openrc.ps1* file, because the OpenStack password is readable on it.
Right-click on the file, select "Properties", go to the "Security" Tab, click "Edit..." and remove all names but your own user name.
{% endBgBox %}

{% comment %}
set OS_AUTH_URL=https://keystone.rc.nectar.org.au:5000/v2.0/
set OS_TENANT_ID=f12d3486498d4af5be4c2ca36369487c
set OS_TENANT_NAME="NeCTAR_Training"
set OS_USERNAME="jennifer@intersect.org.au"

@echo off
set "psCommand=powershell -Command "$pword = read-host 'Enter Password' -AsSecureString ; ^
    $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
        [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set OS_PASSWORD_INPUT=%%p

set OS_PASSWORD=%OS_PASSWORD_INPUT%

See also [this link](https://github.com/naturalis/openstack-docs/wiki/Howto:-Installing-and-configuring-the-OpenStack-commandline-tools-on-Windows)
     and [this one]( http://information-technology.web.cern.ch/book/cern-cloud-infrastructure-user-guide/advanced-topics/installing-tools-client-machines)
{% endcomment %}

 
 

You will have to load your credentials **every time** after you reboot your computer or open up a new terminal, otherwise you cannot use the clients. 
Use the same command as above to load them afresh.


#### Step 5: Use your OpenStack client

You are now ready to use your OpenStack client in the command line session in which you loaded your OpenStack RC file in the last step.

Keep this terminal open to follow the instructions in the next sections.

{% BgBox info %}
Whenever you start over (e.g. after you close the terminal), you only need to load (*"source"*) your OpenStack RC file in order to get ready to use the OpenStack client, as described in the last step:   
```source <path-to-your-openrc-file>```
{% endBgBox %}


You can display help for the *openstack* command with:

``` openstack help ```

And if you would like to see the more detailed help for a particular sub-tool, e.g. the *server* tool:

``` openstack help server ```

For supporting and further documentation throughout the next sections, please refer to the [official openstack client documentation][OpenStackClientDoc]. 



