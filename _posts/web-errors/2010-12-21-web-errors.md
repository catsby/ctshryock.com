---
layout: page
title: Web Errors
permalink: web-errors/index.html 
category: page     
---

A collection of web error/404 messages as I find them

{% for page in site.categories.web-errors %}

<dl>
    <dt>{{page.title}}</dt>
    <dd class="error-date">{{page.date | date_to_string}}</dd>
    <dd class="error-image">    
        <a href="/static/images/web-errors/{{page.image}}.png">
            <img src="/static/images/web-errors/{{page.image}}_thumb.png" alt="{{page.alt}}" width="540" />  
        </a>
    </dd>
    {% if page.note %}
    <dd class="error-note"> 
        {{page.note}}
    </dd>
    {% endif %}    
</dl>
        
{% endfor %}

Have your own?  Send to web-errors\[at\]ctshryock\[dot\]com 
