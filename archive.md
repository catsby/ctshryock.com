---
layout: default
permalink: archive.html
title: Archive
category: archive
---

<table>
{% for post in site.categories.posts %}
  <tr><td class="span7"><a href="{{post.url}}">{{post.title}}</a></td><td>{{post.date | date_to_string}} </td></tr>
{% endfor %}
</table>
