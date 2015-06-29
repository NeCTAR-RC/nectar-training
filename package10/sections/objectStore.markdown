---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


Access with SWIFT, Boto, Java clients. See http://support.rc.nectar.org.au/docs/object-storage


automate backups. The scripts here do backup on object store. [http://support.rc.nectar.org.au/forum/viewtopic.php?f=3&t=854](http://support.rc.nectar.org.au/forum/viewtopic.php?f=3&t=854)

 
### Access with the *swift* command

You may also use the *swift* command to list the files in our object storage that we just created.

You can do the following steps either 

1. If you are using **Linux** or **Mac OS X**: run *swift* on your local computer via the command line

2. Connect via ssh to your instance and follow the steps below using your *ssh terminal*.     
    In this case, you will first have to copy the OpenRC file (which you downloaded from the Dashboard in an earlier step) to your instance as well. You can do this with    
    ```scp <path-to-your-openrc-file> ubuntu@*NNN.NNN.NNN.NNN*:```    
    (replacing N’s with your instance’s IP address.)

Both options work with the following commands in the terminal. Only the terminal to  use varies for the two options: 

1. Use your local terminal

2. Use the ssh terminal

#### Step 1: Install swift

* **Linux**    
    In your terminal, type    
    ```sudo apt-get install python-swiftclient```

* **Mac**    
    1. Install python's *pip* (unless you already have it) using the *homebrew* package manager:    
        ```brew install python```    
        {% BgBox info %}  *Alternative:* If you don't have homebrew, you may use the *easy_install* command, however there may be problems with running the *swift* command with this. You may try anyway, and if it does not work, then uninstall pip again (*sudo pip uninstall python-swiftclient*) and get homebrew instead.    
        ```sudo easy_install pip```    
        {% endBgBox %}
    2. Upgrade setuptools    
    ```sudo pip install --upgrade setuptools```    
    3. Install python-swiftclient    
    ```sudo pip install python-swiftclient```    
    ```sudo pip install python-keystoneclient```

#### Step 2: List your files

Make sure you have loaded your credentials by "sourcing" your *OpenRC* file as described [earlier](openstackClients.html).

Type

```swift list```

and you should see the container for your object files which you uploaded to the container.

```swift list <your-container-name>```

will list the file(s) you have just uploaded to this container.




