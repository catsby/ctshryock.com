--- 
layout: post
title: ctshryock / jrfeedbackprovider
date: 2009-07-19 11:47:26 -05:00
category: posts
tags: cocoa
---

I forked the [JRFeedbackProvider](http://github.com/rentzsch/jrfeedbackprovider/tree/master) project on [github](http://github.com/) yesterday and made two commits that have already been pulled and merged into the main branch.  They're small, one adds a regular expression check on the email address sent in the php file to check it's format as a valid email address, the other adjusts the NSTextView's NSTextStorage to remove the bold font when using `showFeedbackWithBugDetails:` to pre-populate the textview with bug details.

JRFeedbackProvider is a 'nonviral cocoa source for implementing an application feedback panel' .  In short, it provides your users a standardized in-app method of providing feedback, from bug reports to to feature and support requests.  The two main approaches are to use the default details pane, which asks basic questions for each category separated into three tabs/panes, and another option which allows the developer to pre-fil the bug report pane with details supplied from within the app.

The second patch I committed dealt with the latter feature.  In the default `showFeedback` method, the textview was pre-filled with some basic questions in bold; "what happened, what did you expect" etc.  The `showFeedbackWithBugDetails` route was essentially a blank text area by default with the exception of whatever the developer chose to fill it with by supplying an NSString, but this always resulted in the supplied text being in bold like the pre-filled bug report.  I initially figured out that if you called `[textView setString:@""];` it would 'fix' this and the following text would be a normal font weight, but I stumbled across [this thread on cocoadev](http://cocoadev.com/forums/comments.php?DiscussionID=1173) that sent me in another direction.  So I went back and updated the method to first grab the font in use by the textStorage's (which was bold) and creating the same font using the NSFont's `familyName` method, but without the bold, like so:

{% highlight objectivec linenos %}
NSFont *resetFontWeight = [[textView textStorage] font];
//  Font name: Helvetica-Bold	
//	Font Family Name: Helvetica
[[textView textStorage] setFont:  
    [NSFont fontWithName:[resetFontWeight familyName]  
    size:[resetFontWeight pointSize]]];
[textView setString:details];  
[resetFontWeight release];
{% endhighlight %}

This effectively resets the font, losing the bold. 
