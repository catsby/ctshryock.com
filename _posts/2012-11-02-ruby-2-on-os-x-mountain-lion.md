---
layout: post
date: 2012-11-02 08:49:59 -0500
title: "Ruby 2 on OS X Mountain Lion"
category: posts
---

<blockquote class="twitter-tweet tw-align-center"><p>Ruby 2.0.0-preview1 is out “@<a href="https://twitter.com/mametter">mametter</a>: ruby 2.0.0-preview1 をリリースしました <a href="http://t.co/VdlK7sGJ" title="http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-dev/46348">blade.nagaokaut.ac.jp/cgi-bin/scat.r…</a>”</p>&mdash; Aaron Patterson (@tenderlove) <a href="https://twitter.com/tenderlove/status/264168009063612416" data-datetime="2012-11-02T00:52:16+00:00">November 2, 2012</a></blockquote>
<script src="//platform.twitter.com/widgets.js" charset="utf-8"></script>


Ruby 2.0 preview 1 is out! If you're like me you want to try out the new
shiny stuff before it's all done, you can install it now easily with
[rbenv][1] and [Homebrew][2].

##Warning

My first attempts at installing failed (quietly). Things seemed to
work, but I found this in the `configure` output:

<blockquote class="twitter-tweet tw-align-center"><p>Noticed this while compiling:"Ignore OpenSSL broken by Apple.Please use another openssl."ಠ_ಠ</p>&mdash; Clint Shryock (@ctshryock) <a href="https://twitter.com/ctshryock/status/264188599262670849" data-datetime="2012-11-02T02:14:05+00:00">November 2, 2012</a></blockquote>

OS X ships with an older version of OpenSSL. Even in Mountain Lion.
Homebrew makes it easy to install a new version, but does so cautiously;
after you install OpenSSL, Homebrew displays a message detailing that it
did not automatically link it. I chose to link it, but as a result I
went and recompiled all of my rubies with rbenv and the new OpenSSL. You may or may not need
to do this. It may or may not break other things. **Be warned**.

## Installing

I assuming you're using **rbenv**, **Homebrew**, and an updated
**OpenSSL**.

1. Download and extract the preview release: 
   [ruby-2.0.0-preview1.tar.bz2][3]
2. With your favorite shell, navigate to the extracted folder and
   `configure` -> `make` -> `make install`. You need to set the
   `--prefix` flag to install it along your other **rbenv** rubies:
    <pre><code>~❯ cd ~/Downloads/ruby-2.0.0-preview1  
    ruby-2.0.0-preview1 ❯ ./configure --prefix=$HOME/.rbenv/versions/2.0.0-pre1  
    checking build system type... x86_64-apple-darwin12.2.0
    ...
    ...
    config.status: creating ruby-2.0.pc
    ruby-2.0.0-preview1 ❯ make
    ...
    ...
    Elapsed: 0.1s
    ruby-2.0.0-preview1 ❯ make install
    ...
    ...
    ruby-2.0.0-preview1 ❯</code></pre>
3. **$\$\$ Profit $$$**


You can now use Ruby 2.0 via **rbenv**:

    ruby-2.0.0-preview1 ❯ rbenv local 2.0.0-pre1 
    ruby-2.0.0-preview1 ❯ ruby -v
    ruby 2.0.0dev (2012-11-01) [x86_64-darwin12.2.0]

**Done.** [Have fun storming the castle.][4]

[1]: https://github.com/sstephenson/rbenv
[2]: https://github.com/mxcl/homebrew 
[3]: http://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-preview1.tar.bz2
[4]: http://youtu.be/J-3VxOqHI-4
