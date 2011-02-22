---
layout: post
title: "Gearman (Part 2): Create jobs, add workers, do work"
category: gearman
published: false
---

**Other posts in this series**
- [Gearman (Part 1): Setup Gearmand][3]
- Gearman (Part 2): Create jobs, add workers, do work
- Gearman (Part 3): More jobs, other stuff, a better title (soon after Part 2)

Now that [Gearmand is setup][1] we need to get some workers going.  Gearman is itself language agnostic; it doesn't really 
care if your client/worker is in Python, PHP or Ruby, to name a few.  There are [several libraries available][2] to help 
you get going. 


##PECL::Gearman
In order to get clients and workers setup using PHP you need to have **libgearman** installed; this came with **Gearmand** from my 
[previous post in this series][1].  For this example I'll be using the [Gearman PECL extension][4].  I assume you already have PHP installed on your system.  

By default, the configure script looks in `/usr/local`, `/usr`, and `/opt/local` to find the **libgearman** header files.  If 
you're using **Homebrew**, **MacPorts**, or installed **from source** you should have no problem.  

To install using PECL, run

{% highlight bash %}
~$ (sudo) pecl install gearman-beta
{% endhighlight %}

The `-beta` is required since there is no full fledged stable release to use at this time.

**Side Note:** 
This should work fine for installations of **libgearman** I covered previously, but if you're like myself and have your **Homebrew** 
installed elsewhere (I use [Cinderella][5]), your header files are in a different place, and you'll need to compile the 
extension by [downloading the source][6], extracting it, and running the following

{% highlight bash %}
~$ cd Downloads/gearman-0.7.0/gearman-0.7.0
~$ phpize
~$ ./configure --with-gearman=`brew --prefix`
~$ make
~$ (sudo) make install
Installing shared extensions:     /usr/lib/php/extensions/no-debug-non-zts-20090626/
~$
{% endhighlight %}

When the installation completes, you should receive instructions on activating the extension.  They typically involve updating 
your `php.ini` file to include the `extension_dir` and add `extension=gearman.so` near the end of the file.  After that, 
restart your sever. 

To confirm everything is OK, create a simple php file that echo's out the gearman version:

{% highlight php %}
//gearman_version.php
<?php
echo "Gearman version: " . gearman_version() . PHP_EOL;
?>
{% endhighlight %}

And run the file

{% highlight bash %}
~$ php gearman_version.php
Gearman version: 0.15
{% endhighlight %}

##Creating jobs




[1]: /gearman/2011/02/16/setting-up-gearmand.html
[2]: http://gearman.org/index.php?id=documentation
[3]: /gearman/2011/02/16/setting-up-gearmand.html
[4]: http://pecl.php.net/package/gearman 
[5]: https://github.com/atmos/cinderella
[6]: http://pecl.php.net/package/gearman