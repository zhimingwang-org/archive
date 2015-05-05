---
title: "Google Drive — no selective subfolder sync?"
date: 2014-10-28T20:49:24-0700
date-display: October 28, 2014
---
Up to this point I've been using Google Drive as an online backup service, and uploads files mostly manually, although I do sync `~/img` with the client.

**Aside.** Google Drive, OneDrive, etc. don't work with symlinks. Wanna keep your stuff free and duplicate-free yet still synced to the servers? Use `rsync` to automatically reproduce your folder structure with hard links:

    rsync -avzP --delete --link-dest=SOURCE/ SOURCE DESTINATION

e.g.,

    rsync -avzP --delete --link-dest=~/img/ ~/img/ ~/sync/GoogleDrive/img/

automatically reproduces my `~/img` in the `img` directory under Google Drive's root, yet every file in the `~/img` tree is replaced by hard links to the original file, so the new structure within Google Drive takes little additional space — for the directories only.

That doesn't solve every problem though, as you will see shortly. *End of aside.*

So, up to this point I’ve mostly used Google Drive as an online backup service by manually uploading (huge) stuff. But at some point I’m gonna automate parts of the uploading. As it turns out, I can keep some smaller video files on my hard drive; other bigger monsters (like movies, TV shows, etc., especially a lot of 1080i Transport Streams directly from TV broadcasts) are uploaded and then moved to external drives. Some of the smaller files, including things downloaded from YouTube, live in `~/vid/etc`, and I want to sync this folder to Google Drive. What's shocking is that this is not possible with the Google Drive client — it only allows selective syncing of the top level folders. Let me repeat this:

**The Google Drive client only allows selective syncing of the _top level folders_.**

This is *insane*. It’s almost 2015. Everyone supports this — Dropbox, Microsoft, Box, even Baidu. Google Drive launched on April 24, 2012, that’s 2.5 years ago. [This thread](https://productforums.google.com/forum/#!topic/drive/Gs2w1BL-B9U) on Google Drive Forum, “Ability to sync only selected sub folders”, was posted on August 27, 2012, and has garnered 139 replies. They are ignored by the developers, and the accepted “answer” is to utilize Google Drive’s assign-one-file/folder-to-multiple-folders feature to create a special “sync” directory. Okay, that’s a stupid hard link solution on the server side. Okay, if that works… *No*. “Hard links on the server side” cannot bear different names; so what if I want to sync, say, both `vid/etc` and `aud/etc`? Whoops. So I also have to do all sorts of ugly renaming. NO, GOOGLE, NO, I won't accept that much trouble.

This kind of insanity makes me wander:

**Do the Google Drive developers use Google Drive themselves?**

For now I'm moving `vid/etc` to `vid_etc`. Sigh.

---

There are other problems that I encountered with Google Drive sync today. For one thing, it rejects what I already have and insists on starting from scratch. I mean, say I have uploaded a folder via the web interface, and later wants to keep it in sync (of course that's only possible if it's top level), so I put what I already have there. Nope, Google Drive reports that as a conflict and insists on downloading all the stuff again. Apart from wasted traffic, that also ruins my hard links, so I have to either wipe everything clean on the server side and reupload, or redownload everything and redo all the hard-linking after the download finishes. Either way, very annoying. I opted for the first one. (I later empirically confirmed that OneDrive could handle this situation.)

There are other problems that don't pop right off my mind. Anyway, the gist is,

**Google Drive is not yet sync-ready for power users (maybe even laymen).**

---

Then, is OneDrive perfect? No. I know it recently went unlimited, but there’s one major annoyance: the speed. Stanford’s Ethernet speed is almost 1 Gbps UL/DL, but the OneDrive client tops out at about 2 MBps. The web interface isn’t much better. Google Drive is a lot faster than that, which makes it a good backup service for manual uploading. Anyway, maybe OneDrive will improve over time; yesterday they delivered an update to OneDrive.app, and at least it finally works.

OneDrive also boasts no file status indicators on OS X, which everyone else in the industry has. That’s not a show-stopper though, if you just use it as a backup service.

---

What about Dropbox? Dropbox is a truly awesome sync-ready service, but it is at the same time pretty expensive compared to others. Also, since I use Dropbox as a sync service, it must be up at all times and constantly indexing, so I’m really cautious with what I put there to avoid unnecessary cycles and startup time.

---

Everything is broken in one way or another. Sigh. Let's hope that OneDrive improves a lot in the coming months; if it's stable enough and the speed gets some boost, I'll cancel my Google Drive subscription. I am a Google supporter and Microsoft hater, but a service that *works* is more important than ideology.
