---
title: "Using Python 3 with Emacs Jedi"
date: 2015-04-26T21:19:14-0700
date-display: April 26, 2015
---
Recently I'm working on [a hobby project in Python](https://github.com/zmwangx/storyboard), which means editing Python source files a lot. I've been using [Emacs Jedi](https://github.com/tkf/emacs-jedi) for almost as long as I've been writing Python, and it has been pretty helpful at completing away long names.

However, Jedi uses `python` by default, which means `python2` on most of our systems at this point. Occasionally I'm writing Python 3 specific code but Jedi completes to Python 2 or refuses to complete; for the record, I enjoy writing and debugging Python 3.3+ much better than 2.7 (I realized this after trying to create a code base that is backward compatible with 2.7, which means reinventing the wheel or introducing annoying branches from time to time). So naturally I'm looking into using Python 3 in Jedi.

The [official docs](https://tkf.github.io/emacs-jedi/latest/#how-to-use-python-3-or-any-other-specific-version-of-python) has been confusing and unhelpful at least for me, since it insists on setting up the virtualenv from within Emacs, and it failed for me. Why can't I set up the virtualenv myself? Turns out I can, and it's incredibly simple. The commands below assume that you have installed Jedi and friends (well, dependencies) using `package.el`.

```bash
mkdir -p ~/.emacs.d/.python-environments
virtualenv -p /usr/local/bin/python3 ~/.emacs.d/.python-environments/jedi  # or whatever your python3 path is
# If you feel like installing the server with 'M-x jedi:install-server', also do the following
~/.emacs.d/.python-environments/jedi/bin/pip install --upgrade ~/.emacs.d/elpa/jedi-20150109.2230/  # you might need to change the version number
```

And that's it. Put the following in your `~/.emacs`:

```emacs-lisp
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(setq jedi:environment-root "jedi")
```

where the first two lines should be there whether you want to use Python 3 or not — so only the third line is new, and its meaning is obvious.

At last, start Emacs and do `M-x jedi:install-server` if you haven't run the `pip` command above yet. Restart Emacs (if necessary). That's it. Enjoy your Jedi with Python 3. (Type `import conf`, for instance, to be convinced that you're really autocompleting Python 3).
