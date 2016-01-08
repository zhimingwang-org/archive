---
title: "The new OneDrive API"
date: 2015-02-24T18:31:19-0800
date_display: February 24, 2015
---

Microsoft released the new OneDrive API today. See the blog post announcement [here](https://blog.onedrive.com/the-new-onedrive-api/). One highlight is that [large file upload](http://onedrive.github.io/items/upload_large_files.htm) is now officially supported. Previously, large file upload was handled with a semi-official API using the BITS protocol; the only documentation was a [gist](https://gist.github.com/rgregg/37ba8929768a62131e85). Now it is handled through standard HTTP `POST`. With this major release, there's likely a lot of work to be done with [python-onedrive](https://github.com/mk-fg/python-onedrive). I have opened an issue: [mk-fg/python-onedrive#52 — New OneDrive API support](https://github.com/mk-fg/python-onedrive/issues/52).

Interestingly, the new OneDrive API doc is hosted on GitHub Pages — [onedrive.github.io](http://onedrive.github.io), rather than MSDN. Exactly a week ago I wrote a piece, "[Microsoft is getting cool (but not its website)](/blog/2015-02-17-microsoft-is-getting-cool-but-not-its-website.html)". Looks like they are doing something about their website (or better put, their online identity), too.
