---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


## 7.2.5. Running several desktop environments

[I](http://askubuntu.com/questions/304017/how-to-set-up-remote-desktop-sharing-through-ssh)t is possible to have several desktop environments installed and use them interchangeably. See instructions on how to install them in section [7.2.2. Choose and install your desktop environment](#heading=h.zcimonqmizy).

Note that with VNC, you have to change your desktop environment on the server side (on your instance), and everyone who connects to the instance will automatically use the desktop which has been configured for this instance. To change the desktop environment, you have to edit the *xstartup* file and restart the vnc server, as described in [Step 2. Configure server](#heading=h.a6035zbuxu22) and [Step 3. Start the server](#heading=h.wsw4ulptzgoy).

With X2Go, you can decide on the X2Go client which desktop to use -- in your x2goclient application, you can choose from the drop-down box which desktop environment you want to run.


