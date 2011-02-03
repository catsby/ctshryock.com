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

<!--

<dl>
    <dt>Github.com 500</dt>
    <dd class="error-date">January 17th, 2011</dd>
    <dd class="error-image">    
        <a href="http://ctshryock.com/static/images/web-errors/github_500_full.png">
            <img src="http://ctshryock.com/static/images/web-errors/github_500.png" alt="Github 500" title="Road Runner Style" width="540" />  
        </a>
    </dd>
</dl>
<dl>
    <dt>Apple Support 404</dt>
    <dd class="error-date">January 6th, 2011</dd>
    <dd class="error-image">    
        <a href="http://ctshryock.com/static/images/web-errors/apple-support-404-full.png">
            <img src="http://ctshryock.com/static/images/web-errors/apple-support-404.png" alt="Apple Support" title="No support for you" width="540" />  
        </a>
    </dd>
</dl>
<dl>
    <dt>Github 404</dt>
    <dd class="error-date">January 3rd, 2011</dd>
    <dd class="error-image">    
        <a href="http://ctshryock.com/static/images/web-errors/github-404-full.png">
            <img src="http://ctshryock.com/static/images/web-errors/github-404.png" alt="Github repository not found" title="Github is not the 404 you're looking for" width="540" />  
        </a>
        <span class="error-note">Move your mouse around the image on <a href="https://github.com/ctsh">an error page</a></span>
    </dd>
</dl>                                        
<dl>
    <dt>Hoptoad hopped the toad</dt>
    <dd class="error-date">December 21st, 2010</dd>
    <dd class="error-image">    
        <a href="http://ctshryock.com/static/images/web-errors/hoptoad.png">
            <img src="http://ctshryock.com/static/images/web-errors/hoptoad.png" alt="Hoptoad" title="Hoptoad hopped the toad" width="540" />  
        </a>
    </dd>
</dl>                                                                                                              
<dl>
    <dt>Octocat is terrified</dt>
    <dd class="error-date">December 21st, 2010</dd>
    <dd class="error-image">
        <a href="http://ctshryock.com/static/images/web-errors/jobs.github.png">
            <img src="http://ctshryock.com/static/images/web-errors/jobs.github.png" alt="Jobs.Github" title="Octocat is terrified" width="540" />      
        </a>
    </dd>
</dl>  

 -->

Have your own?  Send to web-errors\[at\]ctshryock\[dot\]com 
