---
layout: archive
permalink: archive.html
title: Archive
category: archive
---

<ul class="unstyled archive">
{% for post in site.categories.posts %}
  <li><a href="{{post.url}}">{{post.title}}</a><span class="post-date-archive">{{post.date | date_to_string}} </span></li>
{% endfor %}
</ul>
