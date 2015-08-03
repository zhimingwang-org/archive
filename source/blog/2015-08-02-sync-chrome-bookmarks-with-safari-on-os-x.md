---
title: "Sync Chrome bookmarks with Safari on OS X"
date: 2015-08-02T22:11:56-07:00
date-display: August 2, 2015
---
**TL;DR**: [zmwangx/safari-sync-chrome-bookmarks](https://github.com/zmwangx/safari-sync-chrome-bookmarks).

---

I've been reading quite a bit of stuff on my iPhone 6 Plus these days, especially since I got my Apple Watch (not quite sure why these two things are correlated, but they are). I used to read subscribed content in Feedly, but abandoned that a while ago since Feedly does an unbearably bad job at updating my one-subscriber feeds,^[I can understand that to reduce server load, they can't refresh the one-subscriber feeds at a rate, say, once per minute, but not being able to manually update, especially when you have a so-called "refresh" feature? Not cool. (What the manual "refresh" seems to do is to fetch Feedly's cached content.) Anyway, it's a freemium service with me running the free tier, so I can't really blame them.] e.g., Ars Premier feed, GitHub release feeds, etc. Ever since then, I've been rocking a local Leaf engine on my Mac but lost access on my phone,^[Which RSS reader/service I'll use next on iOS is a question; I haven't got time to compare the various options yet. So many readers, so many aggregation services!] and had to rely on bookmarks.

However, as a Chrome user on the desktop and only on the desktop (iOS Chrome sucks), I have trouble getting my Chrome bookmarks into mobile Safari. Apple developed an [iCloud Bookmarks](https://chrome.google.com/webstore/detail/icloud-bookmarks/fkepacicchenbjecpbpbclokcabebhah?hl=en) extension for Chrome that allegedly syncs your bookmarks to iCloud^[And also one for Firefox, it seems], but upon installing the extension for Mac Chrome, an error message pops up:

> The extension you are trying to install is designed to run on Windows 7 or 8. If you are using a Mac, your Safari bookmarks will automatically sync with your iPhone, iPad, and Mac when you sign in to iCloud on all your devices.

The message is pretty clear: you have access to our browser, so you either use our browser or go fuck yourself.

So, what's next? Fortunately, recent versions of Safari (I'm currently running 8.0.7) has an import feature that comes in handy and does a pretty good job: "File -> Import From -> Google Chrome..." which lets you import either history or bookmarks or both. Once they are imported into desktop Safari, iCloud is pretty good at pushing it to mobile. I have no problem importing both, but the idea that I'll have to launch Safari and click click click click just to sync my bookmarks is beyond horrible.

Okay, remember we have another nightmare called AppleScript? And remember we have another nightmare within nightmare called GUI scripting? Yes, here's what we could do:

```applescript
#!/usr/bin/osascript
tell application "Safari" to activate
delay 1
tell application "System Events"
	tell process "Safari"
		tell menu bar 1
			tell menu bar item "File"
				tell menu "File"
					tell menu item "Import From"
						tell menu "Import From"
							click menu item "Google Chrome…"
							delay 1
							keystroke return
						end tell
					end tell
				end tell
			end tell
		end tell
	end tell
end tell
delay 1
tell application "Safari" to quit
```

Holy crap, look at that cascade.^[There's another annoyance: `"Google Chrome…"` cannot be replaced with `"Google Chrome..."`, or you won't ever find that menu item.] Anyway, in principle, this piece of crap works. In reality, well, it *sometimes* works. Because you know the nightmare called "assistive access", among other unreliabilities of poking around with system events:

![Familiar?](/img/20150802-assistive-access-nightmare.png)

On Yosemite at least, the pane to grant assistive access in System Preferences is three levels deep ("Security & Privacy -> Privacy -> Accessibility"), behind an admin password, and most unfortunately, there's no way to grant access to individual executables through that pane, unless you are explicitly prompted about one, which may not happen when it should.^[There might be a way round through poking with the system accessibility database as root; see [jacobsalmela/tccutil](https://github.com/jacobsalmela/tccutil). However, until I have time to carefully evaluate the code, I'll have to stay with System Preferences.] ^[Yes, I can understand the security concerns, but having to jump through so many hoops just to get some damned GUI scripting to work is awfully frustrating — and that's when you assume that the damned thing would just work after you jump through the hoops.] There's nothing I could do apart from granting access to both Terminal.app and iTerm.app and hope for the best. Not so surprisingly, just as demonstrated in my past encounters with GUI scripting, with access granted to the terminals, whether I'll get an "assitive access" error when running the script is completely hit-or-miss. This time it works, the next time it just stalls, and yet another time it emits the error... Oh god.

In order to raise the rate of success, there's one other trick we could try: package the script into an Automator app. This way we can grant access to the standalone app, and that helps a bit. That's what I did in [zmwangx/safari-sync-chrome-bookmarks](https://github.com/zmwangx/safari-sync-chrome-bookmarks). It still occasionally get stuck, probably because I have a freaking slow spinning HDD and Safari would sometimes take forever to launch; but the accessibility problem does seem to go away (provided that you re-grant access every time you make the tiniest modification to the app).

Now I can throw that into my crontab (launching Safari beforehand to avoid freezing up):

```crontab
55 04 * * * open -g -a safari && sleep 30 && open -g -a safari-sync-chrome-bookmarks
```

or invoke on demand.

Horrible solution, yes. Anything better? I would love to hear about it, but I highly doubt there's any, unless we directly work with `~/Library/Application Support/Google/Chrome/Default/Bookmarks` and `~/Library/Safari/Bookmarks.plist`. Probably a good problem
to tackle though, provided that someone would sit down and understand the formats of the two files.
