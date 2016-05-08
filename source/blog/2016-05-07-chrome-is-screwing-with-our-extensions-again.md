---
title: "Chrome is screwing with our extensions... Again"
date: 2016-05-07T18:49:26-07:00
date_display: May 7, 2016
---

Chrome is growing more and more hostile by the day. See [Google Chrome keeps getting uglier](/blog/2016-03-06-google-chrome-keeps-getting-uglier.html) for an earlier take. What I didn't report in the earlier post is that not only can't you show/hide extension buttons as easily as before, you can't even control which buttons appear in the toolbar anymore — they come and go as they wish.

As if screwing the app icon, extension buttons and the overall design is not enough, now they have upped their game again. I'm running Chrome 50.0.2661.94 from April 28, and I just rebooted my machine only to be greeted with a fleeting "unsupported extensions" (or something like that) message as I launched Chrome. I digged into the extensions page, and guess what, all sideloaded extensions (except unpacked ones) have been disabled.[^first] This in itself may not be too surprising (Google took away sideloaded extensions from non-developers last year), except that **the "enable" button, which used to work at least in developer mode, doesn't function anymore.** The message is very stupid:

> This extension is not listed in the Chrome Web Store and **may** have been added without your knowledge.

Bold by me. Okay, so what if they have been added **with my knowledge**? No way to enable legit extensions (some written by none other than myself) just because of a "may"? Here's the [only migration path](https://support.google.com/chrome/answer/2811969) they offer, by the way:

> If you need to use a disabled extension, you can contact the extension's developer and ask them to upload their extension to the Chrome Web Store.

Seriously? Do they honestly think Chrome Web Store serves everyone's needs? First, they have every right to refuse or take down any extension in their store. This is dangerous. What if one day they conclude that Adblock Plus is hurting their ad revenue too much and decide to take it down? Secondly, people may not want to make every extension publicly available. For instance, I have some personal extensions that I have developed on my dev machine, packaged into .crx, and installed on other machines. Some of these are publicly available (on GitHub), and others are not. It's not hard to conclude that other people may have private extensions too, and there may be extensions that are only available in some private circles. Now, people have to load unpacked extensions, which is much easier to screw up for regular folks, or they're out of luck.

To add insult to injury, every time I launch Chrome now, I'm greeted by this "Disable Developer Mode Extensions" message:

> Extensions running in developer mode can harm your computer. If you're not a developer, you should disable these extensions running in developer mode to stay safe.

As if there're not enough malicious extensions in the Chrome Web Store, let alone crap. May I tell Chrome that I *am* a developer and ask it to shut up? Apparently no.

With the current trend in Chrome, I might want to switch to Opera again.[^safari] The only thing preventing me from doing so right now is their new [horrendous-looking fat icon](https://i.imgur.com/F8Tc67m.png). However, Chrome has also destroyed their icon and I need to [replace it](https://github.com/zmwangx/fileicon) after every update anyway, so I might as well do the same thing for Opera. We'll see.


[^first]: I'm not sure why they weren't disabled upon first launch after the update, but given the randomness of extension buttons in my toolbar with hardly any action on my part, I won't be surprised if I were told that they had messed up the extension system completely.

[^safari]: Modern day Safari is also pretty nice, and the team is showing great attitude lately, with Safari Technology Preview and tweets like [this one](https://twitter.com/webkit/status/725725657548738561), for instance. However, the lack of extensions is a big road block, and the fact that the used-to-be-free Safari Developer Program has been incorporated into the $99/yr Apple Developer Program certainly doesn't help. (I used to be a member. Now I've been kicked out.)

    Note that Safari is more locked down in a sense compared to OS X and iOS. On OS X you can apparently run unsigned software; on iOS 9 and later you can create personal provisioning profiles with just an Apple ID. Neither is true for Safari extensions, which still require a signing key from developer program membership. I wonder if Apple will introduce free keys for personal use on Safari, too.
