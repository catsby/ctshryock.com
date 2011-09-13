---
layout: default
---

<ul class="unstyled archive">
{% for post in site.categories.posts limit:15 %}
  <li><a href="{{post.url}}" >{{post.title}}</a><span class="post-date-archive">{{post.date | date: "%b %d %Y" }} </span></li>
{% endfor %}
</ul>
