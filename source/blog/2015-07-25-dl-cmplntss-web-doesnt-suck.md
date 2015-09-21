---
title: "dl? cmplnts?'s web doesn't suck"
date: 2015-07-25T11:31:54-07:00
date_display: July 25, 2015
---
I was reading [Les Orchard's *The Verge's web sucks*](http://blog.lmorchard.com/2015/07/22/the-verge-web-sucks/) just now, and inspired by his dignostics of his various daily reads, I also ran the performance meter on my very own blog. Fortunately, it doesn't suck[^firefox]:

> 13 requests, 77.88 KB, 0.84s.

Moreover, apart from a Google Analytics snippet and the occasional embedding with a `<script>` tag, this site is entirely static.

[^firefox]: Diagnostics generated on Firefox Developer Edition 41.0a2.

![HTTP requests upon visiting <https://zmwangx.github.io/> (commit [3af1eaf](https://github.com/zmwangx/zmwangx.github.io/tree/3af1eafde5afa9fbb4255135191d6d232cf81cee)).](/img/20150725-performance-of-my-blog-requests.png)

![The breakdown.](/img/20150725-performance-of-my-blog-breakdown.png)
