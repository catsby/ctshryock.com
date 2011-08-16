---
layout: default
title: Web Errors
---

A collection of web error/404 messages as I find them

{% for post in site.categories.web-errors %}

<dl class="error-grid">
    <dt><a href="{{post.url}}">{{post.title}}</a></dt>
    <dd class="error-date">{{post.date | date_to_string}}</dd>
    <dd class="error-image">    {{forloop.rindex0}}
        <a href="/static/images/web-errors/{{post.image}}.png" title="{{post.alt}}">
            <img src="/static/images/web-errors/{{post.image}}_thumb.png" alt="{{post.alt}}" width="200" />  
        </a>
    </dd>
</dl>
        
{% endfor %}


<div id="a-call-for-errors">
  Have your own?  Send to web-errors at ctshryock dot com 
</div>
