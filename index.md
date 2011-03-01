---
layout: default
---

##@ctshryock

My name is Clint Shryock.  I develop software in Ruby, PHP, and Cocoa.  
I live in central Missouri, where the weather is beautiful 4 months of the year.

<ul>
{% for post in site.posts %}
    {% if post.category != 'page' and post.category != 'web-errors' %}
        <li><a href="{{post.url}}">{{post.title}}</a><span class="post-date-archive">{{post.date | date_to_string}} </span></li>
    {% endif %}
{% endfor %}
</ul>