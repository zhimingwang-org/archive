---
title: "vobcopy, dvdbackup, etc."
date: 2014-11-02T15:06:07-0800
date_display: November  2, 2014
...

A few days ago, I was cloning my entire Audio CD and DVD collection, and reported some of the findings in [this post](/blog/2014-10-26-audio-cd-slash-dvd-to-iso-image-on-os-x.html). As said, the most important commands are

    hdiutil makehybrid -iso -joliet -o AUDIO_CD_NAME.iso SOURCE

for Audio CDs and

    hdiutil makehybrid -udf -o DVD_NAME.iso SOURCE

for DVDs.

Those alone don't finish the story. I also tried other things and unfortunately encountered problems. I was too busy to report back then, but now I'll summarize some of the findings.

---

For one thing, `hdiutil makehybrid` might fail, issuing an "Operation not permitted" for no obvious reason. This could even happen when you work with the Disk Utility GUI (for which I once got a "Permission denied"). Even `sudo` didn't help in my case. However, I was able to **circumvent the problem with the root shell** (I won't tell you how to enter the root shell — you need to at least have that amount of knowledge about the root shell before you are given the key). Not sure why. Just keep in mind that the root shell might help (that's also a general, albeit dangerous, advice for life).

---

Next onto grabbing the raw VOB.

`vobcopy` is pretty sweet, but at least for me it had one huge problem. When I tried to copy a single title, say title #2 with

    vobcopy --title-number TITLE_NUMBER -i SOURCE

other titles got copied, too. I didn't have enough samples to test out, but presumably it's because the problematic DVD has a structure like this:

![problematic DVD title structure](https://i.imgur.com/HTgmwQL.png)

Anyway, no matter I `vobcopy` title 01, 02, or 03, the result was the same — the whole thing. That's pretty stupid. I don't know if it counts as a bug or unfinished feature. Definitely not cool.

(One cool thing about `vobcopy`: as long as you complied with `libdvdread`, you can create a fully decrypted version of the DVD with

    vobcopy --mirror -i SOURCE

Of course, to get an iso image out of the decrypted mirror, you run the `hdiutil makehybrid -udf` command given above.)

---

So `vobcopy` is dead (for copying specific titles in unfortunate DVDs). What's next?

There's `dvdbackup`. The man page is good, and [ArchWiki](https://wiki.archlinux.org/index.php/dvdbackup#A_single_title) is even better (*ArchWiki is awesome!*), providing you cookbook solutions of combining the power of `dvdbackup` and `dvdauthor` (cookbooks are nice when dealing with unexciting technologies like DVD). In fact, `dvdbackup` alone is enough for extracting the VOBs of relatively small titles (< 1GiB):

    dvdbackup -i SOURCE -o VOB_TARGET_DIR -t TITLE_NUMBER -n TITLE_NAME

then grab your title-specific VOB in `VOB_TARGET_DIR/TITLE_NAME/VIDEO_TS`. Unlike `vobcopy`'s `-n/--title-number` option, `dvdbackup`'s `-t/--title` option does it right, trimming everything else. However, there's a problem when the title is larger than 1 GiB — then `dvdbackup` will split the VOB into several 1 GiB max pieces, and there's no way to disable this (since `dvdbackup` is targeting a DVD player — ancient technology — rather than `mpv` or whatever). What's sadder is that I can't seem to combine the split VOBs with FFmpeg stream copy — `pcm_dvd` audio always gets converted to `mp2` and fails when I use `-c copy`. I'm not a codec expert, but I suppose this is due to the fact that `pcm_dvd` isn't a supported encoding codec of FFmpeg (at least not my FFmpeg):

    > ffmpeg -codecs | grep pcm_dvd
    D.A..S pcm_dvd              PCM signed 20|24-bit big-endian

`D` is for "Decoding supported", `A` is for "Audio codec", `S` is for "Lossless compression" — no encoding support. By the way, my FFmpeg is `brew`ed with the options `--with-fdk-aac`, `--with-ffplay`, `--with-freetype`, `--with-libass`, `--with-libbluray`, `--with-openjpeg`, `--with-openssl`, `--with-x265`:

    > \ffmpeg -version
    ffmpeg version 2.4.2 Copyright (c) 2000-2014 the FFmpeg developers
    built on Oct 19 2014 14:09:36 with Apple LLVM version 6.0 (clang-600.0.51) (based on LLVM 3.5svn)
    configuration: --prefix=/usr/local/Cellar/ffmpeg/2.4.2 --enable-shared --enable-pthreads --enable-gpl --enable-version3 --enable-nonfree --enable-hardcoded-tables --enable-avresample --enable-vda --cc=clang --host-cflags= --host-ldflags= --enable-libx264 --enable-libfaac --enable-libmp3lame --enable-libxvid --enable-libfreetype --enable-libass --enable-ffplay --enable-libfdk-aac --enable-openssl --enable-libx265 --enable-libopenjpeg --disable-decoder=jpeg2000 --extra-cflags='-I/usr/local/Cellar/openjpeg/1.5.1_1/include/openjpeg-1.5 '
    libavutil      54.  7.100 / 54.  7.100
    libavcodec     56.  1.100 / 56.  1.100
    libavformat    56.  4.101 / 56.  4.101
    libavdevice    56.  0.100 / 56.  0.100
    libavfilter     5.  1.100 /  5.  1.100
    libavresample   2.  1.  0 /  2.  1.  0
    libswscale      3.  0.100 /  3.  0.100
    libswresample   1.  1.100 /  1.  1.100
    libpostproc    53.  0.100 / 53.  0.100

Maybe I missed some `--enable`.

Sorry for the digression. So, it's not possible to stream-copy-concat the VOBs with FFmpeg. (In fact, since audio quality is not that important — you won't be able to tell 256k AAC from lossless anyway, especially when you are focusing on the video, so you can always transcode `pcm_dvd` into 256k AAC with `-c:a libfdk_aac -b:a 256k`. `mpeg2video` is an encoding supported codec so stream copy works fine. Or you may also use `flac` or whatever encoding-supported lossless codec.) However, if you insist on getting the original `pcm_dvd`, there is a way, an ugly way. You've gotta be creative here. [ArchWiki](https://wiki.archlinux.org/index.php/dvdbackup#A_single_title) already provides a cookbook solution on how to use `dvdbackup` and `dvdauthor` to create a DVD with a selected title. And `vobcopy` can copy the entire thing just fine, without the 1 GiB limit (make sure to use the `-l/--large-file` option if the size is greater than 2 GiB). Therefore, you can create a DVD with selected title from the original DVD, then `vobcopy` from the new DVD. This is insane, but it works, I've tested that. **Note, however, that timestamps might be wrong with `vobcopy`, so the VOB runs just fine linearly but might run into problems when you seek.** Therefore, FFmpeg is still the way to go. Or maybe you can do it right with one click using some closed source software ☹ — I've heard about success stories with the long ceased DVD Decrypter Windows project. In reality, I guess only people with theoretical interest or OCD will ever do this — FLAC or AAC should serve everyone just fine. It should have worked with `vobcopy` alone, but it doesn't. Hence the workaround.

---

For future reference, I'll translate the ArchWiki cookbook solution here (it's too cookbook itself, specifying paths like `~/movie_name` and using unnecessary `cd`) about creating a title-specific DVD from a multi-title DVD (replace `SOURCE`, `VOB_TARGET_DIR`, `DVD_TARGET_DIR`, `TITLE_NUMBER`, and `TITLE_NAME` with sane values):

    dvdbackup -i SOURCE -o VOB_TARGET_DIR -t TITLE_NUMBER -n TITLE_NAME
    dvdauthor -t -o DVD_TARGET_DIR VOB_TARGET_DIR/TITLE_NAME/VIDEO_TS/*.VOB
    export VIDEO_FORMAT=NTSC
    cd DVD_TARGET_DIR/VIDEO_TS && dvdauthor -T -o DVD_TARGET_DIR

`export VIDEO_FORMAT=NTSC` is to avoid the `dvdauthor` error of "no default video format, must explicitly specify NTSC or PAL" (I'm not sure about the difference between NTSC and PAL, but I saw NTSC printed on my DVD, so I used it). And there you go, a shiny new DVD filesystem located in `DVD_TARGET_DIR`. (Note that unlike `vobcopy`, `dvdbackup` doesn't feature a nice progress bar even when `-v/--verbose` and `-p/--progress` are specified.) Then you can

    vobcopy -l DVD_TARGET_DIR

if you'd like to. Recall that timestamps might be wrong, sadly.
