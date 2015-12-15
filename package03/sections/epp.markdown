---
layout: package-part-ext
part: Documentation
---

{% include /docLinks.markdown %}

You have an **"embarrassingly parallel problem" (short: EPP)**.  "Embarrassingly parallel problems" are characterized by being trivially parallelizable: no complex methods have to be applied to solve the problem by means of parallel methods, for example solving each part of the problem in a separate computer. This may save you huge amounts of time for your results to be finished. 

For example, a very large data set can be chopped into pieces which are then dispatched to various computers for processing; when finished, the resulting data is re-assembled. 

{% img src=images/EPP.png, w=70, dim=percent, alt=image, align=center %}

Or in another example, copies of a smaller data set are distributed across computers to perform different computations on it, and when all the individual analyses of the data are finished, the results are summarized. 

{% img src=images/EPP2.png, w=60, dim=percent, alt=image, align=center %}

The individual computers don't have to be super fast, but instead the power lies in having a huge number of computers working at solving the problem simultaneously. 

Software like *MapReduce* can be used to manage splitting the problem into several pieces and dispatching them to different computers.

Embarrassingly parallel problems will be re-visited in [Module 4][ModDoc4].
In [Module 7][ModDoc7], we will discuss how to set up and access a virtual machine. 


