---
title: "All problems solved!?"
date: 2015-06-23T21:47:07-07:00
date_display: June 23, 2015
---

The project I've been working on intermittently over the past month, [`pyonedrive`](https://github.com/zmwangx/pyonedrive), a OneDrive API v1.0 API/CLI client, is now quite satisfactory in terms of its feature set[^1], so today I'm thinking about what I should work on next. Of course there's [a lot more I can do](https://github.com/zmwangx/pyonedrive/labels/enhancement), but what is done already encapsulates 95%+ of my daily usage; moreover, as everyone knows, refining an existing project is not as exciting as starting a new one and making something happen that is previously tedious or impossible.

[^1]: In fact it already exceeded my original expectations — `pyonedrive` started out as a [bare bones batch uploader](https://github.com/zmwangx/pyonedrive/blob/4d21308545ec1462c3892b9ca25300042f1ccb81/README.rst).

To my surprise, *I can't think of anything*. I now realized that I don't have many peculiar computing needs. I needed a storyboard generator which I couldn't find anywhere, [so I wrote one](https://github.com/zmwangx/storyboard), and got an [elegant FFprobe wrapper](https://storyboard.readthedocs.org/en/latest/metadata-cli.html) for free. I hated the crappy CLI shipped with [`python-onedrive`](https://github.com/mk-fg/python-onedrive)[^2] that constantly fails and dumps, so I [rolled my own](https://github.com/zmwangx/pyonedrive) around the new API. In the process of coding up these two things, I learned quite a bit of Python — the kind of things I would never learn by reading tutorials or references alone. Other than these two, I need to interact with a few Web services and scrape a few Web sites, which are easily taken care of in bash/zsh/python (node might better serve some, but they ain't broke, so why rewrite). I also need some other CLI tools but those have been solved by existing projects, probably started by people with similar needs. Some of them need some clean-up and feature boost, e.g., [`you-get`](https://github.com/soimort/you-get), but I'm not inclined to refactor or submit substantial PRs to other people's projects, so I usually just write my own wrappers to bypass their limitations.[^3] What else? Basically nothing.

[^2]: I never bothered to look at the API.

[^3]: E.g., for `you-get`, I wrote a wrapper with concurrency support and much more surrounding `you-get`'s `--url` option. (But honestly, for whatever reason, links provided by `flvcd.com` for Chinese video streaming sites are much better than those parsed by `you-get` in terms of download speed, so these days I almost use `flvcd.com`'s `BigRats` exclusively, except when it similarly can't pick up a reasonable speed, in which case I would grind with my `you-get` wrapper, which was designed exactly for grinding.)

So I'm in a strange situation that I feel like writing software for fun and profit, but don't have anything exciting to lay my hands upon (other than improving existing things). Of course I could learn my next language, but language learning without real world usage is likely to be futile. For instance, I would like to learn some Go or Rust, but why do I need a compiled, C/C++ replacement these days, when scripting takes care of all my personal needs? Not clear. Maybe it's a good time to concentrate on the real important things in my career.

---

Update: Whilst writing this post, I came up with a project after all. I always had the idea of keeping an encrypted journal — real encryption, not the fake "password protection" of DayOne.[^dayone] The journal should be decrypted — probably only into memory — upon entry (after securely typing in password), and each text/image object should be encrypted separately to ease syncing (so using an encrypted sparseimage won't work).

In principle an Emacs package should be able to do this, but going forward Elisp is a pretty horrible choice of language for anything substantial (think of, for example, threading, which there is none). Therefore, I'm inclined to write this in ObjC/Swift with Cocoa. This will be my first attempt at Cocoa programming, and my first serious involvement with Xcode (other than CLT, of course) after quite a few years[^xcode]. Actually I've always been looking for an excuse to learn some Swift.

Oops, am I falling into [prematurely announcing my plans](https://sivers.org/zipit)? Hopefully not.

[^dayone]: And DayOne's Markdown engine sucks, among other limitations, like the ridiculous one-image-per-entry.

[^xcode]: I used to use Xcode as a C++ IDE before I was introduced to the brave new world of command line wizardry.
