---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}



# Appendix: Create a new security group

TODO: Screenshots

On the dashboard.:

    1. Go to "Access and Security"

    2. "Create Security Group"

    3. Name it  something meaningful, and add any description

    4. Click "Create Security Group". You will see the new group in the list now.

    5. Click "Manage rules" at the right of your group.

    6. At the top right of the page, click "Add rule"

    7. You probably want an "Incoming TCP" rule.

    8. If you want to allow access from any computer, type 0.0.0.0/0 in the CIDR (the part before the ‘/’ is the address for localhost and the part after the ‘/’ specifies the subnet mask -- you don’t need to worry about the meaning in this tutorial, but look it up online, e.g. google, if you want to restrict access to computers from only a certain range of IP addresses, e.g. only computers from within a university).

# Appendix: Troubleshooting

## Cannot connect to ssh

Check which ports are open on your system:

* Using nmap

    * > sudo apt-get install nmap

    * > sudo nmap -sT -O localhost

    * If you are trying to get VNC going, you should see something like:5900/tcp open vncin the output.

* Using netstat

    * sudo netstat -tulpn

* using nc (netcat) to check whether there is something listening on the other side (-v verbose, -w timeout, -z just scan for daemons)

    * nc -v -w 5 NNN.NNN.NNN.NNN -z <port>

If you get the error:

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@     	WARNING: UNPROTECTED PRIVATE KEY FILE!      	@

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

Permissions 0664 for '<yourkey>' are too open.

It is required that your private key files are NOT accessible by others.

This private key will be ignored.

bad permissions: ignore key: <yourkey>

Permission denied (publickey).

Then you have changed the access rights to the key while copying it around.

Fix this with:

  *chmod go-rw <yourkey>*

## "Cannot resolve host" messages

You may get warnings in the form of "Cannot resolve host" when you log in via ssh and type in commands. You can get rid of those messages by making sure your machine name appears in the following files:

*/etc/hostname *must contain:

<my-instance-name>

*/etc/hosts* must contain:

127.0.1.1 <my-instance-name>

The machine name is the instance name which you selected when creating the instance, and is also displayed after the @ in the command prompt. You should see something like this in your terminal:

ubuntu@**nectarinstance**:~$ _

the underscore is where you type your commands. In this case, *nectarinstance *is our machine name.

To add the lines to the two files, open them using an editor like nano or vim:

1. Type *sudo nano /etc/hostname *and add your instance name to the file.

2. Type *sudo nano /etc/hosts* |and add  the line 127.0.1.1 <my-instance-name>* *at the bottom of the file.

# Appendix: SSH Tunnelling on Unix (comprehensive version)

SSH Tunnelling is best explained with an example. Imagine you’re on a private network with very conservative firewall rules which don’t allow connections to a specific server. For example, *blockedsite.com* is not accessible from your network. You can of course ask your system administrator to free up this site for you, but you may have to wait for the approval. To get around this firewall rule we can redirect our connection via a port that does not block this website: We can create a *tunnel* through a server which is not on our network and which can access* blockedsite.com*. We call this server the *gateway*. 

![image alt text](image_46.png)

TODO: Redo this graphic which was taken from google image search. Label the "gateway" as well.

Let’s say *blockedsite.com* uses the *http* protocol (as most websites do) through Port 80. Instead of connecting our port 80 to the *blocksite.com*’s port 80 (which would not work), we will redirect all traffic from our port 80 through the secure ssh port 22. This one will not be blocked by the firewall, and nobody will be able to decypher the traffic going through it (unless they get access to your private key and passphrase of course). On the gateway, our connection will come in at Port 22, and the ssh server will then redirect the traffic to port 80 on *blockedsite.com*. We call this technique *local port forwarding*. Of course, the connection between the gateway and the server of *blockedsite.com* is not encyrypted; only the tunnel between our computer and the gateway is.

The technique of local port forwarding through an ssh tunnel can also be used to create a secure connection all the way to the destination server, so that there is no point at which the connection is not encrypted. In this case, the gateway is also the destination server itself.

As an example, we are going to discuss the setup for ssh tunnelling on port **5900** on our remote machine (the default VNC port), using the gateway *localhost*. Observe that the gateway is *localhost*, because when we specify the destination server, it is also the gateway in this case (this can be a bit confusing, because you would guess we specify the gateway first… but actually we first specify the destination server, and then the gateway through which we want to create the tunnel). The tunnelled service will be available on *our* localhost, port **6000** (we use different numbers so you can distinguish it in the text below). We could do this for any other port numbers.

