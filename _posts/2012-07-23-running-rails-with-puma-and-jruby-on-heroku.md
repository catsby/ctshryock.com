---
layout: post
date: 2012-07-23 08:22:18 -0500
title: "Running Rails with Puma and JRuby on Heroku"
category: posts
---

Last post I demonstrated setting up a Ruby on Rails app on Heroku,
running with the [Puma][3] server. As I mentioned before, in order to
get the most out of Puma you should use a Ruby implementation with real
threads like [JRuby][9] or [Rubinius 2][8]. In this post we'll repeat
most of the previous steps, but this time we'll use a Third-Party Buildpack 
and get setup with JRuby.



## Create a new Rails 3.x app with JRuby

_Note: I'm not covering the specifics other than telling you to use [RVM][10] or [rbenv][11] to setup JRuby (I'm running 1.6.7.2)._

First create a new rails app

{% highlight bash %}
~$ jruby -S rails new heroku-jruby-puma
  create 
  ...
~$ cd heroku-jruby-puma
~$ git init
{% endhighlight %}

If you check your Gemfile, you should see some key differences:

- instead of `sqlite3` gem you have `activerecord-jdbcsqlite3-adapter`
- gem `jruby-openssl` included
- `assets` group includes `therubyrhino` gem

## Configure Rails to work with JRuby 

Some adjustments are needed to get this new Rails app to play nice on
Heroku with Puma. First, we can't just use the `pg` gem; You need to use
the `activerecord-jdbcpostgresql-adapter` instead. Add `puma` and set
some configuration variables for Rails and we're set.

**Gemfile**
{% highlight ruby %}
...
gem 'activerecord-jdbcpostgresql-adapter'
gem 'puma'
...
group :development do 
  gem 'foreman'
  gem 'activerecord-jdbcsqlite3-adapter'
end

{% endhighlight %}

_Note: here I left `activerecord-jdbcsqlite3-adapter` in the
`development` group just as an example._


**config/application.rb**
{% highlight ruby %}
...
config.assets.initialize_on_precompile = false

{% endhighlight %}

**config/production.rb**
{% highlight ruby %}
...
config.serve_static_assets = true
...
config.threadsafe!

# Heroku log stuff
STDOUT.sync = true
config.logger = Logger.new(STDOUT)

{% endhighlight %}

## Create Heroku app with JRuby buildpack

Heroku's Cedar stack has no native language or framework; instead your
sever is setup via a set of scripts called [Buildpacks][12]. Heroku
provides buildpacks for Ruby, Node.js, Python and a handful of others,
but you can also create or use your own Buildpack by using the `--buildpack` flag and providing a URL. Here we'll use JRuby's Heroku Buildpack from [github.com/jruby/heroku-buildpack-jruby](BUILDPACK_URL=https://github.com/jruby/heroku-buildpack-jruby.git).

{% highlight bash %}
~$ heroku create heroku-jruby-puma \ 
  --buildpack https://github.com/jruby/heroku-buildpack-jruby.git  

  Creating heroku-jruby-puma ... done, stack is cedar  
  BUILDPACK_URL=https://github.com/jruby/heroku-buildpack-jruby.git
  ...
~$ 
{% endhighlight %}

Now when you push your code up, Heroku's slug compiler knows how to
package things an build them to use JRuby.

## Add a Procfile

As I mentioned last time, a `Procfile` tells Heroku how to run your app:

{% highlight bash %}
web: bin/puma -p $PORT -e $RACK_ENV
{% endhighlight %}

Thats it! Commit your changes and push to Heroku like before:

{% highlight bash %}
~$ git push
  -----> Heroku receiving push
  -----> Fetching custom buildpack... done
  -----> JRuby app detected
  -----> Vendoring JRuby into slug
  -----> Installing dependencies with Bundler
  ...
  -----> Writing config/database.yml to read from DATABASE_URL
  -----> Precompiling assets
  ...
  -----> Discovering process types
       Procfile declares types -> web
  -----> Compiled slug size is 44.5MB
  -----> Launching... done, v7
         http://heroku-jruby-puma.herokuapp.com deployed to Heroku

  To git@heroku.com:heroku-jruby-puma.git
     6bced4f..383a7cc  master -> master
~$ 
{% endhighlight %}

Within a few moments you should be running on JRuby/Puma on Heroku.
Notice that your slug size is significantly larger than a normal stock
Rails app running on MRI. That's because of 4th item you see above,
"Vendoring JRuby into slug". 

Congratulations! You're now running Rails with JRuby and Puma on Heroku.

### See Also:

- [Puma's site](http://puma.io)
- [JRuby Heroku Buildpack](https://github.com/jruby/heroku-buildpack-jruby)
- [Phil Cohen: Improved concurrency for Heroku Dynos](http://coderwall.com/p/eel7na)


[1]: http://heroku.com
[2]: https://devcenter.heroku.com/articles/rails3#webserver
[3]: http://puma.io
[4]: https://devcenter.heroku.com/articles/cedar
[5]: https://devcenter.heroku.com/articles/procfile
[6]: https://github.com/puma/puma
[7]: https://devcenter.heroku.com/articles/third-party-buildpacks
[8]: http://rubini.us
[9]: http://www.jruby.org
[10]: https://rvm.io/
[11]: https://github.com/sstephenson/rbenv
[12]: https://devcenter.heroku.com/articles/buildpacks
