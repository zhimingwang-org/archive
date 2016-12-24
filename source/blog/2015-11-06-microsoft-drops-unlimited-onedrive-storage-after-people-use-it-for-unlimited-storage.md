---
title: "Microsoft drops unlimited OneDrive storage after people use it for unlimited storage"
date: 2015-11-06T10:49:51-08:00
date_display: November 6, 2015
---

[Story on Ars Technica](http://arstechnica.com/information-technology/2015/11/microsoft-drops-unlimited-onedrive-storage-after-people-use-it-for-unlimited-storage/). [Official announcement](https://blog.onedrive.com/onedrive_changes/). I was playing catch up on this week's RSS when this one punched in my face.

I currently have 5 TB of data in OneDrive. I was once worried about lock-in when I eventually have 20 or 100 TB there, but now that they have shown their true colors, the worries are all gone. They are not even offering anything past 1 TB. We have seen this too many times — shit happens when people actually use unlimited for unlimited. Usually unlimited quickly becomes qualified, but in this case, unlimited simply becomes limited. What irony when one looks back at their announcement from [a year ago](http://localhost:8000/blog/2014-10-27-onedrive-goes-unlimited.html):

> Today, storage limits just became a thing of the past with Office 365.

Why even promise when they can't keep it for more than a year.

Okay, Microsoft just reclaimed the top spot of my most-hated-companies list, and my [ongoing efforts on making a usable OneDrive CLI](https://github.com/zmwangx/pyonedrive) have been wasted. I just pushed the final commit and closed all issues. Maybe it's a blessing that I'll no longer need to deal with that slow and glitchy API; I'll see after experimenting with APIs of other cloud storage providers.

Guess my next stop is either Amazon Cloud Drive or S3, probably the former so that I don't need to calculate.[^calculate] And a quick search yields an actively-maintained CLI client [yadavada/acd_cli](https://github.com/yadayada/acd_cli), so I may not need to roll my own this time (it depends on usability).

[^calculate]: Yeah I'm a mathematician, but I hate most calculations that involve $$. &#128514;
