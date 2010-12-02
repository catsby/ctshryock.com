--- 
layout: post
title: Getting acquainted with Cinderella
date: 2010-09-18 13:57:12 -05:00
mt_id: 44
---
For over 3 years I've used [MacPorts][1] to setup my development environment on Mac OS X, but with a recent reformat, I decided to forego `port` in favor of `brew`.  I've switched to [Homebrew][3] for my package management, and I've gone with [Cinderella][3] specifically for web development.

Cinderella was appealing for a few reasons, mainly I got quite a few awesome tools such as node, redis, memcached and mondodb, while following the lead of Homebrew and using the existing tools I already had on a stock MacBook Pro, such as apache and php.  

<strike>I immediately took issue with one thing though; Cinderella starts all of these services as Launchd items in `~/Library/LaunchAgents` with the `RunAtLoad` and `KeepAlive` options set.  I wouldn't mind if this was a workstation, but it's my laptop and I don't always want those things running in the background</strike> 
__UPDATE: I made a ticket on the projects home and the developer responded back with a good point; it's better to have it "just work" than muddy it with configuration options.  That said, I no longer take issue with with RunAtLoad option.__

Easy enough to change though, just edit the files in `~/Library/LaunchAgents` and turn those keys to `false` and restart your machine and you'll be fine.  Note that updating Cinderella will revert these changes, so until that's a configuration option you'll have to reset it each time.

Cinderella sets up PostgreSQL and MySQL for you, but postgres is ran as your normal user, instead of a `postgres` user like MacPorts.  This was actually a relief to me.  Maybe that's not "the way it should be", but this is a dev environment not production.  I did however miss that this meant the default user was also gone... so `psql -U postgres` was returning a fatal error because the role `postgres` didn't exist.  Cinderella actually creates a default user of your own username, so <code>psql -U `whoami`</code> will log you in, and if you're like me, you can then create your default user and feel right at home.  

[Cinderella is under development and hosted on Github][4], so head over there and get some hardcore forking action 

[1]: http://www.macports.org/ 
[2]: http://www.atmos.org/cinderella/intro.html
[3]: http://github.com/mxcl/homebrew
[4]: http://github.com/atmos/cinderella 
