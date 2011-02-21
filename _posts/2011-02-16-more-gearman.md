---
layout: post
title: "Gearman (Part 2): Setup workers, adding jobs, do work"
category: gearman
published:false
---

Now that [Gearmand is setup][1] we need to get some workers going.  Gearman is itself language agnostic; it doesn't really care if your client/worker is in Python, PHP or Ruby, to name a few.  There 
are [several libraries available][2] to help you get going. 

In order to get clients and workers setup you need to have **libgearman** installed; this came with **Gearmand** from my [previous post in this series][1], however depending on your method 
the location may vary.


[1]: /gearman/2011/02/16/setting-up-gearmand.html
[2]: http://gearman.org/index.php?id=documentation
