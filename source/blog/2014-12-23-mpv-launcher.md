---
title: "mpv launcher"
date: 2014-12-23T00:51:05-0800
date-display: December 23, 2014
---
**_04/06/2015 update:_**

I just noticed that `daemonize` doesn't play too well with the OS; in particular, when you use dark menu bar on OS X Yosemite, apps launched with `daemonize` won't conform to that. So a native shell solution would be using `/bin/zsh` and run

```zsh
mpv $@ &>/dev/null </dev/null &!
```

instead.

---

[`mpv`](http://mpv.io) is a nice simplistic video player (fork of MPlayer and mplayer2). The CLI is flawless (and you can run as many instances as you want), but when it comes to the OS X application bundle, there's one major annoyance. Each app bundle could only have one running instance (unless `open -n`’ed, which is not how sane people use app bundles), and one instance of `mpv` only supports one video. So, say I'm playing one video with the app bundle, and unsuspectingly opens another in Finder (which is associated to `mpv.app` by default), then the latter video immediately takes over, and the position in the first video is lost. That happens *a lot*.

Today I finally gave this issue some serious thought (I've been on a bug report/enhancement request spree these days so it's natural for me to start thinking about enhancements). Turns out that there's a pretty simple workaround. I created an automator app `mpv-launcher.app` that does one thing: "Run Shell Script" (pass input as arguments)

```bash
daemonize /usr/local/bin/mpv "$@"
```

in the shell of your choice (for me the shell of choice is `zsh` since the env would be readily available from my `zshenv`). `daemonize`, as the name suggests, daemonizes the process so that the process doesn't block; this way, `mpv-launcher.app` immediately quits after launching, making multiple "instances" possible. (`daemonize` can be installed via `brew install daemonize`; note that you need to specify the full path of the command to daemonize, which in my case is `/usr/local/bin/mpv`). And there you go. Associate your video files to `mpv-launcher.app`. Launch as many instances as you want. Enjoy.

By the way, I also filed an [enhancement request](https://github.com/mpv-player/mpv/issues/1377) with `mpv-player/mpv`. We'll see what the developers can do. Hopefully the app bundle will support multiple videos out of box in the future.
