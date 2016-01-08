---
title: "Convert Audio CD/DVD to ISO image on OS X"
date: 2014-10-26T23:29:47-0700
date_display: October 26, 2014
---

**_11/02/2014 update:_**

See [this post](/blog/2014-11-02-vobcopy-dvdbackup-etc.html) for issues, explanations, and more.

---

Today it occurred to me that I should make clones of my audio CDs (as stand-alone ISO images, I mean, not just rsyncing the AIFFs to subdirectories in `~/aud/lossless`). One can never have too many backups.

Of course I could simply pack the aforementioned directories with AIFFs into ISOs — that’s not impressive. The end result might actually be the same, but I want to make the clones directly from the original CDs. It turns out that this is not so simple with the Disk Utility GUI — unlike DVDs, the “New Image” option is grayed out for Audio CDs. I’m not sure why, but maybe they want you to just use iTunes to deal with Audio CDs (which works well for all practical purposes — but theoretical curiosity never ends).

So there comes `hdiutil`. `hdiutil` and `diskutil` are the utilities underlying Disk Utility. Unfortunately, so far I know little about them except for simplest things like `diskutil list`, `diskutil mount`, `hdiutil attach -stdinpass`, etc. (I'm so ignorant about anything filesystem related!) The `hdiutil` verb that makes cross-platform CD or DVD is `makehybrid`, which supports the following filesystem options: `-hfs` (holy crap, no HFS+ please! Apple ought to replace this thirty-year-old filesystem — ZFS or something better please!), `-iso`, `-joliet`, and `-udf`. For Audio CDs you use `-iso` and with `-joliet` extension:

    hdiutil makehybrid -iso -joliet -o AUDIO_CD_NAME.iso SOURCE

where `SOURCE` can be the mount point, the disk device file, etc. Similarly, although you can create `.cdr` images from DVDs via the Disk Utility GUI, you can also do it with `hdiutil` (which is potentially more portable — I’ve never heard a definitive answer of whether renaming `.cdr` to `.iso` really cross-platform):

    hdiutil makehybrid -udf -o DVD_NAME.iso SOURCE

This way CSS keys *seem* to be cloned as well, since I was able to authenticate such a CSS-protected DVD with `libdvdread`.

---

P.S. I sincerely hope that one day lossless music tracks are no longer distributed through CD-ROMs. So painful — even my Internet speed is more than ten times faster than the [highest transfer rate](https://en.wikipedia.org/wiki/CD-ROM#Transfer_rates) available from any CD-ROM. (I’ve heard about some websites distributing lossless music digitally, but that won’t happen to the music I care about in the near future.) I still like physical albums though — a real sense of possession. Maybe they should contain the physical goodies and some sort of access codes?