1. On your machine, create a tunnel from your machine (port 5900) to the other machine (port 5900)  *ssh -i <your-key-name> -L 6000:localhost:5900 -N -f -l ubuntu 144.6.227.50*

2. On the instance: Install and start any service that will listen on port 5900 (e.g. the VNC Server).

3. A quick test should show you that you cannot actually directly connect to port 5900 on the instance:   *telnet 144.6.227.50 5900*This will try connect you to the remote port (without any useful application, but it’s a good way to test whether the port is open). The shell should just say "trying to connect…" but nothing happens: Because we have not allowed access to port 5900 from outside… only via the SSH tunnel! And the ssh tunnel is accessible via *our* localhost. End the connect trying with Ctrl+C. Instead, try:> telnet localhost 6000or> nc -v -w 5 localhost -z 6000And you should see a command prompt (no error). So now you are talking to the port and can specify commands specific to the server, but we don’t really want to do this now.To quit the telnet command prompt:Hit ctrl+] (control and the right-bracket). That will return you to a telnet command prompt. From there you can enter the quit command (typing “q” is sufficient) and you will be returned to your usual Windows command prompt. 		If this still does not work, make sure there is a server listening on port 5900. Check this with:  *sudo netstat -tulpn*There should be your service listed as “Listening” on the port you have meant it to provide its service. If your service is not listening on that port, it won’t be possible to connect to it either.

ssh -L options:

Syntax:

-L <local-port-to-listen>:<remote-host>:<remote-port>  <gateway>

* **-N** : Do not execute a remote command i.e. just forward ports.

* **-f **: Requests ssh to go to background just before command execution. Once password supplied it will go to background and you can use prompt for type commands on local system.

* **-l ubuntu **: ubuntu is the user to log in as on the remote machine (sshserver.mydomain.com).

*Note:  *The **-f -N** options in the above command cause the tunnel to run in the background: once you have typed in the password, the command line prompt returns to your local shell. In this case, if you ever want to close your ssh connection, you have to kill the connection:

  *ps aux | grep ssh*  (then, find your ssh tunnelling command and note the number on the left, after your user name)

  *kill <the-ssh-tunnel-process-number>*

If you *don’t *use the **-N -f** options, you will be logged into an ssh shell to your instance, and can use it as usual to type commands on your instance. If you type *logout* or close the terminal, the ssh tunnel will close as well.

# Appendix: Converting ssh keys from Linux for PuTTY

*NOTE*: If you have generated your ssh key on a Linux system and now want to use it in Putty, you have to convert the keys first. If you have generated your key file with putty, you *don’t need to do this*. To convert the key, follow these steps:

1. Start PuTTYGen.

2. Click on the menu "Conversions" and select "Import key".

3. Select your private key and enter the passphrase.

4. Click on the button "Save private key" and save your key file.

You may also want to simply create a separate set of keys for PuTTY (see[7.1.1. Create an ssh key](#heading=h.30hf4r5eurmi)). In this case, you have to add the new key as an authorized key on the instance. See [Appendix: Adding a new ssh key](#heading=h.r35lx44djujf) for how to do this.

# Appendix: Creating a new user account

If you want to create a new user account on your VM, type in the following command in your ssh shell:

  *sudo adduser <username>*

replacing <username> with the username you would like to create. It will prompt you to create a password for this user, and type in their name and contact details (Note: If you would like to just create the user without specifying password and details, use *sudo useradd <username>* instead). This will create a user with minimal privileges. For example, the user cannot perform administration tasks which require the *sudo* command prefix. If you would like to add privileges for this user, you can add it to certain *privileges groups*, e.g. the sudo group:

  *sudo adduser <username> sudo*

To check the right groups the user is assigned to, type

  *id <username>*

**Important: **Each user should have their own ssh keys. Ask them to create it, using their passphrase of choice, and then send you their public key. Add their public key to your VM by following instructions in [Appendix: Adding a new ssh key](#heading=h.r35lx44djujf).

# Appendix: Adding a new ssh key

If you want to use a new key to connect to the instance, you have to add it to the file *authorized_keys *on your instance:

  *nano ~/.ssh/authorized_keys*

Paste the contents of your public key as one line into this file.

(Tipp: Copy the content of the public key by opening it with a text editor, marking all text and copying with CTRL+C. Then, go to your PuTTY Window which has the editor open for authorized_keys. Pasting the content will not work with CTRL+V on PuTTY, but instead, clicking the right or middle mouse button should paste the content.)

Similarly, if you want to remove a key, you have to delete the line for that key from the *authorized_key* file on your instance.

