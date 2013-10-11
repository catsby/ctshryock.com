--- 
layout: post
title: Extending CocoaRest
date: 2010-03-08 19:00:00 -06:00
category: posts
tags: cocoa
---
My latest tinker project is a [Twitterific][1] like application that monitors your [Github dashboard][2], showing both updates to who you follow and updates on any repositories, yours or forks of yours.  From what I've seen [Github's API][3] supports all of this.

To accomplish this I'm extending [Steven Degutis's][4] [CocoaREST framework][5] to support the Github API in [my fork of the project][6].  So far I've got repository listings by username, and showing forks in the network setup.  There's a lot more to integrate but I'm not sure how much I want to demo in the UI.  

I also added a tab strictly for Github, with the idea being a tab for each API supported, but I haven't dug into any other API beyond Twitter or Github's I'm not sure when those will come.  Patches welcome of course.






[1]:http://iconfactory.com/software/twitterrific
[2]:https://github.com/
[3]:http://develop.github.com/
[4]:http://degutis.org/
[5]:http://github.com/sdegutis/CocoaREST
[6]:http://github.com/catsby/CocoaREST 
