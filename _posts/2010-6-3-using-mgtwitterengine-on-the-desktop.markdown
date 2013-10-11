--- 
layout: post
title: Using MGTwitterEngine on the desktop
date: 2010-06-03 08:46:30 -05:00
category: posts
tags: cocoa
---
The main branch of [MGTwitterEngine][1] has been updated to support [Twitter's OAuth implementation][2], however it's geared for the iPhone/iPad.  With some simple adjustments you can easily use it on the desktop.  Instead of using [jdg's OAuthConsumer][3] root project, try [my fork here][4], which replaces the custom hmac_sha1 implementation with standard CommonCrypto, which I pulled from [roustem's fork][5].

In a future post I'll do a walkthrough of the basic setup, from cloning the repository, setting up the submodules, and getting a working example.


[1]: http://github.com/mattgemmell/MGTwitterEngine
[2]: http://dev.twitter.com/pages/auth
[3]: http://github.com/jdg/oauthconsumer
[4]: http://github.com/catsby/oauthconsumer
[5]: http://github.com/roustem/oauthconsumer 
