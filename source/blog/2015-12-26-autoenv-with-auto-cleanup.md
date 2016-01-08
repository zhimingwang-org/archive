---
title: "autoenv with auto cleanup"
date: 2015-12-26T00:15:48-08:00
date_display: December 26, 2015
...

I heard about [kennethreitz/autoenv](https://github.com/kennethreitz/autoenv) a long time ago. The idea of autoloading project-specific environment modifications is nice, but no auto cleanup after leaving a project was a showstopper for me.

Today, I took matters into my own hands and wrote a fresh Zsh implementation[^re] with auto cleanup support. Check it out: <https://github.com/zmwangx/prezto/tree/master/modules/autoenv>.

[^re]: This is not a re-implementation in the common sense. My little Zsh module is inspired by kennethreitz/autoenv and reminiscent of that older project, but I took nothing from there (in fact I didn't even read their source code). I also don't claim to support their entire feature set. For instance, kennethreitz/autoenv claims to be Foreman compatible, which includes turning on `ALL_EXPORT`. However, I don't think `ALL_EXPORT` by default is a good idea, so with my `autoenv`, if you want `ALL_EXPORT` you have to set it explicitly.

As a quick promotion, let me show you two common examples.

First, inserting some local bin directory into the search path. This is easily done by a one-line `.env`, say,

```zsh
autoenv-insert-paths bin libexec
```

This way `$PWD/bin` and `$PWD/libexec` are inserted to the beginning of the search path, which will persist until you leave the directory tree. That is to say, the inserted paths will still be available when you descend into subdirectories (and more specific `.env`'s can even be stacked as you descend), but they will be purged as soon as you leave the tree. Clever, isn't it?

Secondly, exporting project-specific environment variables. The `.env` would look like

```zsh
export HOMEBREW_DEVELOPER=not-for-the-faint-hearted

autoenv-purge () unset HOMEBREW_DEVELOPER
```

where the body of `autoenv-purge` will be executed when you leave the directory tree. No more junk floating around.

Again, for more info, including detailed usage and customization instructions, please visit [`modules/autoenv`](https://github.com/zmwangx/prezto/tree/master/modules/autoenv) in zmwangx/prezto.
