You can download your **credentials** from the [Dashboard][Dashboard] 

1. Your **tenant ID** is the name of your project as reported in the left hand panel of the dashboard (e.g. *pt-12345*)

2. Your **username** is reported at the top of the dashboard on the right (e.g, logged in as: *user@uni.edu.au*)

3. Open the *Dashboard API* tab: get there via *Compute >  Access & Security >  API Access*.

4. Look up what is specified for the *'Identity'* Service in the *Dashboard API* tab. It will be a URL like    
    *https://**keystone.rc.nectar.org.au**:**5000**/v2.0/*     
    Take note of the text between *https://* and the colon (*keystone.rc.nectar.org.au* in the example). This will be the **Server**. Take note of the number (*5000* in the example). This will be the **Port**. You will need the **Keystone Server and Port** to authenticate your access. Also take note of the keystone version which you are using, in this case its **v2.0**.

4. Get your **credential file** (this is called the *OpenStack RC file* for OpenStack, and *EC2 file* for Amazon). You can download by clicking on the buttons on the top right on the same window: **Download OpenStack RC File**. Download it and save it somewhere on your computer where you can easily find it later.

5. You will also need your **OpenStack password**. This is **not** the same password that you use to log in to the Dashboard! If you have never used the OpenStack password before, you need to generate it first. You can do this in the **Settings** of the Dashboard: click next to your user name (your e-mail) on the top right and a drop down menu will open. Click on *Settings*. You need to reset your password by clicking **Reset Password** on the left panel of the settings. A long combination of numbers and letters will be displayed. This is your OpenStack password. Copy the text and save it somewhere safe.    
    {% BgBox info %} Your OpenStack password will be a long combination of numbers. At the time of writing, unfortunately this password cannot be changed yet, but this should be changed in a future update of OpenStack on NeCTAR.    
    {% endBgBox %}


