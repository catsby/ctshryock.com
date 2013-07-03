---
layout: post
date: 2012-07-12 22:26:13 -0500
title: "Running Rails with Puma on Heroku"
category: posts
---

**02 July 2013 Puma 2 Updates:**

- Update [Procfile](#procfile)
- Add [Configuration](#configuration)
- Add [Clustered mode](#clustered-mode)
- Mention threads

I've been playing around with [Heroku][1] a lot lately and noticed they
recommend using [Thin][2] for your production server when running Rails. In recent months
I've grown attached to [Puma][3] (for no qualified reasons) and wanted to see if
I can get a Rails app running on Heroku's [cedar stack][4] with Puma instead. It
turned out to be really, really simple. 

<div class="alert alert-info">
It's important to keep in mind that Puma is threaded; if your code is not threadsafe, or your not
using config.threadsafe!, you may have a bad time (Rails 4 is
threadsafe by default).
</div>


## Create a new Rails 3.x app

First create a new rails app, heroku app, and initialize a git repo:

{% highlight bash %}
$ rails new heroku-puma
  create 
  ...
$ cd heroku-puma
$ heroku create
  Creating high-day-4093... done, stack is cedar
  http://high-day-4093.herokuapp.com/ | git@heroku.com:high-day-4093.git
$ git init
$ git remote add heroku git@heroku.com:high-day-4093.git
{% endhighlight %}
  

Launch your favorite editor and make some standard adjustments in your
`Gemfile`, just as a demonstration:

{% highlight ruby %}
...
gem 'sqlite3'
...
{% endhighlight %}

becomes

{% highlight ruby %}
...
gem 'thin'
...
{% endhighlight %}

## Deploy with Thin, just for fun

Back in the terminal, add your files to the git repo and make your first
commit, then push it up to Heroku:

{% highlight bash %}
$ git add .
$ git commit -m "Initial import, using Thin server"
$ git push heroku master
-----> Heroku receiving push
-----> Ruby/Rails app detected
-----> Installing dependencies using Bundler version 1.2.0.pre
Running: bundle install --without development:test --path vendor/bundle --binstubs bin/ --deployment
Fetching gem metadata from https://rubygems.org/.......
...
Installing thin (1.4.1) with native extensions
...
-----> Launching... done, v4
http://high-day-4093.herokuapp.com deployed to Heroku
$
{% endhighlight %}

Now that your app is launched, do a quick `curl` call and confirm it's
on Thin:

{% highlight bash %}
$ curl -I http://high-day-4093.herokuapp.com
HTTP/1.1 200 OK
[...]
Server: thin 1.4.1 codename Chromeo
[..]
$ 
{% endhighlight %}

Hooray, we're running Thin! You can see this in the **Server** header
that Thin sets. Except, we want to run Puma...


## Procfile

Cedar introduced a new way to think about scaling your app; "the process model". It's a generalized approach to managing processes across Heroku's distributed environment, allowing you to tweak how and what gets run via a [Procfile][5]. Here we'll create a simple `Procfile` and tell our app to run with Puma instead of Thin.

First, swap out Thin for Puma in your `Gemfile`:

{% highlight ruby %}
...
gem 'puma'
...
{% endhighlight %}

[^proc]Then add a file named `Procfile` to the root of your project and add the following:

    web: bundle exec puma -p $PORT -e $RACK_ENV -t 0:5
    
Those are the instructions Heroku will use to run your `web` process.

<div class="alert alert-info">
Here $PORT and $RACK_ENV reference environment variables provided by Heroku, port being the
listen port assigned by the Heroku router, and $RACK_ENV being the mode
to run your app, typically 'production'.
The -t flag lets you tune the threads Puma will use; here we set it to
minimum 0, maximum 5, to line up with the default connection pool count
from ActiveRecord.
</div>

Making sure to add the new `Procfile` to your repo, commit your changes
and push to Heroku again:

{% highlight bash %}
$ git add Procfile
$ git add Gemfile
$ git commit -m "Use Puma via a Procfile"
$ git push heroku master
  -----> Heroku receiving push
  -----> Ruby/Rails app detected
  -----> Installing dependencies using Bundler version 1.2.0.pre
  Running: bundle install --without development:test --path vendor/bundle --binstubs bin/ --deployment
  Fetching gem metadata from https://rubygems.org/.......
  ...
  Installing puma (1.4.0) with native extensions
  ...
  -----> Launching... done, v5
  http://high-day-4093.herokuapp.com deployed to Heroku
{% endhighlight %}

Now we run our `curl` command again:

{% highlight bash %}
$ curl -I http://high-day-4093.herokuapp.com
HTTP/1.1 200 OK
[...]
$
{% endhighlight %}

Hooray, we're not running Thin! Except it doesn't say we're running Puma
either... I suppose Puma doesn't report itself like Thin and WEBrick do. 

Now if you run `heroku ps` you should see you have 1 web dyno running,
and the statement used to run it:

{% highlight bash %}
$ heroku ps
=== web: bundle exec puma -p $PORT -e $RACK_ENV -t 0:5
web.1: up for 2m
{% endhighlight %}

Congratulations, you're running Puma! Note that Puma is said to really
shine with Rubinius and JRuby where it can utilize multiple threads.
Still, it should give you some benefits on MRI as well. 

## Configuration

As you continue to fine tune your Puma setup, you may find yourself with
more than a few flags and switches in your invocation (the `web:` part of
the `Procfile` in this case). Puma lets you specify a configuration file
for all this, using the `-C` flag:

{% highlight bash %}
web: bundle exec puma -p $PORT -C ./config/puma.rb 
{% endhighlight %}

And matching `./config/puma.rb` file:

{% highlight ruby %}
# config/puma.rb
environment ENV['RACK_ENV']
threads 0,5
{% endhighlight %}

**Done!** Checkout the [sample configuration][7] or
[configuration.rb][8] in the
repository to see all available options.

<div class="alert alert-info">
Note: you can't configure the port in your configuration file. Not sure
why, maybe a bug.
¯\_(ツ)_/¯  
</div>

## Clustered Mode

With it's 2.0 release, Puma learned some new tricks, key being the
addition of [Clustered
Mode](https://github.com/puma/puma#clustered-mode). Puma gains a level of concurrency by spawning workers to handle requests,
each worker with it's own set of threads. You enable clustered mode with
the `-w` or `--workers` flag, providing the number of workers you'd like
to spawn. To enable this on Heroku, simply update your `Procfile`:

    web: bundle exec puma -p $PORT -e $RACK_ENV -w 3 -t 0:5

Or add `workers` to your `./config/puma.rb` file:

{% highlight ruby %}
# config/puma.rb
environment ENV['RACK_ENV']
threads 0,5

workers 3
{% endhighlight %}

You can optionally choose to preload your application before spinning up
your workers. Use the `--preload` flag or call `preload_app!` in your
config file.

Finally, you can hook into your workers before they boot with the
`on_worker_boot` method in your config file. An example of something to
do here is if you're preloading your application, you'll want to
  establish your ActiveRecord connections here:

{% highlight ruby %}
# config/puma.rb
environment ENV['RACK_ENV']
threads 0,5

workers 3
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
{% endhighlight %}

**Done!**

You've ran the gamut and setup Puma on Heroku, and threw in lots of
optional things a long the way. Checkout [puma.io][3] and
[github.com/puma/puma][6] for more info. 

**Now get hacking.**

[1]: http://heroku.com
[2]: https://devcenter.heroku.com/articles/rails3#webserver
[3]: http://puma.io
[4]: https://devcenter.heroku.com/articles/cedar
[5]: https://devcenter.heroku.com/articles/procfile
[6]: https://github.com/puma/puma
[7]: https://github.com/puma/puma/blob/master/examples/config.rb
[8]: https://github.com/puma/puma/blob/master/lib/puma/configuration.rb

