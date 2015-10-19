---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


In this section we are going to enable a web server and create our first simple web site.

To install the web server, go to the *ssh terminal* and type:

```sudo apt-get install apache2```

Confirm installation of the package with **'Y'**.

Now, open the web browser on your local computer, and type your instance's IP address in the URL field.
We will see the default apache website of the browser.

Let's now start our own simple website. In your *ssh terminal*, type:

```nano /var/www/html/index.html```

the directory */var/www/html* is where your website lives by default, and the file *index.html* is the start page which we want to edit. In the editor that comes up, remove all the text inside and replace it with the text below. 

*Tip*: Copy and paste will not work with many terminals. If the traditional copy & paste does not work, you can instead try the following: copy the text as usual; then click with your mouse on the place you want to insert the text in your ssh terminal editor; Then, click the *right or middle* mouse button --- this will work on many systems to "paste" the contents of your clipboard.

{% BgBox edit %}
&lt;!DOCTYPE html PUBLIC "-//IETF//DTD HTML 2.0//EN"&gt;    
&lt;HTML&gt;    
  &lt;HEAD&gt;    
    &lt;TITLE&gt;    
      A Small Hello    
    &lt;/TITLE&gt;    
  &lt;/HEAD&gt;    
&lt;BODY&gt;    
  &lt;H1&gt;Hi&lt;/H1&gt;    
  &lt;P&gt;This is very minimal "hello world" HTML document.&lt;/P&gt;    
&lt;/BODY&gt;    
&lt;/HTML&gt;
{% endBgBox %}

Now, go to your browser again and refresh the page. You should now see a very crude website displaying 

**Hi, this is a very minimal "hello world" HTML document.**


