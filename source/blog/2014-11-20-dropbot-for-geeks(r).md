---
title: "Dropbot for Geeks®"
date: 2014-11-20T09:48:15-0800
date_display: November 20, 2014
---
I propose the following cloud storage and syncing service model of the future. I call it **Dropbot for Geeks®**, and it totally rules. It's designed for geeks who are tired of the highly limited, miserably unproductive traditional services (based on clicking around). It has the following features:

* Standard Unix file system commands exposed as an API, e.g., `cat`, `cd`, `cp`, `du`, `df`, `file`, `find`, `head`, `ln`, `ls`, `mkdir`, `mv`, `pwd`, `rm`, `rmdir`, `tail`, `touch`, etc.
* A rudimentary shell emulator through the web interface exposing the commands above.
* Secure shell access to the file system, also exposing the commands above. Provide two-factor auth for SSH. Clearly, `scp` should also be supported.
* Checksums. Expose, for instance, `md5sum` or `sha1sum`, in the API. Provide checksums on download pages, probably on demand.
* Programmable selective syncing, down to per file level.
* Scriptability. Allow clients to run custom scheduled jobs or daemons with the API above. To prevent the service from becoming full-featured IaaS, though, clients might be limited in CPU time, memory, or command selection. This bullet point is arguable.

---

With the level of command line integration illustrated above, we'll finally get rid of clicking around and not being able to automate chores. Navgating the remote file system will be a breeze — click, click, click, click, click (sometimes click should be replaced by double click, which is even more painful) just to navigate to a directory will be made a thing of the past. `ln`, in particular, saves disk space for duplicates — Dropbot for Geeks does *not* want to charge you extra for multiple copies of the same file in different directories. (To facilitate syncing hardlinks, clients should be able to specify hardlinked files in a config file. Or maybe some better mechanism. This might be hard.) At last, checksums are a must. I’ve had traumatic experiences like having downloaded an eight-part RAR, 1 GiB each, only to find that it wouldn’t unRAR. Without checksums, it was impossible to find which part was corrupted. As a result, I had to re-download everything — a nightmare. I never want to experience similar problems again. Hence the precious checksums.

Dropbot for Geeks looks like a pretty good (well, not really, but at least pretty cool®) model. Maybe I should patent it before anyone else? Then if some similar service surfaces in the future, I can [sue their ass off and enjoy some hot cash](http://arstechnica.com/tech-policy/2014/11/jury-apple-must-pay-23-6m-for-old-pager-patents/).
