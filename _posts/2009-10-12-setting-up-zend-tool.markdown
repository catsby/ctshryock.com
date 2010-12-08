--- 
layout: post
title: Using Zend Tool
date: 2009-10-12 18:41:15 -05:00
mt_id: 18
---
[Zend Tool](http://framework.zend.com/wiki/display/ZFDEV/Zend+Tool+Initiative "Zend Tool Initiative") is a powerful command-line script to help generate Zend Framework "units" as I call them, from the complete initial application structure to controllers, or actions in controllers that already exist.  

Though released a the incubator a few versions back, I've found it to be more stable and easier to setup just recently.  Fortunately I just did a clean install and lost my setup of Zend Tool, giving me the chance to blog about it here.

I first learned how to setup Zend Tool with [this guide](http://devzone.zend.com/article/3811 "Using Zend_Tool to start up your ZF Project").  It details at least two ways to get Zend Tool running, plus some instructions for Windows users.  My instructions will be for Mac OS X (but should work for most Unix-like systems) and for development purposes only.  

##Getting Zend Framework
First step is getting the framework.  Zend Tool requires the Zend Framework be in your `php.ini`'s `include_path`, so you need to obtain the source.  The Zend Framework source is available for public checkout via subversion, and since you're developer, we'll go that route.  Personally, I like to checkout a release tag and not a trunk, that way I can incrementally update from tag to tag instead of just updating from the trunk.  Either should work.  I use my user's `Sites` folder for all my development work so I'm going to check it out there.

{% highlight bash %}
svn co http://framework.zend.com/svn/framework/standard/tags/release-1.9.4 ZendFramework
{% endhighlight %}

It's not small, depending on your network, this could take awhile...

Once that's finished `cd` into the `ZendFramework` dir and the core library is in `library/Zend`, with the Zend Tool scripts in `bin/`.  


##Add Zend Framework to your Include Path
Second step is to add the the contents of the `Zend` folder to you include path.  I'm using [Macports](http://www.macports.org/ "MacPorts") so `php.ini` file is located in  `/opt/local/etc/php5/`.  By default the includes path was commented out and looked like this:
	;include_path = ".:/php/includes"

Change that to uncomment it and add the `library` folder of your checkout

	include_path = ".:/php/includes:/Users/clint/Sites/ZendFramework/library"


##Setting up the script
The `bin` folder comes with 3 scripts, a shell script `zf.sh`, bat script for Windows users `zf.bat`, and a php script that they both use `zf.php`.  `zf.sh` is the script I'll be using and we need it on our system `PATH`, which I'm going to do via symbolic link

	sudo ln -s ~/Sites/ZendFramework/bin/zf.sh /usr/bin/zf


##Using Zend Tool
Check to see if Zend Tool is working by typing `zf` into the command-line:

<img src="/images/output-thumb-500x104-5.jpg" width="500" height="104" alt="output.jpg"  style="text-align: center; display: block; margin: 0 auto 20px;" />

The first thing you'll see is an error, since we didn't supply the correct number of arguments, but following that you'll get usage instructions for all the options of Zend Tool.  

Now lets create a project by switching to your local server's document root and running :

	zf create project test-app

Now take a look around at what was made by opening `test-app`

<img src="/images/test-app-structure-thumb-200x135-8.jpg" width="200" height="135" alt="test-app-structure.jpg"  style="text-align: center; display: block; margin: 0 auto 20px;" />

and view it on the web: [http://localhost/test-app/public](http://localhost/test-app/public "Test app on your local server").  You should get the default homepage setup of a Zend Framework Application:

<img src="/images/home-thumb-200x130-11.jpg" width="200" height="130" alt="home.jpg"  style="text-align: center; display: block; margin: 0 auto 20px;" />

Zend Tool can do more than just create the project structure, so lets create a controller and an additional action.
{% highlight bash linenos %}
	cd test-app
	zf create controller tool
{% endhighlight %}

You can see that Zend Tool created a controller named `ToolController` and added view scripts for you under `views/scripts/tool/`

<img src="/images/tool-controller-thumb-200x110-14.jpg" width="200" height="110" alt="tool-controller.jpg"  style="text-align: center; display: block; margin: 0 auto 20px;" />

You can see the default text for that script here: [http://localhost/test-app/public/tool](http://localhost/test-app/public/tool "Tool Controller")

Now lets create an action.  Zend Tool's `create action` method takes requires a controller name as the second arguement; if you don't specify one, it will assume you want to use the `Index` Controller.  

	zf create action example tool

Your results should be like this:

<img src="/images/tool-example-action-thumb-200x119-17.jpg" width="200" height="119" alt="tool-example-action.jpg"  style="text-align: center; display: block; margin: 0 auto 20px;" />

There are other options and methods in Zend Tool; if you've made this far and understand, you can figure them out 
