---
layout: post
date: 2012-07-12 22:26:13 -0500
title: "Running Rails with Puma on Heroku"
category: posts
---

I've been playing around with [Heroku][1] a lot lately and noticed they
recommend using [Thin][2] for your production server when running Rails. In recent months
I've grown attached to [Puma][3] (for no qualified reasons) and wanted to see if
I can get a Rails app running on Heroku's [cedar stack][4] with Puma instead. It
turned out to be really, really simple.


## Create a new Rails 3.x app

First create a new rails app, heroku app, and initialize a git repo:

    ~$ rails new heroku-puma
      create 
      ...
    ~$ cd heroku-puma
    ~$ heroku create
      Creating high-day-4093... done, stack is cedar
      http://high-day-4093.herokuapp.com/ | git@heroku.com:high-day-4093.git
    ~$ git init
    ~$ git remote add heroku git@heroku.com:high-day-4093.git
  

Launch your favorite editor and make some standard adjustments in your
`Gemfile`, just as a demonstration:

    ...
    gem 'sqlite3'
    ...

becomes
  
    ...
    gem 'thin'
    ...

## Deploy with Thin, just for fun

Back in the terminal, add your files to the git repo and make your first
commit, then push it up to Heroku:

    ~$ git add .
    ~$ git commit -m "Initial import, using Thin server"
    ~$ git push heroku master
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

Now that your app is launched, do a quick `curl` call and confirm it's
on Thin:

    ~$ curl -I http://high-day-4093.herokuapp.com
      HTTP/1.1 200 OK
      Age: 0
      Content-length: 5906
      Content-Type: text/html
      Date: Fri, 13 Jul 2012 03:43:03 GMT
      Last-Modified: Fri, 13 Jul 2012 03:38:05 GMT
      Server: thin 1.4.1 codename Chromeo
      X-Content-Digest: 34cbb711a4537e1ca1cd2f20cc632c4e6e899b4d
      X-Rack-Cache: stale, valid, store
      Connection: keep-alive

Hooray, we're running Thin! Except, we want to run Puma...


## Puma and the Procfile

Cedar introduced a new way to think about scaling your app; "the process model". It's a generalized approach to managing processes across Heroku's distributed environment, allowing you to tweak how and what gets run via a [Procfile][5]. Here we'll create a simple `Procfile` and tell our app to run with Puma instead of Thin.

First, swap out Thin for Puma in your `Gemfile`:

    ...
    gem 'puma'
    ...

Then add a file named `Procfile` to the root of your project and add the following:

    web: bundle exec rails server puma -p $PORT -e $RACK_ENV
    
Those are the instructions Heroku will use to run your `web` process.
Making sure to add the new `Procfile` to your repo, commit your changes
and push to Heroku again:

    ~$ git add Procfile
    ~$ git add Gemfile
    ~$ git commit -m "Use Puma via a Procfile"
    ~$ git push heroku master
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

Now we run our `curl` command again:

    ~$ curl -I http://high-day-4093.herokuapp.com
      HTTP/1.1 200 OK
      Age: 0
      Content-length: 5906
      Content-Type: text/html
      Date: Fri, 13 Jul 2012 03:53:30 GMT
      Last-Modified: Fri, 13 Jul 2012 03:50:57 GMT
      X-Content-Digest: 34cbb711a4537e1ca1cd2f20cc632c4e6e899b4d
      X-Rack-Cache: stale, valid, store
      Connection: keep-alive

Horray, we're not running Thin! Except it doesn't say we're running Puma
either... I suppose Puma doesn't report itself like Thin and WEBrick do. 

Now if you run `heroku ps` you should see you have 1 web dyno running,
and the statement used to run it:

    ~$ heroku ps
      === web: `bundle exec rails server puma -p $PORT -e $RACK_ENV`
      web.1: up for 2m

Congratulations, you're running Puma! Note that Puma is said to really
shine with Rubinius and JRuby where it can utilize multiple threads.
Still, it should give you some benefites on MRI as well. Checkout
[puma.io][3] and [github.com/puma/puma][6] for more info.

[1]: http://heroku.com
[2]: https://devcenter.heroku.com/articles/rails3#webserver
[3]: http://puma.io
[4]: https://devcenter.heroku.com/articles/cedar
[5]: https://devcenter.heroku.com/articles/procfile
[6]: https://github.com/puma/puma
