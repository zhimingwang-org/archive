---
title: "Speeding up Emacs with emacsclient"
date: 2014-12-14T10:06:02-0800
date-display: December 14, 2014
---
Emacs is notorious for its loading time. For me, this is especially annoying when I'm editing LaTeX files — AUCTeX takes about five seconds to load, and once I exit Emacs (especially after a quick edit), all that work is wasted, and next time I want to do some quick editing with that same LaTeX file — sorry, another five seconds.

This problem can be solved by "using that same Emacs", i.e., running Emacs in server mode, then connecting to the server via `emacsclient`. Below is my script, which I call `emc`, to make `emacsclient` more user-friendly. `emc` opens a file (given as `$1`) on the server, launching one on its way if none is detected. Note that I used `-cqta=` for `emacsclient`. The `-c` option is `--create-frame`, i.e., create a new frame (in the current tty, for instance) instead of using the existing frame (in another tty, for instance); this allows for multiple frames accross different ttys. The `-q` option is for `--quiet`, suppressing messages like "Waiting for Emacs..." The `-t` option is for `--tty`, or equivalently, the familiar `-nw` option of `emacs`. The `-a=` options is `--alternate-editor=`; according to the manpage, `-a, --alternate-editor=EDITOR` has the following effect:

> if the Emacs server is not running, run the specified editor instead. This can also be specified via the \`ALTERNATE_EDITOR' environment variable. If the value of EDITOR is the empty string,  run \`emacs --daemon' to start Emacs in daemon mode, and try to connect to it.

Note that `emacsclient` requires a filename, so my script prompts for one if `$1` is empty.

``` bash
#!/usr/bin/env bash
if [[ -n $1 ]]; then
    file=$1
else
    while [[ -z ${file} ]]; do
        read -p 'filename: ' file
    done
fi
emacsclient -cqta= "${file}"
```

Note that using `emacsclient` has the additional benefit that the same buffer is simultaneously updated accross different ttys (See screenshot, where I opened the current post in two different ttys). This way, you won't face the nasty "file changed on disk" problem when you accidentally edited the same file in another tty session.

![screen shot of multiple copies of the same buffer](https://i.imgur.com/9KxEWKq.png)

By the way, remember to re-configure your other programs that uses an external editor. For instance, change `$EDITOR` to `emacsclient -cqta=` in your `env`, and `core.editor` to `emacsclient -cqta=` in your `~/.gitconfig`.

*Note*: if you use `emacsclient` to edit git commit messages in Git Commit Mode, remember to use `C-c C-c` (`git-commit-commit`) to save the commit message rather than using `server-edit` or `C-x C-c` to exit Emacs. Otherwise, the `COMMIT_EDITMSG` buffer will persist in the Emacs server, and you'll be prompted to revert buffer the next time you edit another commit message, which is pretty annoying.

I just started using `emacsclient`, so the above script might be buggy in certain edge cases. I'll report when I run into issues.
