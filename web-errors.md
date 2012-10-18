---
layout: default
title: Web Errors
---

A collection of web error/404 messages as I find them

<ul class="thumbnails">
{% for post in site.categories.web-errors %}
  <li class="span2">
    <a href="{{post.url}}">
      <img src="/static/images/web-errors/{{post.image}}_thumb.png" width="160">
    </a>
  </li>
        
{% endfor %}

</ul>

<div id="a-call-for-errors">
  Have your own?  Send to web-errors at ctshryock dot com 
</div>
