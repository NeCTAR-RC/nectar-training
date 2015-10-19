---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


It is possible to have several desktop environments installed and use them interchangeably. You will have to install each desktop environment you want to use on your instance (as we have done in [this section](installDesktopEnvironment.html) earlier. 

Note that with **VNC**, you have to change your desktop environment on the server side (on your instance), and everyone who connects to the instance will automatically use the desktop which has been configured for this instance. To change the desktop environment, you have to edit the *xstartup* file and restart the vnc server, as described in the last section.

With **X2Go**, you can decide on the X2Go client which desktop to use --- in your *x2goclient* application, you can choose from the drop-down box which desktop environment you want to run.


