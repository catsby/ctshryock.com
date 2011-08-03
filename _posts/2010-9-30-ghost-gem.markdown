--- 
layout: post
title: Ghost gem
date: 2010-09-30 10:02:35 -05:00
image: dog.JPG
category: posts
---
I typically develop sites on my local machine using custom vhosts in Apache and adding lines to my `/etc/hosts` file to point custom urls to `127.0.0.1`.  After some time that file grew to be large and sometimes tedious to update.  Enter [ghost gem][1].  Simple hostname management.

{% highlight bash linenos %}
Waffles:~ clint$ ghost modify pup.local 127.0.0.1  
  [Modifying] pup.local -> 127.0.0.1
{% endhighlight %}

Adds a new entry (somewhere, not /etc/hosts though) and you can now use puppy.local as a url to point to your machine with a vhost setup to respond to that scheme.  

You can use this for just about any url or IP you want too:


{% highlight bash linenos %}
Waffles:~ clint$ ghost add puppy google.com  
  [Adding] puppy -> 74.125.65.105
{% endhighlight %}

`ghost list` shows what you have already:


{% highlight bash linenos %}
Waffles:~ clint$ ghost list  
  Listing 2 host(s):  
    pup.local -> 127.0.0.1  
    puppy -> 74.125.65.105  
{% endhighlight %}

Full details and commands are listed on [bjeanes github repo][1].   

[1]:http://github.com/bjeanes/ghost 
