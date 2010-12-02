---
layout: default
image: magic_tree.JPG
---

##@ctshryock

<img id="main-image" src="/images/{{page.image}}" width="560"  />

> Rudolf is a terrible story to tell kids.  This poor reindeer tries to change himself to fit in but he fails, and everyone still hates and mocks the guy.  Then all of a sudden they're in a tight spot and he's useful so they all love him?

###Posts
{% for post in site.posts limit:5 %}
<dl class="post">
    <dd class="post-image">
        {% if post.image %}
        <img width="50" src="/images/{{post.image}}" />
        {% else %}
        <img width="50" src="/images/self.JPG" />
        {% endif %}            
    </dd>
    <dt class="post-title">
        <a href="{{post.url}}">{{post.title}}</a>
    </dt>
    <dd class="post-date">
        {{post.date | date_to_string}}
    </dd>
</dl>
{% endfor %}