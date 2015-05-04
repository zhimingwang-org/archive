---
title: "Ripping copy-protected DVD with mpv"
date: 2014-10-23 20:03:22 -0700
date-display: October 23, 2014
---
**_11/02/2014 update:_**

See [this post](/blog/2014/11/02/vobcopy-dvdbackup-etc/) for issues, explanations, and more.

---

**_10/25/2014 update:_**

I'm such an idiot. `vobcopy` is the real, hassel-free way to go.

    brew install vobcopy

Then, with the DVD mounted,

> **vobcopy** without any options will copy the title with the most chapters into files of 2GB size into the current working directory.

Of course there are a ton of options, but I generally hate to browse through options unless I have to, so I'm happy with calling without argument.

---

Yesterday I was trying to rip a music video off a newly released DVD from Japan. I knew very little about how DRM (in this case, CSS) actually works and how to break it. I tried to operate directly on the VOB file with `ffmpeg` or `mpv` but both failed with a lot of header errors — I suppose more files than the VOB are required for authentication? Whatever, maybe I’ll learn the details in the future, but I don’t see the need since DVD is an outdated technology anyway.

So, can we proceed from here? Most certainly. I noticed that although `mpv` won’t let me play a single VOB, I can simply hand it the DVD mount point, and it will play the whole DVD seamlessly. **Caution:** `mpv` needs to be compiled with `libdvdnav` and `libdvdread`! With brew you just do

    brew install mpv --with-libdvdnav --with-libdvdread

For better performance and backup, I first cloned the DVD into a `.cdr` image (DVD/CD-R Master Image) using Disk Utility (I've never tried creating/cloning image with `diskutil` CLI, so nothing to report on that). Then I mount the image, say the mount point is `/Volumes/UPBX_80165`. As said I can hand that mount point to `mpv` and it simply works, but how about extracting the MPEG-2 video stream? The `--stream-capture=<filename>` option is there just for you. In principle `--stream-dump=<filename>` should also work, but without monitoring the output and controlling where to end, I’m not sure if it will ever terminate itself when reading from a DVD (when I stream captured the DVD it just kept repeating itself until I explicitly quit with `q`). So that's it:

    mpv --stream-capture=dump.mpg /Volumes/UPBX_80165

Then you can torture the `dump.mpg` with `ffmpeg` however you want. The most obvious thing is to cut out the music video part, and put into a new container like MPEG-TS. Or transcode it to H.264 for your iPhone. The nice thing about `dump.mpg` is that, unless I got it wrong, there's no quality loss here — the only thing you got rid of is that goddamn DRM.
