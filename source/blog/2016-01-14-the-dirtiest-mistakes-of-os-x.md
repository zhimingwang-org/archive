---
title: "The dirtiest mistakes of OS X"
date: 2016-01-14T01:02:52-08:00
date_display: January 14, 2016
---

I must have written about this elsewhere, but here are my top three:

1. `.DS_Store`. Finder litters faster than one could clean up.

2. HFS+ NFD*.[^nfd] Heard of the cursed encoding `UTF8-MAC`? Pure Evil. Culprit of
   tons of garbled text issues (especially cross platform ones) and probably
   most length miscalculation issues. Even Apple's Terminal.app can't do NFD
   right. I wonder how Korean users navigate their filesystems in terminal.

3. Plist XML. It's XML, but even worse.

[^nfd]: NFD with an asterisk, i.e., not even NFD. According to Apple in
    [an old Technical Q&A](https://developer.apple.com/library/mac/qa/qa1173/_index.html),

    > The terms used in this Q&A, precomposed and decomposed, roughly
    > correspond to Unicode Normal Forms C and D, respectively. However, most
    > volume formats do not follow the exact specification for these normal
    > forms. For example, HFS Plus (Mac OS Extended) uses a variant of Normal
    > Form D in which U+2000 through U+2FFF, U+F900 through U+FAFF, and U+2F800
    > through U+2FAFF are not decomposed (this avoids problems with round trip
    > conversions from old Mac text encodings). It's likely that your volume
    > format has similar oddities.

    They are conscious enough to call these oddities.
