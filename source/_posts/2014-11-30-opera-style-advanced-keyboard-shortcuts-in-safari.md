---
layout: post
title: "Opera-style advanced keyboard shortcuts in Safari"
date: 2014-11-30 17:20:20 -0800
comments: true
categories: 
---
I've been using the Chromuim Opera for a long time, after Chrome's design went unbearably ugly around v32 (IIRC Opera stable channel was on v19 when I switched, which was released on January 28, 2014). From then on, Opera's [advanced keyboard shortcuts](http://help.opera.com/opera/Mac/1583/en/fasterBrowsing.html#advanced) has become an integral part of my browsing habit. In particular, the following are especially handy for me:

* `1`: Cycle left through tabs;
* `2`: Cycle right through tabs;
* `/`: Find on page;
* `Z`: Go back one page;
* `X`: Go forward one page;
* `0`: Zoom in;
* `9`: Zoom out;
* `6`: Reset zoom to 100%.

Lately, with the Yosemite release, Safari has become a much more competitive browser. I won't say why, and I admit that it has major missing features that still prevents it from becoming my default — but I have to say I’m gradually moving more of more of my browsing, especially reading, to Safari. It would be nice if I could carry my power user shortcuts with me. Fortunately, this is possible. Just modify the plist in the following way:

```bash safari-advanced-keyboard-shortcuts.sh
#!/usr/bin/env bash
defaults write -app Safari NSUserKeyEquivalents '{
"Actual Size"="6";
"Back"="z";
"Find"="/";
"Forward"="x";
"Show Previous Tab"="1";
"Show Next Tab"="2";
"Zoom In"="0";
"Zoom Out"="9";
}'
```

Relaunch Safari. You are all set! Enjoy the ultrafast single key navigating experience.
