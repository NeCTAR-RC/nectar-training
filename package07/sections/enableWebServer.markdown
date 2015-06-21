---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


# 7.4: Enable web service

In this section we are going to enable a web server and create our first simple web site.

To install the web server, go to the *ssh shell* and type:

  *sudo apt-get install apache2*

Confirm installation of the package with ‘Y’.

Now, open the web browser on your local computer, and type your instance’s IP address in the URL field.

We will see the default apache website of the browser.

Let’s now start our own simple website. In your *ssh shell*, type:

  *nano /var/www/html/index.html*

the directory */var/www/html* is where your website lives by default, and the file *index.html* is the start page which we want to edit. In the editor that comes up, remove all the text inside and replace it with the text below. 

*Tipp*: Copy and paste will not work with your terminal. Instead, you can try to copy the text, then click with your mouse on the place you want to insert the text in your ssh terminal editor. Then, click the right or middle mouse button -- that will work on many systems to "paste" the contents of your clipboard.

<!DOCTYPE html PUBLIC "-//IETF//DTD HTML 2.0//EN">

<HTML>

   <HEAD>

  	<TITLE>

     	A Small Hello

  	</TITLE>

   </HEAD>

<BODY>

   <H1>Hi</H1>

   <P>This is very minimal "hello world" HTML document.</P>

</BODY>

</HTML>

Now, go to your browser again and refresh the page. You should now see a very crude website displaying *Hi, this is a very minimal "hello world" HTML document*.


