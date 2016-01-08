---
title: "Upgrading to El Capitan"
date: 2015-10-01T11:46:44-07:00
date_display: October 1, 2015
...

I upgraded to El Capitan last night, and the experience is pretty painless. To be accurate, I'm not really upgrading in place — I always perform a clean install for each major OS upgrade to avoid subtle breakage later on. Therefore, what I did instead was to `rsync` out all my valuable data and state information[^state] to an external drive, wipe the internal drive clean, install new OS from scratch, then `rsync` everything back in. `rsync` is really good at this stuff (I affectionately alias `rsync -avP` to `r` during transfers in and out), and it is simply amazing at dropping the right stuff at the right place, including data deep down `~/Library/Containers`, without interfering with the existing structures[^existing]. With data and state info ready, reinstalling programs is also easy, thanks to my recently finished [automated provisioning system](/blog/2015-08-25-automated-os-x-provisioning.html). It was the first time I used it outside a VM to provision an OS from almost scratch, and I'm really happy with it.

Thus far, most of my programs and applications seem to work just fine on El Capitan. I needed to `brew reinstall pyenv --HEAD` because an OpenSSL fix for El Capitan hasn't made into a release yet. Some of XtraFinder's features[^rootless], including my most needed auto resizing columns, don't seem to work on El Capitan yet, and I'll have to contact the developer soon. The only distratrous incompatibility I've seen lies with Mathematica 9; `codesign -vvvv Mathematica.app` on the v9.0.1 app bundle says `resource envelope is obsolete (version 1 signature)`, and OS X downright refused to open the app, offering me no option other than trashing the app, even when I temporarily set Gatekeeper to "Any". Anyway, I quickly paid to upgrade to v10.2.0 (cost of free OS upgrade, geez), and it ran happily afterwards. Those were basically all I had to deal with. I haven't set up my mail accounts[^mail] and printer yet, but hopefully they will work, and just hopefully Apple Mail finally got it right this time™ and won't ask me to reauthenticate with Gmail all the time.

Overall it was pretty good experience. Nevertheless, I was caught by surprise at least twice, due to subtle user-facing changes in the OS. Actually these surprises motivated me to write this post.

First, <u>the OS seems to default to using the iCloud password (i.e., the Apple ID password) as the local account password now.</u> Maybe I missed a checkbox during setup (unlikely), and maybe it was nothing new (I don't think so), but I only realized this when I needed to `sudo` on the new OS for the first time. I typed my usual local password thrice, no luck. Did I accidentally gave my 1Password master password? Thrice, no luck. Did I accidentally used Vagrant's default password (i.e., `vagrant`, however unlikely)? This one is short enough and I didn't need to type it thrice to realize it was wrong — I knew that all along anyway. Did I... No, I couldn't have used anything else (literally ten minutes ago) without remembering it. I was completely horror-struck at that point, but speaking of remembering, I didn't even remember giving a password hint! So could it be... Yes, I typed in my 32 character long iCloud password, and this time it was right. I quickly realized after the fact that this setting could be toggled in the standard System Preferences -> Users & Groups -> Change Password... (see screenshot below), so if you are in this situation, don't panic. I don't like this move though. Hopefully Apple won't degrade to Microsoft's level at some future point, where you either sign in with a Microsoft account (and have to type your Microsoft password to log in) or miss out on cloud features with a local account.

![Screenshot taken after I've changed to a local password. After initial setup, it would be the reverse.](/img/20151001-osx-el-capitan-icloud-password-to-log-in.png)

Secondly, <u>three finger drag, a multitouch gesture that I use all the time to move windows on screen, is now mysteriously gone from System Preferences -> Trackpad</u> (it used to be in "Touch & Click"):

![Where's my beloved three finger drag? By the way, since it is shown in this screenshot, I'll officially declare here that I'm a tap-to-click wizard.](/img/20151001-osx-el-capitan-wheres-my-three-finger-drag.png)

Maybe Apple found it somewhat confusing with the three finger tap/click, which is clearly a different gesture. I found the solution in an Apple Support document, [Turn on "three finger drag" for your Force Touch trackpad](https://support.apple.com/en-us/HT204609), while my trackpad is clearly not Force Touch (the document was written for Yosemite, so clearly the reorganized settings started out on the MacBook One and newer Retina MacBook Pros in Yosemite and spreaded to all Macs in El Capitan). Anyway, the gesture could be turned on in System Preferences -> Accessibility -> Mouse & Trackpad Options... -> Enable dragging. That was godawful, no one could possibly find it, but hopefully it's hidden there because of the confusion rather than Apple intentionally phasing it out.

![Oh, there it is!](/img/20151001-osx-el-capitan-three-finger-drag-there-it-is.png)

[^state]: State information includes `~/.config` and `~/.local`, Google Chrome and Firefox profiles, Messages archive, Mathematica customizations, Unclutter notes, VMware Fusion inventory, various important plists, and so on and so forth.

[^existing]: Unless you are stupid enough to specify the `--delete` flag when you transfer in.

[^rootless]: As mentioned in [The sad state of Finder on El Capitan](/blog/2015-07-30-the-sad-state-of-finder-on-el-capitan.html), I've disabled SIP and am running XtraFinder. I simply can't live with the stock Finder, that is, without code injection.

[^mail]: Setting up mail accounts is the most painful thing in the world, especially if you have a dozen of them for different tasks.
