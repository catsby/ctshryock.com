---
layout: post
date: 2015-02-20
title: "Managing Go versions"
category: posts
tags: Go
---

I've managed to limp through the dependency management ordeal[^ordeal] in Go with 
only minor damage so far. Though my experience isn't extensive, I feel that Go 
has so far done a good job on being backwards compatible. Upgrading from, say 1.3 
to 1.4, typically just works, enough though I've had mismatched versions between 
my local environment and what [Godeps installs on Heroku][1], which went unnoticed 
until just recently. 

Until I got bit. 

More like a *scratch*, but still…

It came time where I needed to practice what I preach and achieve (better) dev/prod parity. I briefly looked into tools like [gvm][2] but wanted to ask around before I installed *yet another thing* to magically solve my problems. After discussing with colleagues, I've adopted the strategy outlined below with minimal pain/adjusting. If you're willing to live dangerously and occasionally blast away your `$GOPATH/pkg` folder[^note], supporting multiple versions in Go can be pretty easy. 

## Prerequisites 

If you haven't read [Getting Started][3] and [How to Write Go Code][4], then why are you here? Go do that. In fact, I wouldn't necessarily come right back here either, maybe bookmark for months later when you feel comfortable enough to muck up your environment with reckless abandon[^note2]. Assuming you followed those guides, you should have Go currently installed in `/usr/local/go`; We're going to delete that.

```bash
$ rm -rf /usr/local/go 
```

*Exciting*, right?

## Environment variables 

In order to get started, we need to review important environment variables that you should already be familiar with. 

- `$GOPATH`: specifies where your workspace is located, e.g.  `$GOPATH/bin`, `$GOPATH/pkg` and `$GOPATH/src`)

- `$GOROOT`: where Go is actually located. Unless specified, Go assumes it lives in `/usr/local/go` (the thing we just deleted). Fortunately you can install Go anywhere you like so long as set the `$GOROOT` environment variable and add `$GOROOT/bin` to your `$PATH`

You need to setup these environment variables yourself, typically in a `~/.bashrc` or a `~/.zshrc` file (or whatever shell you're using), 
and then make sure the relative `bin` folders are added to your `$PATH`:

```bash
# in ~/.zshrc  
export GOPATH=$HOME/Go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin
```

Your environment should be complete now. Nothing should work though.

## Downloading Go versions

The official binary distributions can be found on [golang's site here][5] (this example uses the latest for OS X 10.8+). We'll create a folder in `/usr/local` to store our Go versions, pull some down and extract them to their own folders, and then create a symlink to the one we want to use. For this example, we'll use the latest go 1.3.3 and go 1.4.1:

```bash
$ mkdir -p /usr/local/go-versions/go1.3
$ curl https://storage.googleapis.com/golang/go1.3.3.darwin-386-osx10.8.tar.gz | tar -xz -C /usr/local/go-versions/go1.3 --strip-components=1

$ mkdir -p /usr/local/go-versions/go1.4
$ curl https://storage.googleapis.com/golang/go1.4.1.darwin-386-osx10.8.tar.gz | tar -xz -C /usr/local/go-versions/go1.4 --strip-components=1  
```

Now `/usr/local/go-versions` should have your separate versions in it and look like this:

```bash
$ ls /usr/local/go-versions
go1.3 go1.4
```

## Using a symlink to switch versions

To support multiple versions we'll create a symbolic link where your `$GOROOT` points to. In order to toggle a version, you simply update the symlink at `/usr/local/go` (your `$GOROOT`) to point to the desired version. The initial creation of the link and toggling versions can be done with the same command:

```bash
$ ln -sfn /usr/local/go-versions/go1.4 /usr/local/go
```

This command will create a symbolic link at `/usr/local/go`, pointing to the `/usr/local/go-versions/go1.4` directory, replacing the symlink if it already exists. Now you can toggle back and forth:

```bash
$ ln -sfn /usr/local/go-versions/go1.4 /usr/local/go
$ go version
go version go1.4.1 darwin/386

$ ln -sfn /usr/local/go-versions/go1.3 /usr/local/go
$ go version
go version go1.3.3 darwin/386
```
That's it! Mostly.
## Caveats

Go installs the packaged objects into your `$GOPATH/pkg` folder, and compiled binaries in `$GOPATH/bin`. Not everything you install will place a binary in `bin`, but it will have something in `pkg` that mirrors its source directory. As you probably guessed, these *things* are compiled with the current version of Go. As a result, switching versions could result in undefined behavior. 

The binaries in `$GOPATH/bin` however are statically compiled, meaning they have everything they need to run included in them, and do not depend on anything external at runtime. They should be safe to leave alone. 

When you invoke the `go` tool, it will search the `$GOPATH/pkg` folder to find existing compiled package objects to avoid recompiling them unnecessarily. Because the objects in `$GOPATH/pkg`  are compiled against the version of Go at that the time of compilation, they may not work if you switch versions. 

To get around any potential issues (or resolve them), you can safely destroy your `$GOPATH/pkg` folder (**not** your `$GOROOT/pkg` folder):

```bash
$ rm -r $GOPATH/pkg
```

Future invocations of `go` will reinstall/compile packages as necessary. You will incur the additional overhead of recompiling these things (downloading from the net if needed), but at least you can be assured that they are compiled against the current version of Go that you're using. 

# End

---

Thanks to Ed Muller (@freeformz), Mark Turner (@amerine), Andrew Gwozdziewycz (@apgwoz), and Dane Harrigan (@daneharrigan) for educating me here. 

[1]: https://github.com/heroku/heroku-buildpack-go
[2]: https://github.com/moovweb/gvm
[3]: http://golang.org/doc/install
[4]: http://golang.org/doc/code.html
[5]: https://golang.org/dl/

[^note]: I have no idea how dangerous this is or is not

[^note2]: This shouldn't actually muck anything up

[^ordeal]: That being there is no one standard for dependency management yet in the Go community
