---
layout: post
title: "Gearman (Part 1): Setup Gearmand"
category: gearman
---

**Other posts in this series**
- Gearman (Part 1): Setup Gearmand
- [Gearman (Part 2): Create jobs, add workers, do work][10]
- Gearman (Part 3): More jobs, other stuff, a better title (soon after Part 2)


[Gearman][1] has occupied my thoughts and time lately.  Gearman is a "generic application framework to farm out work to other machines or processes that are better suited to do the work".

In short, it's a job-queue system.  You send it jobs you want done, it delegates those tasks to workers who know how to handle that work.  Workers 
connect to the server and announce what jobs it can handle; The server doesn't care about "how" they handle that job, just that they can.  The 
server passes the job off to the worker and can then (conditionally) pass messages back to the client for messages like status, completions, or failures.  

Classic usage examples for websites are image resizing or video conversion.  Instead of the user waiting for the server to re-size or convert, 
you redirect them elsewhere with a message saying it will be done soon.  This lets the user go about their business, and you can delegate the 
work to another machine, leaving your web server to serve webpages instead hog memory converting things.

##Setup
If you're on a Mac, I highly recommend [Homebrew][2], an excellent package manager for installing all kinds of software with ease.  Getting Gearman**d** (the daemon process and client libraries) is easy:

{% highlight bash %}
~$ brew install gearman
{% endhighlight %}

If you're using [MacPorts][3]

{% highlight bash %}
~$ (sudo) port install gearmand
{% endhighlight %}    

If you're on Ubuntu you can use `aptitude`

{% highlight bash %}
~$ sudo aptitude install gearman-job-server (gearman-dev)
{% endhighlight %}

Check your favorite Linux Distro's package manager for their equivalent.  

Finally, you can always compile from [source][4]

{% highlight bash %}
~$ tar xzf gearmand-X.Y.tar.gz  
~$ cd gearmand-X.Y  
~$ ./configure  
~$ make  
~$ (sudo) make install  
{% endhighlight %}

Once that finishes, you should have Gearman all setup

{% highlight bash %}
~$ gearmand --version
gearmand 0.15 - https://launchpad.net/gearmand
{% endhighlight %}

##Running
Gearmand is typically run as a daemon in the background

{% highlight bash %}
~$ gearmand -d
~$ 
{% endhighlight %}

This causes Geramand to run to detach from the current shell and run in the background.  While developing, it may be helpful to run in debugging mode

{% highlight bash %}
~$ gearmand -vvv
 INFO Starting up
 INFO Listening on :::4730 (6)
 INFO Listening on 0.0.0.0:4730 (7)
 INFO Creating wakeup pipe
 INFO Creating IO thread wakeup pipe
 INFO Adding event for listening socket (6)
 INFO Adding event for listening socket (7)
 INFO Adding event for wakeup pipe
 INFO Entering main event loop
{% endhighlight %}     

By default, Geramand listens on `localhost/127.0.0.1` and port `4730`.  There are [many other options][5] you can choose to add.

So now you have Geramand setup.  Go forth, and write [clients and workers][6].  Other documentation can be found [here][7], including an incomplete list 
of libraries (for instance, it's missing [gearman-ruby][8]).

[1]: http://gearman.org/
[2]: https://github.com/mxcl/homebrew
[3]: http://www.macports.org/
[4]: http://gearman.org/index.php?id=download
[5]: http://gearman.org/index.php?id=manual:job_server
[6]: http://gearman.org/index.php?id=getting_started#client_and_worker_api
[7]: http://gearman.org/index.php?id=documentation
[8]: https://rubygems.org/gems/gearman-ruby
[10]: /gearman/2011/02/21/more-gearman.html