---
layout: post
date: 2012-12-21 08:37:31 -0600
title: "TIL: Ruby stuff II"
category: posts
---

Continuing adventures in [The Ruby Porgramming Language][1]

### I see you

Ruby doesn't like when you use variables or methods that aren't defined:

    Ruby ❯ irb
    irb(main):001:0> a 
    NameError: undefined local variable or method `a' for main:Object  
      from (irb):2  
      from /Users/clint/.rbenv/versions/1.9.3-dev/bin/irb:12:in `<main>'

Makes sense – `a` doesn't exist. However, if the interpreter has at
least _seen_ `a`, things will be different:

    Ruby ❯ irb
    irb(main):003:0> if false
    irb(main):004:1> a = true
    irb(main):005:1> end
    => nil
    irb(main):006:0> a
    => nil

Above, `a` is never assigned, but it's still seen by the interpreter, so
it still exists in some way.


[1]: http://shop.oreilly.com/product/9780596516178.do
