---
title: "Zsh: save stdout, stderr, and return value of command to different variables (without temp file)"
date: 2015-07-15T09:21:47-07:00
date_display: July 15, 2015
---

This is something worth sharing. The idea was based on [this SO answer](http://stackoverflow.com/a/18086548/1944784), and I cooked up this particular implementation to remove potential race conditions, with input from Mathias Fredriksson[^1]. See [mafredri/zsh-async#1](https://github.com/mafredri/zsh-async/issues/1), and in particular [this comment](https://github.com/mafredri/zsh-async/issues/1#issuecomment-121468958) for explanation.

```zsh
# The following construct evaluates "$@" and saves output on stdout in the
# parameter stdout, output on stderr in the parameter stderr, and return value
# in the parameter return.
#
# The idea was based on http://stackoverflow.com/a/18086548/1944784, but this
# implementation is completely race-condition-free. The implementation was
# refined during my exchange with Mathias Fredriksson @mafredri, in
# https://github.com/mafredri/zsh-async/issues/1. See mainly
# https://github.com/mafredri/zsh-async/issues/1#issuecomment-121468958, where
# the advantage of this implementation is explained.

unset stdout stderr ret
eval "
$(
    {
        stdout=$(eval "$@")
        ret=$?
        typeset -p stdout ret
    } 2> >(stderr=$(cat); typeset -p stderr)
)"
```

Also available as [a gist](https://gist.github.com/zmwangx/efababea6258cedea07a).

[^1]: Mathias ([\@mafredri](https://github.com/mafredri)) is the author of the lovely [zsh-async](https://github.com/mafredri/zsh-async) library, and a maintainer of [sindresorhus/pure](https://github.com/sindresorhus/pure). He forever revolutionalized [my prompt](https://github.com/zmwangx/prezto/blob/master/modules/prompt/functions/prompt_zmwangx_setup).
