---
title: "The Google Chrome Comic — A classic"
date: 2014-12-14T17:42:55-0800
date-display: December 14, 2014
---
I was cleaning up my Opera bookmarks just now — I'm semi-officially leaving Opera for Safari. Of course, Safari still can't handle everything (e.g., Adblock Plus is still not so good on Safari, YouTubeCenter lags behind and I don't bother to compile myself — yes, I have a certificate, and some power user features simply don't exist), so I'm still going to Opera/Opera beta/Chrome/Firefox for certain tasks. But Safari is very nice. For the first time.

I started out as a Chrome user (well, don't want to recall the IE days), branched out to the Chromium Opera, and now ended up in Safari. Not sure about the future. When I look back, something nostalgic pops up in mind — [the Google Chrome Comic](http://www.google.com/googlebooks/chrome/). I enjoyed it more than once, but I never seemed to have archived it. So here it is, combined into [one PDF](https://dl.bintray.com/zmwangx/generic/2008-chrome-comic.pdf). In fact, you can create the PDF yourself:

```
seq 0 39 | parallel wget -q http://www.google.com/googlebooks/chrome/images/big/{}.jpg
convert $(ls -v *.jpg) 2008-chrome-comic.pdf
```

Here I was a bit lazy and used a GNU `ls` feature: `-v` for natural sorting of numbers (doesn't work for BSD `ls`).

And here's page 1 of the comic as a teaser:

![Google Chrome — Behind the Open Source Browser Project](https://i.imgur.com/W5pJTjl.jpg)
