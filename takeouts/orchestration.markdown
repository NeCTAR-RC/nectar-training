---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}


### Puppet and heat

You can create a template which describes what resources you need. Heat takes care
of provisioning the resources and handling and recovering from any failures or issues.

Tools like puppet and heat help you build scalable applications without worrying about creating and configuring the underlying infrastructure.

*Heat* manages the whole lifecycle of the application. When you need to change your infrastructure, you can modify the text template. Heat knows how to make the necessary changes. It will also delete all of the resources when you are finished with the application. Heat primarily manages infrastructure, but the templates integrate well with *software configuration management tools* such as *Puppet *and *Chef*.

*Puppet* is an open source platform for provisioning, configuring and patching applications and

operating system components. Puppet manages your servers: you describe machine configurations and dependencies in a text file, and Puppet will bring your systems into the desired state and keep them there.



