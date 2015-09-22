---
title: "Zsh 5.1 and bracketed paste"
date: 2015-09-21T14:40:36-07:00
date_display: September 21, 2015
---
**TL;DR.** Jump to [code](#code).

---

In short, Zsh 5.1 introduced bracketed paste mode[^1] and turned it on by default (as it seems to me). It is nice in certain ways — I appreciate the change, yet I was bitten nevertheless. In at least two ways:

1. Most annoyingly, `url-quote-magic` doesn't work anymore when pasting URLs, so for example if I paste

        https://www.google.com/search?q=zsh

    without typing in a single or double quote first, the `?` and `=` won't be backslash-quoted by default, which causes an error when passed unnoticed (out of habit).

2. The Emacs shell[^2] is littered with `^[[?2004h` and `^[[?2004l` around every prompt.

The solution? Zsh now also ships with [`bracketed-paste-magic`](https://github.com/zsh-users/zsh/blob/master/Functions/Zle/bracketed-paste-magic) that solves exactly breakage #1 (and a bit more); to quote comments from the linked source file:

> Starting with zsh-5.1, ZLE began to recognize the "bracketed paste"
capability of terminal emulators, that is, the sequences `$'\e[200~'` to
start a paste and `$'\e[201~'` to indicate the end of the pasted text.
Pastes are handled by the bracketed-paste widget and insert literally
into the editor buffer rather than being interpreted as keystrokes.
>
> This disables some common usages where the self-insert widget has been
replaced in order to accomplish some extra processing.  An example is
the contributed url-quote-magic widget.  The bracketed-paste-magic
widget replaces bracketed-paste with a wrapper that re-enables these
self-insert actions, and other actions as selected by the zstyles
described below.

And to solve breakage #2, just disable bracketed paste altogether for dumb terms.

<p id="code">Putting it together:</p>

```zsh
# turn off ZLE bracketed paste in dumb term
# otherwise turn on ZLE bracketed-paste-magic
if [[ $TERM == dumb ]]; then
    unset zle_bracketed_paste
else
    autoload -Uz bracketed-paste-magic
    zle -N bracketed-paste bracketed-paste-magic
fi
```

[^1]: Bracketed paste mode is a safeguard against inadvertent interpretation of pasted text, e.g., newline being treated at `accept-line` in Zsh. You may read more about it [in this blog post](https://cirw.in/blog/bracketed-paste), which is somewhat outdated yet still informational.

[^2]: I seldom use this dumb (literally) thing, but when I do I expect it to work ungarbled, naturally.
