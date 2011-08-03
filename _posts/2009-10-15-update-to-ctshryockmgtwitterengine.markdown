--- 
layout: post
title: Update to ctshryock/MGTwitterEngine
date: 2009-10-15 16:44:30 -05:00
category: posts
tags: cocoa
---
Today I posted my update to [ctshryock/MGTwitterEngine](http://github.com/ctshryock/MGTwitterEngine "My fork of MGTwitterEngine") which allows you to use the API's `update_profile_image` and `update_profile_background_image`.  I added to the demo app a window that lets you select an image for either profile image or background image to see it in action.

I had to modify some of the internals to get this to work... originally the `_sendRequestWithMethod:path:queryParameters:body:requestType:responseType:` method built the `NSMutableRequest` object internally, but to minimize code duplication I split the initial creation of the request into a new method `_baseRequestWithMethod:path:queryParameters:` to do that, and added a new method `_sendDataRequestWithMethod:path:queryParameters:filePath:body:requestType:responseType:` .  Both `_sendRequest...` and `_sendDataRequest...` call `_baseRequest...` to start, with the latter adding the needed form/multipart data to the request.
 
