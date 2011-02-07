---
layout: page
title: Web Errors
permalink: web-errors/index.html 
category: page     
---

A collection of web error/404 messages as I find them

{% for error in site.categories.web-errors %}

<dl>
    <dt>{{error.title}}</dt>
    <dd class="error-date">{{error.date | date_to_string}}</dd>
    <dd class="error-image">    
        <a href="/static/images/web-errors/{{error.image}}.png">
            <img src="/static/images/web-errors/{{error.image}}_thumb.png" alt="{{error.alt}}" width="540" />  
        </a>
    </dd>
</dl>
        
{% endfor %}

Have your own?  Send to web-errors\[at\]ctshryock\[dot\]com 
