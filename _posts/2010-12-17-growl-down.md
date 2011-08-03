---
layout: post
title: Growl Down
category: posts
---

I was working for a client the other day and needed to get a copy of our staging server database down to my development machine.  So I ssh'd into the server, piped a `mysqldump` into `bzip2` and then proceeded to download the file via `scp`.  The resulting bzip was ~40MB so the download took a couple of minutes; 3 minutes isn't really a long time, but it's too long for me to just stare at a progress bar and wait while there are other things I could be doing.  I thought to myself "I wish this download would send a growl notification when it finished."  

Thus, [Growl Down][1] was born.  Growl Down is a ruby gem that wraps scp/curl on the command line and sends a [Growl][2] notification when the transfer is complete.  

Growl Down is currently in development; I don't have much ruby gem experience, so I'm learning as I go.  I'm hoping for an beta release by years end, but the holidays are always busy so who knows.

[1]: http://github.com/ctshryock/growl-down
[2]: http://growl.info