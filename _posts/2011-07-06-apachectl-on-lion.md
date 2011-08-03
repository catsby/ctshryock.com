---
layout: post
date: 2011-07-06 08:33:17 -0500
title: "Apachectl on Lion"
published: false
category: posts
---


Must edit `/System/Library/LauchDaemons/org.apache.httpd.plist`

File should read:

    <plist version="1.0">
    <dict>
      <key>Disabled</key>
      <true/>
      <key>Label</key>
      <string>org.apache.httpd</string>
      <key>OnDemand</key>
      <false/>
      <key>ProgramArguments</key>
      <array>
        <string>/usr/sbin/httpd</string>
        <string>-D</string>
        <string>FOREGROUND</string>
        <string>-D</string>
        <string>WEBSHARING_ON</string>
      </array>
      <key>SHAuthorizationRight</key>
      <string>system.preferences</string>
    </dict>
    </plist>


Then re-load the plist via `launchctl`

{% highlight bash %}
  $ sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist
  $ sudo launchctl load -w /System/Library/LaunchDaemons/org.apache.httpd.plist
{% endhighlight %}
