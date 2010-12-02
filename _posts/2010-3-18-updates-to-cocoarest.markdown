--- 
layout: post
title: Updates to CocoaREST
date: 2010-03-18 20:53:46 -05:00
mt_id: 33
---
I've been adding support for the Github API to my fork of [CocoaREST][1].  Right now I've added: 

1. __SDGithubTaskGetRepos:__ Showing a list of repositories by user
2. __SDGithubTaskGetRepoNetwork:__ Showing the network for a given user/repository (shows commits by forks of that repository, or commits of forks of it's parent repository)
3. __SDGithubTaskUserShow:__ show information about a user
4. __SDGithubTaskUserUpdate:__ Update user information with new name, email, blog, company or location

In addition I've added a tab to the demo app to show some of these.  In it you can view user information by name (__SDGithubTaskUserShow__) and get a list of repositories (__SDGithubTaskGetRepos__).  The tableview is set run a new task to find forks of the selected repository (__SDGithubTaskGetRepoNetwork__) on selection change.  

The _GithubDelegate_ is kind of a cumbersome class in that it handles all of the task results even though the API returns different results for each task.  Ideally I would use a specialized class to delegate for each task, but it's just for demonstration. 

[1]: http://github.com/ctshryock/CocoaREST 
