---
title: "Antivirus app on MAS top chart?"
date: 2016-01-24T18:43:28-08:00
date_display: January 24, 2016
---

Today for whatever reason I clicked on MAS's "Top Charts" page, and was immediately in for a surprise. Next to our great friend 1Password is an app called "AntiVirus Sentinel Pro", which sells for $9.99:

![AntiVirus Sentinel "Pro". These days many people like to end their apps' names with "Pro", even when there's nothing pro about them. This "Pro" app, for instance, comes from a developer whose three out of four apps matches the regex `^([A-Z](a-z)+ )+Pro$`, and which are definitely geared towards uninformed newbies despite their names.](/img/20160124-mas-top-paid.png)

The first rule of using MAS (or any kind of app store, for that matter) is that you research MAS apps outside the MAS. So let's Google "AntiVirus Sentinel Pro"... First result: [Apple Support forum thread](https://discussions.apple.com/thread/6749331) from late 2014, "Is AntiVirus Sentinel Pro legit? If not, how can I delete it?" Good question about any AV product. However, you'll immediately find it hilarious when you read on:

> I have purchased and downloaded AntiVirus Sentinel Pro for Macintosh with Yosemite OS. I have a bad feeling this application is useless and maybe even harmful. Anyone knows if it is safe to use it?

Okay, so why did you purchased it in the first place? I guess clueless users like this one are in every MAS developer's wet dream.

Let's continue with the Google search results. Second one is the iTunes preview link. Third one is a [YouTube video](http://www.securityfocus.eu/www/sentinel-pro.html) (also linked from MAS) which seems to be the only online documentation this app's got. Judging from the video the interface seems to be done in Java or something... Never mind that. Fourth result is a [rather recent thread](http://www.mac-forums.com/os-x-operating-system/327356-antivirus-sentinel-pro.html) (August 2015) from Mac Forums. Not this again:

> I am a new Mac user. Can somebody answer these questions? Somehow it appears I have installed AntiVirus Sentinel Pro. What is this? Is it a real software? Should I keep it or try to uninstall it?

The fifth and sixth results are general OS X AV product reviews that don't even mention this one. The next three results are from MAS aggregation sites. The last result on the first page is the product page on MacUpdates (now apparently abandoned), with a shiny 0.5/5 stars (note the zero point) badge.

Now that we've finished the first page (and the results are not a bit reassuring), the question comes: where the heck is this app's home page? It's also not on the second page, actually. There's something interesting on the third (still no home page), that is [this tweet](https://twitter.com/claud_xiao/status/681981763938197504):

> $10 "AntiVirus Sentinel Pro" got top2 in US Mac App Store and top1 in 48 countries--but it's just ClamAV+AdwareMedic signs+3 bullshit signs.

Hmm. You might want to read Thomas Reed's (known for The Safe Mac) responses from that thread.

Anyway, we were sidetracked. Back to the home page, actually this app does have one, but it's just [a single page](http://www.securityfocus.eu/www/sentinel-pro.html), which simply states some marketing bullshit and directs to MAS (which states the same bullshit again). Seriously? That's the best you can do for your "pro" app, especially a security-related one?

Back to MAS, the reviews are kind of jokes, too:

![](/img/20160124-antivirus-sentinel-pro-reviews.png)

The first one begins with

> Just switched to Apple from Windows ... and researched anti-virus software.

Don't really need to read further.

Second one, speaking of customer service:

> ... it only took one email to him explaining my problem... had a patch up and ready on the app store to download within hours.

This review is from October 2015. Since when was MAS so efficient? Why do I (and everyone else keeping tabs on Apple stuff) keep hearing stories like [bug fix updates waiting for review after 59 days](http://mjtsai.com/blog/2015/12/01/sketch-leaving-the-mac-app-store/)?

The pattern goes on. By the way, how does this app keep track of all disk and network activity when itself is running in a sandbox? No idea (maybe I'm misunderstanding sandboxing).

In summary, even as an AV product, this one seems rogue. Not to mention AV products on the Mac are generally superfluous if not harmful.[^1] What people really need to learn is to exercise causion when browsing online and to properly use content blockers, which AV product vendors and (intrusive-)ad-supported websites won't tell you because they would go out of business if they do.

And how this app got onto the top charts, that is a real mystery.

[^1]: Disclaimer: I personally have used ClamXav and AdwareMedic (which has since been bought by Malwarebytes) before to help my social-engineered friend (tech support scam, in case you ask). Just to scan their documents though. It is my belief that once you're pwned (even slightly), clean system reinstall is the only way to go, despite what AV products might tell you. In addition, I don't use AV products myself (except Microsoft Security Essentials on Windows); as a programmer I've had enough bad experience with AV blocking *my* programs back in the Windows days.
