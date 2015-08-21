---
title: "I installed BlockParty, and the only thing I can say is WOW"
date: 2015-08-20T20:58:55-07:00
date-display: August 20, 2015
---
I just let out [a load of complaints about iOS 9 beta](/blog/2015-08-20-ios-9-turn-off-wi-fi-assist.html) last night, but apparently forgot about one nice thing: [Safari content blocking](https://developer.apple.com/videos/wwdc/2015/?id=511).

In this day and age, not being iOS/OS X developers ourselves won't stop the rest of us from obtaining ObjC/Swift source code.[^1] I simply typed "Safari content blocker" into GitHub's search box, and there it popped, the most starred repo relevant to my search, [krishkumar/BlockParty](https://github.com/krishkumar/BlockParty). Thanks to Apple's new sideloading policy in Xcode 7, I was able to immediately test it out on my phone.

[^1]: Actually developing a Safari content blocker extension is as easy as writing a JSON blocker list, but I'm not sure if you need an app with a UI to support the extension. Anyway, there are professional iOS developers out there ready to share the code, so I'll just happily join for a ride.

The effect is just amazing. In my few minutes of browsing, I did not seem to encounter a single ad (on various consistently ad-laden news sites). You should definitely give it a shot. What's even more amazing is that BlockParty's [`blockList.json`](https://github.com/krishkumar/BlockParty/blob/master/RediffBlock/blockerList.json), at the time of writing, is only 1578 lines long — a JSON array with 197 objects. **Only 197 rules, blocking 197 domains.** Compare that to [EasyList](https://easylist-downloads.adblockplus.org/easylist.txt), which at the moment is a **48820 line monster**. Of course, EasyList is much more fine-grained ([as are AdBlockPlus's filtering mechanisms](https://adblockplus.org/blog/content-blocking-in-safari-9-and-ios-9-good-news-or-the-death-knell-of-ad-blocking-on-safari)); with BlockParty I can actually see some blank boxes that used to host ads. But still, very impressive. Many thanks to [\@krishkumar](https://github.com/krishkumar) for publishing BlockParty, and to [Justin Searls](https://medium.com/@searls/installing-a-content-blocker-on-ios-9-public-beta-a25b2b83848f) for publishing a detailed tutorial.[^2]

[^2]: Without which I would have been scratching my head, not knowing that I had to go to Settings->General->Profiles to trust my personal profile.

197 domains made our online lives so miserable. Hmm.
