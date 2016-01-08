---
title: "Follow-up: The sad state of Finder on El Capitan"
date: 2015-10-14T12:30:32-07:00
date_display: October 14, 2015
---

**10/14/2015 update** (updated even before I published the article). Just as I was finishing this post, an update to TotalFinder came. [1.7.8](http://totalfinder.binaryage.com/beta-changes). And holy cow, it fixed automatic column resizing! The fix isn't perfect — there's actually a visible delay before resizing, but I'm happy again. Long live TotalFinder!

---

As expected, it's hard to get Finder to work the way I want it to on El Capitan. The unexpected part is that even after disabling the Debugging Restrictions part of SIP (`csrutil enable --without debug`), XtraFinder and TotalFinder[^update] both can't auto resize columns. Seems that a hole they are both utilizing has been closed. Just like `QLEnableTextSelection` in `com.apple.finder`, I guess. Apple gives, Apple takes. XtraFinder has additional problems like folder-on-top not working, window config occasionally forgotten, and the long-standing issue of shitty Chrome-style tab implementation (basically stacking a separate layer on top of each window) that shows a visible white divider, so I'm running TotalFinder right now, not sure about whether it would be abandoned completely next year. Anyway, even after running TotalFinder, it's still that damn old stupid Finder, the columns of which I have to manually resize all the time; just a little bit nicer.

So I went out to look for full Finder replacements. I tried everything listed in the [TotalFinder alternatives](http://discuss.binaryage.com/t/totalfinder-alternatives/4124) post on TotalFinder forums. None worked for me. Here's a very brief (batch) review.

* [Disk Order](http://likemac.ru/english/), [Commander&nbsp;](http://mac.eltima.com/file-manager.html)[One](http://mac.eltima.com/totalfinder-promo.html), [DCommander](http://www.devstorm-apps.com/dc/), and [CRAX Commander](http://crax.soft4u2.com/): No column view. All of them are dual-pane though. What's the advantage of being dual-pane? I can't fathom. Easier to copy/cut and paste? What a joke — how often do you do that to justify having two panes in your face at all times? Might as well spend the time to do a column view. Column view enables fast navigation and provides a full picture of a directory tree, which is one of the two reasons I use Finder (i.e., a file manager), the other being Quick Look. If I just want to stay in a single directory, and painstakingly navigate in and out, I'll just do everything in the terminal, thank you. By the way, Command One and DCommander are suprisingly similar, both appearance-wise and functionality-wise. Not sure if one rips off the other (looks like DCommander is older). Also, why do most of them call themselves commanders? Another thing that I can't fathom.[^commander]

* [ForkLift](http://www.binarynights.com/forklift/): Again, dual-pane, and doesn't seem to offer a single-pane mode, but you can drag the pane divider all the way to the right to hide the second one (including the divider). It has a column view, but doesn't seem to offer column auto resizing. Also, it doesn't hide items with the `hidden` flag, which is kind of insane. Even more shockingly, it offers no option to show file extensions! Tell me again that this is a power user tool. (Yeah, I know its myriad power user features, but I need the basic ones, and I don't see them. More discussions about "features" at the end.)

* [Path Finder](http://www.cocoatech.com/pathfinder/). It actually kind of works. It offers column auto resizing, hidden in the view options of the column view (accessible via &#x2318;J). Even "`open ~`" could open in Path Finder, if you let it be the default file manager; that was a nice surprise, and I'm not sure about the mechanism (maybe [this](https://apple.stackexchange.com/questions/73529/how-to-change-the-default-file-manager-for-osx)? Doesn't sound right though). However, it has a horrible default appearance, and even after substantial customizations, it still looks kind of crappy. Also, the auto resizing implementation is incomplete, in that it doesn't offer min and max column size settings, so when auto resizing is enabled, many columns look awfully narrow. I'm also suspicious about its tech support. When I was investigating some issues about it on Google, I found some relevant tickets on its [support site](http://support.cocoatech.com/), but *none* of the tickets have any replies. I didn't bother to look around, but that was definitely a bad impression.

    By the way, I mentioned concerns about Path Finder's pricing in the [sad state](/blog/2015-07-30-the-sad-state-of-finder-on-el-capitan.html) post. At $40 it's definitely not cheap, but judging from the [release history](http://support.cocoatech.com/kb/installation-and-compatibility/path-finder-version-history), it's more like pay-to-upgrade every other year, rather than every year.

    Conclusion: not impressed.

Finally, a few words about "pro features". Many of these file managers offer a huge bundle of pro features, but quite of a few of them are completely useless. Useless features include builtin text editor, hex editor, terminal, archiver and unarchiver, blah blah blah. Why would anyone use those watered-down builtins? I use the right tool, the dedicated tool, for the right job. (To give one example, Commander One includes a command line that you can type commands to execute — without command or filename completion, naturally; and it also ships with a builtin terminal accessible via &#x2303;O. Apart from horrendous typography, the builtin terminal is also barely better than a dumb term, incapable of handling my prompt theme. Meanwhile, iTerm2 is accessible via a system-wide shortcut &#x2325;Space to me — extremely convenient.) Support for other filesystems, including remote filesystems and in-place archive browsing, could be welcome though, although I seldom need them.

---

P.S. Here are the version numbers, at the time of writing, of the mentioned software packages (apparently, things might change in later versions):

* TotalFinder 1.7.6 (beta);
* XtraFinder 0.25.5;
* Disk Order 3.2.5;
* Commander One 1.1.1346;
* DCommander 2.7.2;
* CRAX Commander 1.10.4 (demo);
* ForkLift 2.6.6;
* Path Finder 7.2.

[^update]: TotalFinder 1.7.8+ now supports column auto resizing on El Cap. See update at the top.

[^commander]: If you Google ["file manager commander"](https://www.google.com/search?q=file+manager+commander), you'll find a hell lot of "commanders". Reminds me of C&C... Oh well.
