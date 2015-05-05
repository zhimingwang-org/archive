---
title: "Original images in Day One journal"
date: 2014-11-26T00:22:16-0800
date-display: November 26, 2014
---
**TL; DR:** Jump to the paragraph beginning with “workaround”.

---

I started a Day One journal two days ago. I've heard good things about Day One, but after using it for a dozen entries, I'm not that satisfied. For one thing, the editor is pretty horrible — keybindings aside, I can’t even find and replace?! And the overview doesn’t look very pretty if you are a heavy Markdown user (i.e., you have a lot of markups, e.g., italics and inline links) — the markups are displayed as is. Moreover, I can’t even `#` my title: it kills the bold font rendering in the bird’s-eye view. What a let down. Anyway, it’s better than nothing, and I hope it will help me keep on track. (I used to manage a Markdown journal in an encrypted sparse bundle, and it was a pain in the ass — mentally. Maybe some GUI sugar is necessary, although Day One is certainly not as pretty as advertised.) Also a private journal means more privacy — I certainly don’t want to publish everything I write on this public blog.

Too much irrelevant talking. Onto one of the most annoying “features”, and the subject of this post. Images are automatically JPEG-compressed when imported into Day One. See [this support article](https://dayone.zendesk.com/hc/en-us/articles/200145875-Are-photos-resized-when-imported-into-Day-One-), which says:

> Every photo imported into Day One is converted to JPEG format and resized to a maximum resolution of 2100 x 2100 pixels. The aspect ratio is maintained. We resize photos for more efficient sync and storage. At this size the average photo is about 700KB which means you can store:
> * Dropbox: 2,500+ photos using the free 2GB account
> * iCloud: 6,000+ photos using the free 5GB account

What the heck. Dude, who cares about storage these days? And transfer rate? I have a gigabit Ethernet. I certainly have much more than 2GB in my Dropbox. Even for those underpriviledged folks with only 2GB, remember, Day One allows *only one photo per entry*. That’s 2,500+ entries. At any rate, this should be an opt-in rather than an uncustomizable “feature”. I’m about to submit a ticket, but I doubt the outcome (I’m sure many people have submitted tickets about the plain text format even when password-protected, but so far, no response).

With photos, most of the time JPEG compression works pretty well (but people surely want to keep photos in highest quality). However, I’m a techie guy, and my images are often screenshots or precision images, where JPEG compression totally ruins the sharpness.

Workaround? Simple (yet a bit annoying). Day One lets you show the photo in Finder. So just go ahead and replace that compressed image with the original using `cp` or `mv`. I shouldn’t have needed to do this, but every piece of software comes with some annoyances. Overall Day One’s pretty good — at least it does what it was designed for, albeit not perfectly.

---

By the way, here is my support ticket:

> I understand that Day One does JPEG compression to every imported photo, as written in the support article “Are photos resized when imported into Day One?” http://goo.gl/Rzi017 . Yet I beg an option. The reason is that the benefits outlined in the support article are virtually non-existent:
>
> * “More efficient sync and storage”: these days transfer rates are really high with SSDs and gigabit Ethernet, so reducing a few hundred KBs won’t help me the slightest;
>
> * “Dropbox: 2,500+ photos using the free 2GB account”: I have much more than 2GB in my Dropbox; even if I only have 2GB, Day One allows only one photo per entry, and that means 2,500+ entries with photos, which is more than enough for most users, I suppose. By the way, Dropbox storage shouldn’t be your concern; people will buy more when they need more.
>
> And some of the bad things about JPEG compression:
>
> * JPEG compression usually works pretty well with photos, but when I import high precision images, the sharpness is totally ruined;
>
> * People want to keep their photos in highest quality, which is defeated by forced compression.
>
> I know an ugly workaround, which is simply replace the compressed image with the original in the filesystem. But I would love to see an option to import images as originals (in fact, compression should be an opt-in). Really, transfer rates and storage grow so rapidly that they are not people’s primary concerns anymore. (For your information, OneDrive recently rolled out truly unlimited storage to Office 365 subscribers. Online storage is that cheap.) Thanks.
