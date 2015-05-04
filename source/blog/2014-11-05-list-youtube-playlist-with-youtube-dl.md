---
title: "List YouTube playlist with youtube-dl"
date: 2014-11-05 10:37:58 -0800
date-display: November  5, 2014
---
Of course you are always welcome to use the [Google APIs Client Library for Python](https://developers.google.com/api-client-library/python/) to wrestle with YouTube, which is usually pretty simple. (As an added bonus, YouTube has some [nice runnable sample scripts](https://developers.google.com/youtube/v3/code_samples/) to get you started.) With the client library, listing videos in a YouTube playlist is a breeze.

However, if you don't feel like writing code yourself (I usually don't feel like writing code myself until I use something often enough and existing solutions are suboptimal), `youtube-dl` recently added the functionality to list videos in a playlist with the `--flat-playlist` option.

[According to one of the project collaborators](https://github.com/rg3/youtube-dl/issues/4003#issuecomment-60322630), currently `--flat-playlist` is only helpful with the `-j` option for dumping JSON (so I suppose this feature is subject to change). For instance, `--flat-playlist` alone would emit something like this:

```bash
> youtube-dl --flat-playlist 'https://www.youtube.com/watch?v=gdOwwI0ngqQ&list=PLPpZI8R1zUfrkDbmJMOBhEbJ9Td9vbV-F'
[youtube:playlist] Downloading playlist PLPpZI8R1zUfrkDbmJMOBhEbJ9Td9vbV-F - add --no-playlist to just download video gdOwwI0ngqQ
[youtube:playlist] PLPpZI8R1zUfrkDbmJMOBhEbJ9Td9vbV-F: Downloading webpage
[youtube:playlist] PLPpZI8R1zUfrkDbmJMOBhEbJ9Td9vbV-F: Downloading page #1
[download] Downloading playlist: Cam By apinknomfan
[youtube:playlist] playlist Cam By apinknomfan: Collected 119 video ids (downloading 119 of them)
[download] Downloading video #1 of 119
[download] Downloading video #2 of 119
[download] Downloading video #3 of 119
[download] Downloading video #4 of 119
...
```

which doesn't really make sense — it tells you that it collected 119 video ids, and no more. Once you have `-j` on, you get JSON data that you can parse with anything:

```bash
> youtube-dl -j --flat-playlist 'https://www.youtube.com/watch?v=gdOwwI0ngqQ&list=PLPpZI8R1zUfrkDbmJMOBhEbJ9Td9vbV-F'
{"url": "gdOwwI0ngqQ", "_type": "url", "ie_key": "Youtube", "id": "gdOwwI0ngqQ"}
{"url": "j9l5nchv1Z8", "_type": "url", "ie_key": "Youtube", "id": "j9l5nchv1Z8"}
{"url": "znW5ALwWNQw", "_type": "url", "ie_key": "Youtube", "id": "znW5ALwWNQw"}
{"url": "qyE7-auTIcc", "_type": "url", "ie_key": "Youtube", "id": "qyE7-auTIcc"}
...
```

The most straightforward way to parse this is to use a command line JSON parser, the best one being [jq](https://github.com/stedolan/jq):

```bash
> youtube-dl -j --flat-playlist 'https://www.youtube.com/watch?v=gdOwwI0ngqQ&list=PLPpZI8R1zUfrkDbmJMOBhEbJ9Td9vbV-F' | jq -r '.id' | sed 's_^_https://youtube.com/v/_'
https://youtube.com/v/gdOwwI0ngqQ
https://youtube.com/v/j9l5nchv1Z8
https://youtube.com/v/znW5ALwWNQw
https://youtube.com/v/qyE7-auTIcc
...
```

There you go, a list of URIs you can use. Of course you can put this in a script to save some typing:

```bash
#!/usr/bin/env bash
# Takes a YouTube URI to a playlist (fairly liberal, it's fine as long
# as the playlist id can be extracted), and prints a list of URIs in a
# YouTube playlist.
#
# Requires youtube-dl 2014.10.24, tested on youtube-dl
# 2014.11.02.1. Feature subject to change.
youtube-dl -j --flat-playlist "$1" | jq -r '.id' | sed 's_^_https://youtube.com/v/_'
```

**_Aside:_** I first embedded the gist here, but [it looked a bit off](http://i.imgur.com/m3cr0Im.png). See [imathis/octopress#1392](https://github.com/imathis/octopress/issues/1392).

> In the next version of the Gist tag plugin we are just downloading the gists and embedding them upon generation so we don't have to worry about GitHub going down and breaking all your gists, or changing the HTML and breaking all the styles.
>
> For the time being I suggest embedding your code snippets directly if you want them to look good.

Okay. End of aside.

By the way, `youtube-dl` supports playlist bulk download natively. The reason I need a list of video ids or URIs, however, is that among other things, `youtube-dl` doesn't download highest resolution DASH video by default, so I have to rely on something like `youtube-dl-dash` ([link](https://github.com/zmwangx/sh/blob/master/youtube-dl-dash)) to download the best version.
