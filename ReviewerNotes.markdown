---
layout: post
title: Notes for reviewers
---

### NeCTAR National Training Course Material

All modules are ready for review. They will still be continuously improved and updated (e.g. phrasing, adding images, and other polishing and detailing). But feedback would be greatly appreciated at this point in order to shape the material accordingly.

This document will in future contain "release notes", i.e. the current state / changes of the documentation.

See also the general [README](README.html) for more information.

To review a file, you may add a comment using the following *jekyll tag*:

{% raw %}
{% review &lt;Your-name&gt; %} <br/>
Text of your review comment <br/>
{% endreview %}
{% endraw %}

which will result in the HTML output:
{% review Your-name %}
Text of your review comment
{% endreview %}

We will be able to find your note easily with a *grep* over all files.
For simple corrections (like typos or change of phrasing), feel free to **directly edit the text in the files**. Only major chages or relevant notes should be made with the review tag.

### General Remarks

* The documentation can be found in the packages under the *Documentation* link.

* The documentation can be seen as a **storyline for the videos and face-to-face training** --- although the videos/face-to-face training will not include everything, but sometimes refer to the online documentation for more detailed information.

* All documents will still be enriched with **images and graphics** to describe concepts and ideas. The graphics are still in production and will be gradually added over the next week. A coarse image draft will be inserted as a placeholder first, then gradually being replaced by the final graphics.

* All **screenshots** which are included so far will be refined to include highlights (e.g. boxes drawing attention to a section on the screen).

* Each module ("package") is split into several **sections** to make navigation within the  module easier. 

* The **layout** of all pages is still very crude --- for example, the navigation links for *sections* of a module is displayed on top of the page. It would be better to have this on the left-hand side.

* Notes in {% col 255,0,0 %} red {% endcol %} and/or marked with "TODO" are things that will be changed in near future, according to the description in the comment. If this contains a question, please feel free to answer it with a *review tag*. 

* It will be possible to compact the length of the documentation by rendering different versions depending on the researchers operating system (e.g. one version of the documents for Windows only, another for Linux only, etc.). This should not take too much extra effort.



# Remarks in particular about Module 7

1. This is a *comprehensive* discussion on how to launch and connect to a VM. From the experience we have with the courses delivered by Intersect, many researchers are more comfortable with detailed instructions. For example, even people who enrol in the *Intro to Unix & HPC* course end up having difficulties with the command line.

    For this reason, we decided to include instructions on how to connect to a remote desktop, expecting that many people will feel more comfortable (and more encouraged) with this. For the same reason, this document is kept at a very comprehensive level, using easy terminology as far as possible.

   It will be easy to generate a quick HowTo for more experienced users from this.

1. The length of this document does not reflect the time the video will take or the time the users have to spend doing the course. First of all, there are lots of screenshots. Second, users will not have to follow *all* instructions, e.g. they choose only *one* desktop environment, and only *one* remote desktop solution (vnc or x2go), they choose only *one* client for the object store, etc. There are also some *optional* sections, e.g. creating configuration files to make your life easier, or setting up a webserver.


# Summary of states of the modules

**Module 1**: Completed, now subject to revisions.

**Module 2**: Partly completed. We will get a short description (1-2 slides, a short paragraph, and an optional video of 1-2 mins) from one person in the support team of the virtual labs or eResearch tools to describe their tool / vlab as they feel is most appropriate.

**Module 3**: Completed, now subject to revisions.

**Module 4**: Completed, now subject to revisions.

**Module 5**: Completed, now subject to revisions.

**Module 6**: Completed, now subject to revisions.

**Module 7**: Completed, now subject to revisions.

**Module 8**: Completed, now subject to revisions.

**Module 9**: Completed, now subject to revisions.

**Module 10**: Completed, now subject to revisions.


### Last but not least

Feedback, critique, corrections, suggestions etc. are more than welcome of course!


