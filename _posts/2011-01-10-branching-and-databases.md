---
layout: post
title: Branching and Databases
category: posts
---

<img src="http://ctshryock.com/static/images/doctrine.png" alt="Odd state with git branches and doctrine migrations" />  

We use [Git][1] at work and make use of several concurrent topic branches.  At the same time, we utilize [Doctrine][2] to keep our databases in line and updates made to them sane and manageable.  

This creates interesting databases states, however, as seen above.  Screenshot is from a hotfix branch where several migrations from topic branches aren't included in the source, but have been ran on my local database.  This isn't a problem unique to our workflow, but with Doctrine, I'm now able to visualize it.  


[1]: http://git-scm.com/
[2]: http://www.doctrine-project.org/
