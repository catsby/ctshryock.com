---
layout: page
title: Web Errors
permalink: web-errors.html 
category: page     
---

A collection of web error/404 messages as I find them

{% for post in site.categories.web-errors %}

<dl>
    <dt><a href="{{post.url}}">{{post.title}}</a></dt>
    <dd class="error-date">{{post.date | date_to_string}}</dd>
    <dd class="error-image">    
        <a href="/static/images/web-errors/{{post.image}}.png">
            <img src="/static/images/web-errors/{{post.image}}_thumb.png" alt="{{post.alt}}" width="540" />  
        </a>
    </dd>
    {% if post.note %}
    <dd class="error-note"> 
        {{post.note}}
    </dd>
    {% endif %}    
</dl>
        
{% endfor %}

Have your own?  Send to web-errors\[at\]ctshryock\[dot\]com 
