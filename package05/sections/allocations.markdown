---
layout: package-part-ext
part: Documentation
---
{% include /docLinks.markdown %}

After you have used the Project Trial to gain experience with virtual machines, you may want to request more resources on the Research Cloud. You will have to submit a request for this. 

The NeCTAR Resource Allocation Committee (RAC) approves resource allocation on the basis of the scientific and technical merit of the application and its requirements. You are asked to specify some details about your research and how you plan to use the resources you are requesting.

Before making an allocation request it is best to discuss your requirements with your local eResearch office or IT services. You may easily get access to resources available to your organisation.

The following steps describe the process of submitting such a request.


**1. Assess your options.**     
If you are associated with one of the [cloud nodes](http://support.rc.nectar.org.au/docs/building-nodes) you may be eligible for access to a local allocation of cloud resource.
So speak to your local node about this prior to submitting a resource request.
Otherwise, your request will be reviewed by the NeCTAR Allocation Committee.

**2. Submit a request.**     
Use the Allocation Request form from the left hand side menu of your [Dashboard](https://dashboard.rc.nectar.org.au).
{% img src=images/requestAllocation.png, w=50, alt=Dashboard Allocations, dim=percent, align=center, css=margin-top:10px;margin-bottom:20px; %}

* On **Allocations > New Request** you can request to create a **new project** with the resources you need.    
* On **Allocations > My Requests** you can **add resources** to your **existing project** (you will also see your previous requests here).    

As a rule of thumb, the more resources you ask for, the more detail we require about your research. Requesting a few cores won't be scrutinised as much as requesting tens or hundreds of cores.    

{% BgBox important %}
{% include /docLinks.markdown %}
The amount of **CPU hours** you request is the amount of time your instance will be in existence --- *not* the time the CPU is actually busy with your programs! That is, all time counts between when you *launch* the VM and *terminate* it --- regardless whether the CPU is idle the whole time, or the VM is shut down or suspended. While you have access to the VM, it counts as CPU hours!

Consider this when you request your allocation, and also when you use your VM --- you may *back up* the state of your VM and then *"terminate"* it while you don't need it. It will be easy to restore it to the exact same state when you need it again. More about this in [Module 9][ModDoc9].
{% endBgBox %}


{% BgBox info %}
Within the Research Cloud resources are allocated to projects, not users. Projects can have one or more users.
In the dashboard your single login will allow you to switch between all projects you have access to.

Each project (other than "*Project Trials*" with names like pt-xxxx) has at least one Project Manager. Requests to join a project or become an Project Manager for a project should be directed to the management of that project.
For more information about projects and how to manage them, see the [NeCTAR support website](http://support.rc.nectar.org.au/docs/managing-project)
{% endBgBox%}

**3. Wait for application to be processed.**     
After you submit a request, you will receive a confirmation email with all your details.
View or edit your request by clicking on the ‘My Requests’ tab at the Dashboard.    
Your request will be reviewed by the your local node (if any) or the NeCTAR Allocation Committee.
This can take **up to four weeks** to process.
If there are any issues with your request, we will get in touch with you.
You may be asked to provide more detail about your research or to clarify your technical requirements.

**4. Manage your allocation.**     
When your application has been approved, a *Research Cloud Project* will be created for you. When submitting the request, you have been given the chance to suggest a name (title) for the project. If this name was still available, that's what your project will be called.    
You will receive an email confirming everything is ready to go.
You can now start using your resources allocated to the project. 
{% BgBox info %}
As a user, you can be a member of more than one project.
You select the current project to access at the Dashboard using a drop down menu on the left hand side.
{% endBgBox%}

One more thing you may want to do is **adding or removing users** to the project.
Users can be members of multiple Projects sharing each Projects resources with its members.
To add other users as members of your Project(s), see the [NeCTAR support website](http://support.rc.nectar.org.au/docs/managing-project)

You may also want to **increase resources** of your existing Project. You can make changes to your request at any time by clicking on ‘My Requests’ at the dashboard. This will show the requests you have made and you can update them.
If you change and resubmit the request, it will go through the review process as outlined earlier.


{% BgBox info %}
You can find more information about the allocation process on the [NeCTAR support website for allocations](http://support.rc.nectar.org.au/docs/allocations).
{% endBgBox%}
