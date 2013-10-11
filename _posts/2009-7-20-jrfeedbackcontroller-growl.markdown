--- 
layout: post
title: JRFeedbackController + Growl
date: 2009-07-20 17:08:13 -05:00
category: posts
---

Just pushed another update to [JRFeedbackProvider on github](http://github.com/catsby/jrfeedbackprovider/commit/869a444c01cb33a8bd779375bc5ed56427f867d8).  This update displays a "Thank you" sheet on successful submission of feedback.  In addition, I added optional support for using the Growl framework.  

To use Growl to display your thank you message, change `#define USE_GROWL 0` to `1` in `JRFeedbackController.h` and add a new entry into your plist dictionary defining your other Growl messages.  [See here for more on using Growl](http://growl.info/documentation/developer/). 
