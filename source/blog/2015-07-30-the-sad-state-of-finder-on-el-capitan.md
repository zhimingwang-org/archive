---
title: "The sad state of Finder on El Capitan"
date: 2015-07-30T23:59:09-07:00
date-display: July 30, 2015
---
I was listening to [Accidental Tech Podcast E128](http://atp.fm/episodes/128) today, which discussed the implications of Rootless (i.e. System Integrity Protection) at quite some length.[^1] Which stirred up my old worries about the Finder — I was briefly concerned about TotalFinder immediately after Rootless was announced in WWDC, but was quickly reassured and forgot that concern after learning that Homebrew (i.e. `/usr/local`) isn't affected, which attracted more of my attention.

[^1]: It's interesting to listen to John Siracusa's take on the issue, by the way. I completely agree with him.

Unfortunately, the concern is real. TotalFinder is dead on El Capitan: it has been monkey patching Finder.app all along, and that strategy apparently is killed by Rootless. BinaryAge has [announced](http://blog.binaryage.com/el-capitan-update/) that TotalFinder won't be ported to El Capitan. It's a done deal.

This is actually not the first time I felt threatened as a TotalFinder fan[^2]. Back in 2013, when Finder tabs was announced for Mavericks, there were [hints from BinaryAge](http://discuss.binaryage.com/t/call-for-ideas-what-should-be-the-next-binaryage-product/243) that TotalFinder might be discontinued one day, because apparently Finder tabs is a "serious hit for our [BinaryAge's] business". However, it still survived all the way up till Yosemite. I had the hope that TotalFinder could die a peaceful, glorious death when Apple finally improved the stock Finder to a certain point; I didn't quite expect TotalFinder to die an abrupt death like this.

[^2]: Well this time we're not really threatened; TotalFinder is just plain dead. Those "I run Snow Leopard and I won't upgrade" dudes are delusional, as I've pointed out more than once.

Now that I think about it, my expectations for Finder isn't very high. Just provide the following and I'll be pretty happy:

1. Auto-resize each column (one can already "Right Size All Columns Individually" through the right-click context menu from the column dividers — is it that hard or unreasonable to make that automatic?);
2. A way to quickly show and hide hidden files without leaving Finder;
3. Finder on top (when not sorting by kind) is a nice addition, but not a must;
4. Chrome-styled tab (instead of Safari-styled) would be a plus.

Pretty simple, aren't they (except point 4, which won't happen in stock Finder for the forseeable future)? Especially point 1, which should be desirable for all users, power users and dummies alike. If TotalFinder (and the free alternative XtraFinder, for that matter) can do these just by monkey patching, then Apple with all the control and infinite resources definitely could do these.

Anyway, complaints aren't going to get me anywhere. What's next?

TotalFinder is dead.

XtraFinder[^3] similarly monkey patches Finder, so it also won't work with Rootless enabled. The developer has no plan to drop its support though, and I've confirmed that so far the lastest version works well on El Capitan PB3 without Rootless, save for the auto-resize columns feature, which somehow has no effect. Hopefully it will be fixed.

[^3]: [XtraFinder](http://www.trankynam.com/xtrafinder/) is free, and it comes from the developer of [aText](https://www.trankynam.com/atext/), so I have good feelings about it. However, its annoucements and discussions take place on [Facebook](https://www.facebook.com/XtraFinder), which makes it awfully unprofessional...

The only other well-known Finder alternative is probably Path Finder, but being a standalone program[^4] priced at $39.95, it seems both too full-blown and too expensive. Also, the "Path Finder 7" and "Upgrade — $19.95" on [the project's home page](http://www.cocoatech.com/pathfinder/) aren't reassuring; it's probably a $20 per year program.[^5] Moreover, even if I end up paying the money, I'm not even sure if it is going to be able to fully replace the experience around Finder. For instance, does the `open` command open directories in PathFinder? I highly doubt that. Heck, I just want a nicer Finder; why am I forced to a full (and probably not fully integrated) replacement.

[^4]: From what I've heard.

[^5]: Mind you, TotalFinder charges nothing except the initial $18 investment, despite a lot of rewrite for each major version of OS X.

Besides, Path Finder's roadmap is pretty ridiculous. A guy asked "[Will Path Finder work with El Capitan?](http://support.cocoatech.com/discussions/problems/33611-will-path-finder-work-with-el-capitan)" on the support forum, and the reply was

> Unfortunately, I cannot provide you with any information regarding this at the moment. We will let you know once there will be an official release of Mac OS X El Capitan.

Seriously? That sounds so last decade. Which developer is so tight-lipped today? And who waits for the final OS release only to announce the support schedule? If they can't keep up with the schedule (or haven't looked at the barriers yet), at least they can communicate honestly with customers. This kind of uncertainty will only drive people away. Hard to believe this is the support you get for $40 plus upgrade fees.

I don't know what I'll do in the end. Path Finder is probably not what I'm looking for, but maybe I'll give it a spin if they release an El Capitan ready version in time. Most likely though, I'll stick to stock Finder for a while, and if it turns out too painful, I'll just disable Rootless and sport a copy of XtraFinder. I don't think Rootless will be that useful for me anyway; I still believe it's game over once malware sneaks into my system, whatever privilege it claims. Whether Apple will further lock down the system in a future version is another story.
