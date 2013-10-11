--- 
layout: post
title: EMKeychain update
date: 2009-10-07 12:35:08 -05:00
category: posts
---

I originally found [EMKeychain](http://extendmac.com/EMKeychain/ "EMKeychain from Extendmac") a few months back and added it to my project to take over managing interactions between my app and the Keychain.  It worked well until I updated to Snow Leopard and started using the LLVM GCC 4.2 compiler.  Doing so threw some new errors about non-explicit casts and deprecated methods.  I went in search of an update on Extendmac's site and by chance found [@sdegutis](http://twitter.com/sdegutis)'s [fork of the project on GitHub](http://github.com/sdegutis/EMKeychain "EMKeychain on GitHub").  

I forked the project [here](http://github.com/catsby/EMKeychain "EMKeychain ctshryock fork") and started replacing my current EMKeychain setup with this new one.  The newer isn't terribly different but it went from 4 files to 2, and we're not using "proxy" object anymore instead just class methods for getting / creating keychain items.

One thing I did notice is the inconsistent results, but I don't think it's due to this newer version.  I created a temp project and ran a loop getting and printing a specific keychain password 10 times and got the actual password, null, or the password with some extra characters at random times.  Not encouraging.  

Luckily I did track down the issue; the raw char password wasn't being converted to an NSString object correctly, so I was able to write a patch using the `C strncpy` method.  You can check out my \*fixed\* version with the link above, but I did find in the network what is probably a better fix with user [irons](http://github.com/irons "Nathaniel Irons") [fork](http://github.com/irons/EMKeychain "irons/EMKeychain"), which I plan on integrating soon.   
