---
layout: post
date: 2012-03-13 14:38:52 -0500
title: "Be helpful; Don't be helpful"
category: posts
---

You can often find me lurking on IRC in #github. It's taken me some time but
I've built up a lot of good git knowledge and experience and I enjoy
being able to help people out now and again.

It bugs the hell out of me when I see things like this:

    [2:42pm] PersonWithQuestion: Why its not pulling? [pastie link]
    [2:43pm] PersonWithQuestion: 1) From my laptop its pushed to github.com 2) In RHEL i am now pulling the latest and it gives me that above failure.
    [2:45pm] ctshryock: PersonWithQuestion: Theres a change in that file on REHL
    [2:46pm] PersonWithQuestion: ctshryock, its old one (git clone only)
    [2:48pm] PersonWithQuestion: REHL is only downloader, wont ever commit anything just for upto date purpose.
    [2:48pm] ctshryock: run `git status` on REHL
    [2:50pm] PersonWithQuestion: [pastie link]    its saying to commit but i do not want it commit anything it will be tricky/risky. Is there a way to tell force pull only?
    [2:51pm] ImpatientPerson: you can always go back and remove or update the commit if you need to
    [2:51pm] ImpatientPerson: but another alternative is git stash
    [2:52pm] OtherImpatientPerson: git stash
    [2:52pm] OtherImpatientPerson: git stash pop
    [2:52pm] ctshryock: the index.php has been modified by someone/thing on REHL
    [2:52pm] PersonWithQuestion: ctshryock, i did that yes
    [2:52pm] OtherImpatientPerson: PersonWithQuestion: git stash
    [2:52pm] OtherImpatientPerson: git pull
    [2:52pm] ImpatientPerson: i end up doing git stash && git pull && git stash pop
    [2:52pm] OtherImpatientPerson: git stash pop
    [2:52pm] OtherImpatientPerson: yup
    [2:52pm] ctshryock: PersonWithQuestion: Do you want to keep those changes?
    [2:53pm] ImpatientPerson: behind the scenes stash is creating a commit for the file anyway
    [2:53pm] PersonWithQuestion: ctshryock, no 100% ignore and pull whatever is now in github.com i just tried : git stash && git pull && git stash pop  but it saying conflict (content): public/index.php
    [2:53pm] PersonWithQuestion: wow stash is cool i think it did all the updates
    [2:53pm] ctshryock: git checkout -- public/index.hphp
    [2:54pm] ctshryock: That will restore public/index.php to the unmodified state
    [2:54pm] PersonWithQuestion: error: path 'public/index.php' is unmerged
    [2:54pm] ctshryock: then you can `git pull`
    [2:54pm] ctshryock: From the checkout line above?
    [2:55pm] ctshryock: oh you're in the middle of a merge conflict from doing all that stash pop nonsense
    [2:57pm] ctshryock: `git merge --abort`
    [2:57pm] ctshryock: git checkout -- public/index.php
    [2:57pm] ctshryock: git pull


Here we have **ImpatientPerson** and **OtherImpatientPerson** rattling
things about `git stash` and what not before even understanding what **PersonWithQuestion** was even trying to accomplish. Meanwhile
**PersonWithQuestion** ends up mucking up their working directory
running each command you threw at them because they don't understand the
problem either.

You mean well, but try to understand the problem first before you start shouting answers.
