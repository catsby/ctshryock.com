---
layout: archive
permalink: archive.html
title: Archive
category: archive
---

<ul class="clean-list">
{% for post in site.posts %}
  <li><a href="{{post.url}}">{{post.title}}</a><span class="post-date-archive">{{post.date | date_to_string}} </span></li>
{% endfor %}
</ul>
