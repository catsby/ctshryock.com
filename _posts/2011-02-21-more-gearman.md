---
layout: post
title: "Gearman (Part 2): Create jobs, add workers, do work"
category: gearman
published: true
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

##Creating Jobs

- *Jobs* are created by *Clients*, who send them to the *Gearman server* via *Tasks*
- A *Task* is communication *about* a job, such as "run this job" or "what is the status of this job"
- A *Job* is something the *worker* does
- *Workers* continuously waiting on the job server to tell them when to start and with what arguments
- *Clients* submit *jobs* and ask for status about *jobs* (both of those things are considered *tasks*)
- *Workers* actually perform the *jobs*

*[Source here][7]*

We'll start with a very simple "reverse string" job to get going.  First we'll create the client to submit the job.  We do so by instantiating a new `GearmanClient` object, 
set the server where **Gearmand** is running, and calling `do` with the *job name* and the workload:
{% highlight php %}
//  reverse_do.php
<?php
# Create our client object.
$client= new GearmanClient();

# Add default server (localhost).
$client->addServer('localhost','4730');

echo "Sending job...\n";
# Send reverse job

$result = $client->do("reverse", "Hello World!");

echo "Result: {$result}" . PHP_EOL;
?>
{% endhighlight %}

You can run this on the command line like so:

{% highlight bash %}
~$ php reverse_do.php 
Sending job...
{% endhighlight %}

The client will wait for the response (there are other types of jobs where the client does not wait, called background jobs).  

Now we create a worker in a similar process: instantiating a new `GearmanWorker` object and set the server where **Gearmand** is running, except now we register a method of work 
that we can do, and define that function:

{% highlight php %}
//  reverse_worker.php
<?php

$worker = new GearmanWorker();
$worker->addServer('localhost','4730');
$worker->addFunction('reverse', 'reverse_function');

while ($worker->work());

function reverse_function($job)
{
    //  For example purpose
    echo "Received job: {$job->handle()}" . PHP_EOL; 
    return strrev($job->workload());
}
?>
{% endhighlight %}

Now we run the worker from another terminal session.  Because we've put the worker in an endless `while` loop, the worker 
will connect to the server and perform jobs until we kill the process with `cntrl+c`

{% highlight bash %}
~$ php reverse_worker.php 
Received job: H:Waffles.local:11
{% endhighlight %}

Back on the original terminal session, where we left the client waiting, you should see an update:

{% highlight bash %}
~$ php reverse_do.php 
Sending job...
Result: !dlroW olleH
~$ 
{% endhighlight %}

The **Gearmand server** held on to the job until a worker arrived that could preform the work.  Once our worker fired up, the server handed 
the job over, the worker did the work, and told the server it was done and could accept more work.  The server in turn passed the result 
back to the client, and the client process terminated, printing the reversed string.  

[1]: /gearman/2011/02/16/setting-up-gearmand.html
[2]: http://gearman.org/index.php?id=documentation
[3]: /gearman/2011/02/16/setting-up-gearmand.html
[4]: http://pecl.php.net/package/gearman 
[5]: https://github.com/atmos/cinderella
[6]: http://pecl.php.net/package/gearman
[7]: http://gearman.org/index.php?id=manual:clients