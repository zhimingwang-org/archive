---
title: "Using a personal helper package in everyday scripting"
date: 2015-05-30T22:48:57-07:00
date_display: May 30, 2015
---

Recently I've been scripting (mostly in Python) quite a bit, and noticed that some functionalities get copied over or reimplemented over and over again. Examples include reading configuration files (mostly JSON, INI, and YAML), printing progress information to tty in color, displaying progress bar, and so on.

In light of this, I came up with the idea of keeping a pool of helper modules in a personal helper package. I'm unimaginative at naming things, so I just named my package `zmwangx`. It is [published on GitHub](https://github.com/zmwangx/pyzmwangx), and the API docs are published on [Read the Docs](https://pyzmwangx.readthedocs.org) for easy reference during scripting.[^doc] At the time of writing the following helper modules are available in the package:

[^doc]: I'm pretty paranoid about documenting things.

* `colorout       -` colorized output to stdout and stderr, and much more.
* `config         -` read and write config files of various common formats.
* `hash           -` hash files in a memory-efficient manner.
* `humansize      -` convert size in bytes to human readable string (IEC or SI).
* `humantime      -` convert duration in seconds to human readable string.
* `infrastructure -` testing infrastructure.
* `pbar           -` display progress bar for the progress of processing a file or stream.
* `urlgrep        -` parse and match URLs from HTML documents.

With a personalized helper package, scripting has never been more enjoyable. Here are just some of the benefits:

* Stating the obvious: write once, use everywhere (without copy/paste);
* As always, factoring out small functional units make code more readable and easier to debug; and having a dedicated pool just for helper modules encourages one to think about factoring, *early*;
* Bug fixes and enhancements in the helper package are instantly effective accross the board.

Of course, one cannot depend on such a package in a formally published package (say, one published to PyPI), so things like `tools.py` or whatever are still necessary from time to time. But for day-to-day scripting, having a personal helper package that is used accross the board is definitely a good idea.
