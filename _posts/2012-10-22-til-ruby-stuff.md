---
layout: post
date: 2012-10-22 09:09:11 -0500
title: "TIL: Ruby stuff"
category: posts
---

## . acts as continuation

In Ruby you can chain method calls with `.` 

{% highlight ruby %}
irb:> "a wild string".gsub(/ /, '+').capitalize
=> "A+wild+string"
{% endhighlight %}

But it works for other expressions too

{% highlight ruby %}
x = 6
y = 4

total = x 
  + y

puts "Total: #{total}" #=> 6

total = x
  .+ y

puts "Total redux: #{total}" #=> 10
{% endhighlight %}

Gives you:

{% highlight ruby %}
$❯ ruby fun.rb
Total: 6
Total redux: 10
{% endhighlight %}


## You can use _ for Integers and Floats

{% highlight ruby %}
irb:> int = 1_000  
=> 1000  
irb:> int.class  
=> Fixnum  
irb:> flt = 1_000.00  
=> 1000.0  
irb:> flt.class  
=> Float
{% endhighlight %}

Improves readability of your code
