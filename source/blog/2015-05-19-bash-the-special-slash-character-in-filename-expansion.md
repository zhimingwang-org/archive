---
title: "Bash: the special slash character in filename expansion"
date: 2015-05-19T18:33:51-07:00
date-display: May 19, 2015
---
It is well-known and common sense that the slash character (`/`) serves a special role in Bash filename expansion. For instance, the asterisk `*` certainly won't match `/` or `.` when used in filename expansion; otherwise, a standalone `*` would match everything in the filesystem.

However, it is less clear how a literal slash character[^expansion] is treated in extended glob patterns. Naively one would expect it to just match a literal slash, but the real situtation is more complicated than that. Consider the following examples:

[^expansion]: Here, "a literal slash character" also applies to one that comes from tilde expansion, parameter expansion or command substitution, since they are performed before filename expansion in Bash.

```bash
bash-4.3$ shopt -s extglob nullglob
bash-4.3$ echo /usr/@(bin|lib)
/usr/bin /usr/lib
bash-4.3$ echo /usr@(/bin|/lib)

bash-4.3$ [[ /usr/bin == /usr@(/bin|/lib) ]] && echo matching
matching
```

As seen from this example, patterns with slash simply doesn't work (in filename expansion) when placed in an extended glob pattern list, and there's no error whatsoever. I looked up the [Bash Reference Manual](https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html#Pattern-Matching) and the [Bash Guide](http://mywiki.wooledge.org/BashGuide/Patterns) but neither mentioned this behavior. One might need to delve into the source code to say for sure what exactly is going on.

In comparison, Zsh and its [docs](http://zsh.sourceforge.net/Doc/Release/Expansion.html#Filename-Generation) are much more up front about this issue:

> Note that grouping cannot extend over multiple directories: it is an error to have a ‘/’ within a group (this only applies for patterns used in filename generation). ...

And when we run equivalent code in Zsh:

```zsh
zsh-5.0.5$ setopt NULL_GLOB
zsh-5.0.5$ echo /usr/(bin|lib)
/usr/bin /usr/lib
zsh-5.0.5$ echo /usr(/bin|/lib)
zsh: bad pattern: /usr(/bin|/lib)
zsh-5.0.5$ [[ /usr/bin == /usr(/bin|/lib) ]] && echo matching
matching
```

The lesson? Be careful not to use a pattern like `@(path1|path2|path3)` in Bash when the paths are absolute, or relative but contain the slash. Unlike Zsh, Bash just silently fails on a pattern like this, which is rather dangerous in scripts.
