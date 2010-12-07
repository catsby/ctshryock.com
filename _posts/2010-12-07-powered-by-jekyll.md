---
title: Powered by Jekyll
layout: post
---

The team took a trip to San Francisco the first weekend of December so I took advantage of the time spent waiting in the airport to migrate my site from [Movable Type][1] to [Jekyll][2].  Although I was always happy with MT, I had started looking into Jekyll simply to understand how [Github Pages][3] works, and became attached to it's simplicity while still covering all of my needs for my personal site.  This all seemed to happen at the same time I was re-imagining the purpose of this site.  

##purpose
So what is the purpose of this site?  I started to question why I had a site, at least, why am I using a blog engine that acts as a blog and a site, instead of a site that happens to have a blog.  My end goal is to have a presence on the internet; a personal "home" for my doings.  I still want to write things, but more and more my writings are small snippets, links, or comments &mdash; not full out POSTS.  I've started using [FeedBurner][7] to see if people even _subscribe_ to it in the first place.  

So a blog is not the focus of this site.  Information about me and my projects are.  I re-organized the homepage to be a simple "about" page.  I figured most visitors are coming from [Twitter][4] or [Github][5], wanting to learn more about me or a specific project of mine.  Landing on the homepage for a series of posts (which were all pretty small on average) is more of an obstruction to that goal.  


##why Jekyll
Movable Type appealed to me at first because I liked the idea of publishing static files instead of dynamically generating the page each request.  MT offers quite a bit of flexibility too, first being [open source][6], second, the admin area lets you tweak and adjust things to your hearts content.  I was able to choose from a variety of themes online and tweak it to my likings; this is a common thing among OSS blog engines out there.  

So things were good, for a time.  But times change, and I wanted to change, so I started tweaking my site some.  Originally I had widgets on every page: a tag cloud, archives broken down by month, latest posts, and my pages.  I guess at the time I thought those things were "cool" or useful, but as I saw them on other sites I began to despise some of them.  I don't care for the idea of tag clouds or archives by month really.  So I wanted to rip those out of my site, but having not tinkered with my layout and templates in some time, I couldn't figure out how to accomplish this.  That is to say after half an hour I gave up.  

I started thinking that this was not "my" site... it's the site that MT gave me based on some input and a lot of things assumed or done for me.  I visit the server (via the admin), write a post or setup a page, and ask it kindly to generate some html and place it in the public folder.  

I also thought it all overkill.  My pages don't change often, and my writings are small and infrequent.  For this I had to setup:

- cgi on my webserver
- a database with user and permissions
- MT code in the cgi-bin folder with the correct config information
- run the install file via visiting a special url
- maintain MT with updates
- edit and publish static css on my own
- edit and publish templates via the admin interface

"Too much" I said!  Jekyll is simpler and for my use cases faster.  It lacks much of what [Wordpress][8] or MT provide, but much of that I don't care for or need anyway.  


##conclusion

[1]: http://www.movabletype.org/
[2]: https://github.com/mojombo/jekyll
[3]: http://pages.github.com/
[4]: http://twitter.com/ctshryock
[5]: http://github.com/ctshryock
[6]: http://www.movabletype.org/opensource
[7]: http://feedburner.google.com
[8]: http://wordpress.org