---
layout: post
date: 2013-07-02
title: "Running Elixir Dynamo on Heroku"
category: posts
---

<blockquote>"Elixir is a functional meta-programming aware language built
on top of the Erlang VM. It is a dynamic language with flexible syntax
with macros support that leverages Erlang's abilities to build
concurrent, distributed, fault-tolerant applications with hot code
upgrades." - from http://elixir-lang.org </blockquote>

[Elixir][1] is a new *ruby-like* language created by [Jose Valim][2], built on
top of the Erlang VM. It's caught my interest for a while now, but until
recently has been too young for me to dive in much.

[Dynamo][3] is a web framework written and running on Elixir. Dynamo goals are 
performance, robustness and simplicity. 

Naturally, I went about trying Dynamo out and wanted to get it running
on Heroku, which proved to be pretty easy. We start by installing
Elixir, checking out the Dynamo rep, and generating a project. From there we use the
Elixir third-party buildpack[^elixir] and things should fall into place nicely.

### Installing Elixir

The easiest way to install Elixir is with
[Homebrew][4]. With each new Elixir release, Jose submits an updated
formula for Elixir, which makes staying up to date easy.

Assuming you have Homebrew install:

    $ brew install elixir
    ==> Downloading https://github.com/elixir-lang/elixir/archive/v0.9.3.tar.gz 
    ==> make
    /Users/clint/Developer/Cellar/elixir/0.9.3: 273 files, 3.2M, built in 35 seconds
    $

Dynamo requires rebar[^note] to compile things, and Elixir makes it easy
to install with the included `mix` build tool:

    $ mix local.rebar
    * creating /Users/clint/.mix/rebar
    $

**Done!**

### Installing Dynamo

Dynamo, like Elixir, is alpha at this stage, so installation is pretty
manual :/

Start by cloning [the repository][3] and getting the dependencies:

    $ git clone git@github.com:elixir-lang/dynamo.git
    Cloning into 'dynamo'...
    remote: Counting objects:
    ...
    Resolving deltas: 100% (2016/2016), done.
    $ cd dynamo
    $ MIX_ENV=test mix do deps.get, test
    
Now create a new project:

    $ mix dynamo path/to/new/project
    
**Done!** You now have a new Dynamo project template at
`path/to/new/project`. Change to that directory, get your
dependencies, and start the server:

    $ cd path/to/new/project
    $ mix deps.get
    * Getting dynamo [git: "git://github.com/elixir-lang/dynamo.git"]
    [...]
    * Getting cowboy [git: "git://github.com/extend/cowboy.git"]
    [...]
    * Compiling dynamo
    $ mix server
    Running DynamoExample.Dynamo at http://localhost:4000 with Cowboy on dev

**Done!**. Visit [http://localhost:4000](http://localhost:4000) to see your running Dynamo app!
Type `cntrl+c` and then `a` to abort the server and get back to your
shell. 

## Setup the Heroku app

In order to run Elixir on Heroku, you need to utilize Heroku's awesome
[third party
buildpacks](https://devcenter.heroku.com/articles/third-party-buildpacks)
feature by setting a custom `BUILDPACK_URL` environment variable. 
From the project directory, create a new Heroku app and specify the buildpack:

    $ heroku create --buildpack "https://github.com/goshakkk/heroku-buildpack-elixir.git" [app_name]

If you already have a Heroku app created, you can just set the `BUILDPACK_URL` config var:

    $ heroku config:add BUILDPACK_URL="https://github.com/goshakkk/heroku-buildpack-elixir.git" -a YOUR_APP

### Specify Erlang/OTP and Elixir versions

The Elixir buildpack allows you to specify different Erlang versions,
but Elixir requires Erlang/OTP version R15 or greater. Specify a preferred Erlang/OTP version for the buildpack by creating a `.preferred_otp_version`:  

    $ echo "OTP_R16B" > .preferred_otp_version
  
By default, the Elixir buildpack uses the master branch version of Elixir. You can specify a custom branch or tag name from the https://github.com/elixir-lang/elixir repository in the `.preferred_elixir_version` dotfile:

    $ echo "master" > .preferred_elixir_version

### Setup a Procfile

Heroku needs a Procfile in order to run your application. Create a Procfile with a `web` process defined:

    $ echo 'web: MIX_ENV=prod mix server -p $PORT' > Procfile
    
**Important Note:** Single quotes are important here. `$PORT` is an environment variable supplied by Heroku. If you use double quotes 
in the above `echo` call, your local shell will try to interpolate the contents, and you'll end up with `-p ` and not `-p $PORT`. 
    
### Deploy

Add and commit your changes, then push to Heroku:

    $ git add Procfile .preferred_otp_version .preferred_elixir_version  
    $ git commit -m "Setup for Heroku"  
    $ git push heroku [[master]-----> Fetching custom git buildpack... done
    -----> Elixir app detected
    -----> Using Erlang/OTP OTP_R16B
    [..]
    
    -----> Installing Rebar from buildpack
    -----> Using Elixir master
    [...]
       Compiled lib/dynamo_example/dynamo.ex
       Compiled web/routers/application_router.ex
       Generated DynamoExample.Dynamo.CompiledTemplates
       Generated dynamo_example.app
    -----> Discovering process types
           Procfile declares types -> web

    -----> Compiled slug size: 52.7MB
    -----> Launching... done, v6
           http://dynamo-example.herokuapp.com deployed to Heroku


**Done!**

You now have a working Dynamo app on Heroku!


### What's next?

No idea. Elixir and Dynamo are both really young. While a native
database interface is planned, there's nothing out at the time of this
writing. Personal attemps to use
[BossDB](https://github.com/evanmiller/boss_db) have failed. If I get it
working, I'll update here. Until then, get hacking.





[^note]: [Rebar][5] is a build-tool for Erlang projects, from the folks at [Basho][6].
[^elixir]: [https://github.com/goshakkk/heroku-buildpack-elixir](https://github.com/goshakkk/heroku-buildpack-elixir)

[1]: http://elixir-lang.org
[2]: https://twitter.com/josevalim
[3]: https://github.com/elixir-lang/dynamo
[4]: http://brew.sh
[5]: https://github.com/basho/rebar 
[6]: http://basho.com
