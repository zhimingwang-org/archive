---
title: "Apple turns its homepage into a WWDC liveblog"
date: 2015-06-08T14:42:50-07:00
date-display: June 8, 2015
---

WWDC is Apple's biggest event every year, and WWDC keynote always attracts tons of hype. Apple knows that. In the past years folks who can't (at work, in class, etc.) or don't want to watch the crappy live stream would follow the various WWDC liveblogs presented by tech sites like Gizmodo, TechCrunch, Ars Technica, etc. But this year the landscape has changed: Apple rolled its own card-based liveblog at [www.apple.com/live/2015-june-event](http://www.apple.com/live/2015-june-event/).[^stream] Not only that; during the keynote, Apple redirected its homepage to the liveblog page, so it effectively turned its homepage into a liveblog:

[^stream]: The crappy live stream is still there, but thankfully you wouldn't see it if you're on a browser other than Safari. Just look the screenshot of the banner.

```zsh
> curl -sSIL http://www.apple.com
HTTP/1.1 302 Moved Temporarily
Location: http://www.apple.com/live/
Content-Length: 210
Content-Type: text/html; charset=iso-8859-1
Expires: Mon, 08 Jun 2015 19:16:41 GMT
Cache-Control: max-age=0, no-cache, no-store
Pragma: no-cache
Date: Mon, 08 Jun 2015 19:16:41 GMT
Connection: keep-alive
Server: Apache

HTTP/1.1 301 Moved Permanently
Content-Length: 0
Date: Mon, 08 Jun 2015 19:16:41 GMT
Connection: keep-alive
Server: Apache
Location: http://www.apple.com/live/2015-june-event/

HTTP/1.1 200 OK
Last-Modified: Mon, 08 Jun 2015 15:45:30 GMT
ETag: "0b7bcbfbd14c411e64e728ae4d644de7"
Content-Type: text/html
Cache-Control: max-age=298
Date: Mon, 08 Jun 2015 19:16:41 GMT
Connection: keep-alive
Server: Apache
```

Of course, you miss a few jokes and random shots of Tim or Craig from the official liveblog, but hey, who don't like that official feel?[^official]

[^official]: Yeah, I know some people don't; but those people are not likely to be Apple fans either.

Here are a few screenshots of today's liveblog. Unfortunately I only know some entry level JS, so I wasn't able to capture the entire page, which uses dynamic DOM based on one's position in the page.

![The banner on Chrome.](/img/20150608-wwdc-2015-banner.png)

![Introducing OS X El Capitan, 960x981.](/img/20150608-wwdc-2015-liveblog-960x981.png)

![A fuller experience: 1920x1080.](/img/20150608-wwdc-2015-liveblog-1920x1080.png)

By the way, here are the full-page screenshots of [OS X 10.11 El Capitan](http://www.apple.com/osx/elcapitan-preview/) and [iOS 9](http://www.apple.com/ios/ios9-preview/) previews. `pageres` recently [cannot render web fonts](https://github.com/sindresorhus/pageres/issues/174), which is rather annoying, so I used [Full Page Screen Capture](https://github.com/mrcoles/full-page-screen-capture-chrome-extension) to capture the shots. I then resized to 50% to reduce filesizes a bit.

![[OS X El Capitan](http://www.apple.com/osx/elcapitan-preview/)](/img/20150608-osx-el-capitan-preview-1920x1080-50%25.png)

![[iOS 9](http://www.apple.com/ios/ios9-preview/)](/img/20150608-ios-9-preview-1920x1080-50%25.png)
