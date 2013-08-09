---
layout: post
title: "Dive into Elixir"
category: posts
date: 2013-08-09
tags: elixir
---

------

I've been learning Elixir lately, and so far it's been *fascinating*.
Elixir is a functional programming language with a very ruby-like
syntax. You get immutable state, actor-based concurrency model, and a
modern syntax, all running on the [Erlang VM][1]. It's my
first foray into functional programming, and I'm enjoying learning the
differences between OOP. 

This post will get Elixir installed and
introduce you to two important parts of Elixir: **Immutable Data** and
**Pattern Matching**.

------

## Getting rolling

Start your dive by installing Elixir. You need at least Erlang R16bB.
Don't worry what that is, just install a precompiled version [from
here][2]. Next, install Elixir. There are [packages here][3], but you
should roll with Elixir from the master branch of the repo for now
(Elixir gets a little better every day):

{% highlight bash %}
$ brew install --HEAD elixir
==> Cloning https://github.com/elixir-lang/elixir.git
Updating /Library/Caches/Homebrew/elixir--git
==> make
🍺  /Users/clint/Developer/Cellar/elixir/HEAD: 278 files, 3.3M...
$
{% endhighlight %}

Now you can use interactive mode and start learning:

{% highlight elixir %}
$ iex
Interactive Elixir (0.10.2-dev)...
iex(1)> 1 + 12
13
iex(2)> dog_name = "Nero Dog, II"
"Nero Dog, II"
iex(3)> String.length dog_name
12
{% endhighlight %}

Press `control+c` and then `a` to get out of that. Interactive mode
keeps a count of the commands you've ran in that session (the `(1)` and
`(2)`). At 1,000 you earn a badge and get a cookie! [^note]


Now that you're up and running, let's look at some Elixir basics. 

------  

## Immutable Data

Everything in Elixir is immutable. You can't append to a list; you can
only get a new list with those additional items included in it. You cannot increment a
value; you can only get a new value returned. Elixir is all about
*transforming data*. Here we think about data and what we're doing to
and with it; we're not thinking about instances, inheritance, state, or
encapsulation.

Let's look at variable binding, a thing that looks a lot
like normal assignment. It's not. For example:

{% highlight ruby %}
# ruby
>> numbers = [1,2,3]
=> [1, 2, 3]
{% endhighlight %}

With assignment (in most OOP languages), the variable `numbers` is an **object** and 
references an array of `[1,2,3]`. 

{% highlight elixir %}
# Elixir
iex(1)> numbers = [1,2,3]
[1, 2, 3]
{% endhighlight %}

In Elixir, the variable `numbers` is now bound to `[1,2,3]` (which is a List in Elixir, not an array). Outwardly the
same, but a very different thing happened. Binding is more like a
assertion, or a question, "can this statement be made true?". If you think of 
it more as an assertion, then this makes perfect sense:

{% highlight elixir linenos %}
# Elixir
iex(2)> a = 1
1
iex(3)> 1 = a
1
iex(4)> 2 = a
** (MatchError) no match of right hand side value: 1
    :erl_eval.expr/3

{% endhighlight%} 

Doing so in Ruby will throw a syntax error. Take note of line 6; this
yields an error because `a` is bound to `1`, and Elixir can't make `2`
equal to `1` (Elixir will only change the binding of the variable on the
left side).  No *match* for `a` could be found, so the assertion fails. Try 
thinking "can the left hand side be made to match the
right hand side?", and then the `=` assignment operator becomes a **matching**
operator. 

Immutable data is great because you never have to worry about someone else changing something 
from under your feet. When you get a block of data, that's what you get. Not a shared reference to something, 
you never have to worry about someone else (say another thread of execution) changing that *thing* you have; they 
may change something similar, but not *your* thing. Your thought process and concerns become more local, only worrying about 
what you're doing in that particular function with that particular data. 

------

## Pattern matching

Pattern matching is the process where Elixir binds values to variables,
but not your conventional "assignment". It's a fundamental part of
programming here. In the above example with `a = 1` and `1 = a` you saw
the very basics of pattern matching: attempting to make the thing on the left match
the thing on the right. 

Some further examples, with lists (*not* arrays):

{% highlight elixir linenos %}
iex(6)> animals = ['dog', 'cat', 'chocobo']
['dog', 'cat', 'chocobo']
iex(7)> [friend, enemy, awesome_bird] = animals
['dog', 'cat', 'chocobo']
iex(8)> friend
'dog'
iex(9)> enemy
'cat'
iex(10)> awesome_bird
'chocobo'
iex(11)>

{% endhighlight %}

On line `1` we make a list of 3 animals, and on line `3` we match that
list with a new list, `[friend, enemy, awesome_bird]`.  You can then
reference each individually. 

Look what happens when we try to use the same variable: 

{% highlight elixir linenos %}
iex(11)> [d, c, c] = animals
** (MatchError) no match of right hand side value: ['dog', 'cat', 'chocobo']
    :erl_eval.expr/3
{% endhighlight %}

In something like Ruby `c` would simply get assigned (bound) twice
and end up as `chocobo`. In Elixir, we're matching patterns, and the `c`
variable tries to match both `cat` and `chocobo`, but can't. As a
result, the matching fails. 

Another example:

{% highlight elixir linenos %}
iex(1)> [dog, name, dog] = ["Nero", "Adelbert Steiner", "Nero"]
["Nero", "Adelbert Steiner", "Nero"]
iex(2)> dog
"Nero"
iex(3)> name
"Adelbert Steiner"
{% endhighlight %}

Here, `dog` matches up with `Nero` in the first and third position,
allowing `name` to become whatever it needs to 
in order for the match to succeed. 

Back to the `['dog', 'cat', 'chocobo']` example, maybe you're like me and you don't actually care about cats. Elixir can
help with a wildcard matcher, the **underscore**:

{% highlight elixir linenos %}
iex(12)> [d,_,c] = ['dog', 'cat', 'chocobo']
['dog', 'cat', 'chocobo']
iex(13)> d
'dog'
iex(14)> c
'chocobo'
iex(15)> _
** (ErlangError) erlang error: {:unbound_var, :_}
    :erl_eval.exprs/2
{% endhighlight %}

On line 7 we get an error when trying to reference `_`, that's because
Elixir will match anything there and immediately discard it.

------

That's all for now. Go install Elixir if you haven't already and try out
some pattern matching to get a feel for it. Immutable data and pattern
matching are important parts of the things I'll cover in my next *Dive
Into* post covering functions, anonymous functions, and recursive functions.

If you like what you've seen, go pick up [Programming Elixir][4] from Dave 
Thomas at The Pragmatic Bookshelf. 

------
[^note]: no, not really

[1]: https://en.wikipedia.org/wiki/Erlang_(programming_language)
[2]: https://www.erlang-solutions.com/downloads/download-erlang-otp
[3]: http://elixir-lang.org/getting_started/1.html
[4]: http://pragprog.com/book/elixir/programming-elixir

