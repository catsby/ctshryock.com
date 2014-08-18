---
layout: post
date: 2013-10-16 14:56:14 -0500
title: "Distributing Reads to a Follower on Heroku"
category: posts
tags: ruby, rails, heroku
---

**Using the Octopus gem!**


**TOC**

- [Setup](#setup)
- [Designating Replicated Models](#designating-replicated-models)
- [Credit](#credit)  
- [Conclusion](#conclusion)  

Heroku allows you to easily add horizontal scaling to your application by way of adding additional dynos to meet capacity. Heroku Postgres too allows you to horizontally scale your database by adding [followers][2] to your primary database, streaming write-ahead-logs to each follower, keeping it up to date. While these followers are great for analytical purposes and as hot-standby databases, you can also use them as a part of your application for handling read-only queries[^note] for your data.

You can do this manually with ActiveRecord, establishing the connection to a follower for a given query, but I recommend the [Octopus gem][1]. This gem adds sharding and replication features to ActiveRecord, and in this post I'll add that gem to a Ruby on Rails application to leverage a follower databases, distributing read operations to the follower. Horizontal scaling **ftw** ☜(ﾟヮﾟ☜).

**Prerequisites:**

- Existing Ruby on Rails application on Heroku (so models are setup etc)[^existing]
- A Heroku Postgres production database (Crane +) with a Follower (also Crane +)

## Setup

In a normal Octopus setup you hard code your shard and replication definitions in a file called `config/shards.yml`. Because Heroku advocates [12 Factor applications][5], hardcoding your database information is not going to work. We need a a dynamic `shards.yml` file, as well as an initializer file, specially catered to the Heroku environment. 

Start by adding the Ocotpus gem to your `Gemfile` and running `bundle install`

{% highlight ruby %}
# Gemfile
...
gem 'at-octopus', require: 'octopus'
...
{% endhighlight %}

{% highlight bash %}
$ bundle install
Fetching gem metadata from https://rubygems.org/....
{% endhighlight %}

Next, addd the dynamic `config/shards.yml`:

<script src="https://gist.github.com/catsby/6923840.js"></script>

This dynamically populates the appropriate configurations for Octopus to use your follower(s) for read operations. 

Get the file by running this from your project root: 

{% highlight bash %}
$ wget https://gist.github.com/catsby/6923840/raw/0aaf94ccc383951118c43b9b794fc62e427c2e51/shards.yml config/ 
{% endhighlight %}

Next, add this initializer to `config/initializers`:

<script src="https://gist.github.com/catsby/6923632.js"></script>

The initializer adds some convenience methods like `Octopus.followers` and setups some additional logging. 

Get the file by running this from your project root: 

{% highlight bash %}
$ wget https://gist.github.com/catsby/6923632/raw/87b5abba2e22c3acf8ed35d06e0ab9ca1bd9f0d0/octopus.rb config/initializers/octopus.rb
{% endhighlight %}

Commit those changes in git and test out your setup locally. In development mode Octopus will simulate 2 followers for convenience: 

{% highlight bash %}
$ foreman start
foreman | starting web on port 5000
web     | Puma starting in single mode...
web     | * Version 2.6.0, codename: Pantsuit Party
web     | * Min threads: 5, max threads: 5
web     | * Environment: development
web     | => 2 databases enabled as read-only slaves
web     |   * FOLLOWER 1
web     |   * FOLLOWER 2
{% endhighlight %}

## Designating Replicated Models

With this setup, your followers will not be marked as 'fully replicated'; a fully replicated application will send **all** writes to the primary database, and send **all** reads to followers. This might be A Bad Idea™, depending on your application. Because of this we set `fully_replicated: false` in the dynamic `config/shards.yml`. You have to add a `replicated_model` call to each model you want to be a replicated model, or explicitly query them using methods to have queries sent to your followers. 

{% highlight ruby %}
# app/models/person.rb
class Person < ActiveRecord::Base
  replicated_model
end
{% endhighlight %}

This will configure the `Person` class to be replicated, and read queries will be sent to the follower. 

You can explicitly use a follower as well:

{% highlight bash %}
$ heroku run rails console
Running `rails console` attached to terminal... up, run.2106
=> 1 database enabled as read-only slave
  * PURPLE follower
Loading production environment (Rails 4.0.0)
irb(main):001:0> Octopus.using(:purple_follower) do
irb(main):002:1* Person.first.name
irb(main):003:1> end
=> "Jessica"
irb(main):005:0> Person.using(:purple_follower).pluck(:name)
=> ["Jessica", "Leto", "Paul"]
{% endhighlight %}

(ﾉ^_^)ﾉ Hooray, you're set! You're now distributing reads to a follower database. 

## But wait, there is more

You can choose the followers you want to use for responding to read request with the environment variables `SLAVE_ENABLED_FOLLOWERS` and `SLAVE_DISABLED_FOLLOWERS`. Whitelist followers you want or blacklist the followers you don't want:

{% highlight bash %}
heroku config:add SLAVE_ENABLED_FOLLOWERS=PINK, CRIMSON
heroku config:add SLAVE_DISABLED_FOLLOWERS=COBALT
{% endhighlight %}

**You should do this.**  

Without these variables set, all followers will be used for reads. This may be undesirable for you. One example of usage is when adding an additional follower to a live application, where the above ENV vars are used to ensure the new follower is excluded until it is sufficiently caught up to master for duty. Other people may have forks or just random databases attached to the app. Without a white/black list, those random possibly databases can be used for reads. 

## Conclusion 

Scaling dynos on Heroku is an easy and great way to scale your application, but the scaling doesn't have to stop there. By horizontally scaling your databases, you distribute the workload placed on the primary database and build in resiliency for your application. By using Octopus to handle the connections, you gain some fault tolerance across several followers, and flexibility with which ones to use. 

### Credit

Thanks to [Evan Prothro][9] for writing the original [dynamic shards.yml file][10] and [octopus.rb initializer][11] file, as well as [the original wiki guide for setting up Octopus on Heroku][12] which the blog post is heavily based on. Thanks also to [everyone who has contributed to the Octopus gem](https://github.com/tchandy/octopus/graphs/contributors).

[^existing]: I made one for you: [catsby/distributed-reads][3]  

[^note]: Postgres followers are read-only and cannot be written to.

[1]: https://github.com/tchandy/octopus
[2]: https://devcenter.heroku.com/articles/heroku-postgres-follower-databases
[3]: https://github.com/catsby/distributed-reads
[4]: https://github.com/tchandy/octopus/wiki/Replication-with-Rails-on-Heroku#sql-caching
[5]: https://devcenter.heroku.com/articles/architecting-apps
[6]: https://gist.github.com/catsby/6923840
[7]: https://gist.github.com/catsby/6923632
[8]: https://github.com/tchandy/octopus/wiki/Replication-with-Rails-on-Heroku
[9]: https://github.com/eprothro
[10]: https://gist.github.com/eprothro/5374472
[11]: https://gist.github.com/eprothro/5374500
[12]: https://github.com/tchandy/octopus/wiki/Replication-with-Rails-on-Heroku


