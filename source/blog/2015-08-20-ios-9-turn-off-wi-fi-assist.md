---
title: "iOS 9: turn off Wi-Fi Assist!"
date: 2015-08-20T01:01:57-07:00
date-display: August 20, 2015
---
Seriously. Go to Settings->Cellular, and scroll all the way down to reveal the "Wi-Fi Assist" switch. See screenshot at the end of the post. You'll see a description:

> Automatically use cellular data when Wi-Fi connectivity is poor.

Switch that off, if you occasionally have shitty Wi-Fi (that kinda works anyway) and at all care about your cellular data usage.

I'll tell my horror story now. Background info: I have unlimited voice and text plus 300 MB data per month, since I've got Wi-Fi almost everywhere I go. Granted, school Wi-Fi (especially dorm) is shitty and drops all the time, but I'm not a streaming-music-on-mobile person, so the Wi-Fi is mostly fine for checking emails, browsing the Web (yes, even [iMore](http://murphyapps.co/blog/2015/6/24/an-hour-with-safari-content-blocker-in-ios-9) or [The Verge](http://blog.lmorchard.com/2015/07/22/the-verge-web-sucks/) kind of Web), getting push notifications, or even downloading a few podcasts on the go. I usually end up using less than 200 MB of cellular data per month.

However, at the beginning of August (on iOS 9 Public Beta 2 at that time), I somehow managed to burn through 200 MB in four or five days, with consistent daily stats, *while I did nothing special, at least not actively*. The timing overlaps with when I got my Apple Watch; I don't know if that's a coincidence. Anyway, more than 90% of that usage was under System Services->Documents & Sync, which I could do nothing about. I had to turn off cellular data until almost the end of my billing cycle, when I stumbled upon the "Wi-Fi Assist" setting. Since then, I only used 4.8 MB — with 1.5 MB for System Services — in four days. Hardly a coincidence, I'd say.

In fact, I was pretty delighted when I heard about the ability to auto fallback to LTE when one's on the fringe of Wi-Fi in WWDC '15 Session 719 ("Your App and the Next Generation Networks"). However, without another likely suspect, I guess what happened in reality was that when I was sitting in the center of a shitty Wi-Fi, with the system trying to do some background job involving a network connection, it just kept trying to connect via LTE, which probably beat the shitty Wi-Fi consistently. It would be nice if one day our phones would be aware of our data plans (realize that not every one is on a $100/mo 15 GB plan) and throttle its usage wisely.

Anyway, I simply can't understand why the "Wi-Fi Assist" switch, a general system-wide option, appears at the end of Cellular settings, after all the per-app nickel-and-dime settings and statistics. It's nearly impossible to find. Generic settings should be at the top, period.

By the way, I have a lot of gripes about iOS 9 Beta. Maybe I shouldn't whine about beta software — I never used another iOS beta before so maybe they were even worse — but I can't help it because this was supposed to be a stability release. Several things immediately jumped to my mind (all present in the latest Public Beta 3), without even trying:

* [Searchable settings](/blog/2015-06-26-ios-9-searchable-settings.html) is a scam. Many items can't be found. For instance, good luck searching for "Wi-Fi Assist". I wonder if the search index is hand-crafted. Also, you can't pull down to search from any screen; you have to go back, back, back, back to the main settings screen, and even then it begins with your last search, even if you're done with it. Ewww.

* Scrolling and switching screens feels janky (system-wide) even on iPhone 6 Plus, supposedly a powerhouse.

* The Music app is indeed totally screwed up (this actually dates back to iOS 8.4). It's so much harder than previous versions.

    Dude, give me my old UI with selectable categories on the bottom bar if I've turned off Apple Music, okay? Do I have to put up with the Radio and Connect tabs, completely useless for me? Switching categories — by which I mean artists, albums, songs genres, etc. — is infinitely harder now, because you have to scroll all the way up to the top of a category in order to reveal the category selector, which has a dropdown arrow outside but isn't really a dropdown.

    And may I go straight to the artwork and playback control screen when I tap to play a song? Damn, when I select and play a song of course I want see the song front and center; don't treat me like an indecisive guy.

    And may I kindly request that the artwork does not protrude to the status bar — you do realize some artworks have white or light backgrounds, rendering the status bar unreadable?

    Recently I also noticed that all my old iTunes purchases are showing up and screwing my library. There used to be a switch in System Preferences, the right place for this kind of settings on iOS, but it's since be removed in favor of Apple Music stuff (not sure why they are mutually exclusive), and strangely put in the category switcher. Hell, this abomination is even documented in ["Using the new Music app"](https://support.apple.com/en-us/HT204951); here's [Apple's official screenshot](https://i.imgur.com/RJKLqPo.jpg) showing off the stupid category switcher. For me without Apple Music, the switch says "Show iTunes Purchases" instead of "Show Music Available Offline". Pretty clear, huh, not bad. But don't bother, it does absolutely nothing for me.

I could go on and on and on, but I don't want to waste more time on this crap. The gist is that I'm not impressed by iOS 9 at all at the moment (oh, one thing positive: San Francisco is nice). Hopefully the final release would be in much better shape; but I don't see any hope for the Music mess — it's not likely to be cleaned up any time soon. I mourn for the old Music app, which is likely gone forever.

![The "Wi-Fi Assist" switch, hidden below per-app settings.](/img/20150819-ios9-wifi-assist.png)
