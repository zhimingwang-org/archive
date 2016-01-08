---
title: "Regex flavor hell"
date: 2015-12-20T16:03:03-08:00
date_display: December 20, 2015
...

I write a lot of shell scripts, which means dealing with common *ix utilities a lot. I typically want my scripts to work on both OS X and Linux (or OS X + GNU utilities, which is my personal setup), which means writing commands that are understood in both GNU/Linux and BSD worlds. Unfortunately that's not so simple, because to do that I usually have to give up readily available functionalities (especially the vast collection of useful options typical of GNU utilities) and am constantly thrown back to the stone age that is POSIX, or a little bit more than POSIX.

Working with regular expressions is especially painful. Almost every implementation of every utility (with regex support) has its own flavor of regex. Most notably the big three: `grep`, `sed` and `awk`. GNU utilities of course come with GNU extensions, but they are nothing when aiming for compatibility. Ignoring GNU extensions, there's a way to turn on standard POSIX extensions (ERE) on `sed`, but unfortunately GNU and BSD use different flags: `-r` for GNU sed and `-E` for BSD sed. The two implementations of `grep` thankfully use the same flag `-E` to turn on ERE, but GNU grep, being a GNU utility and having to distinguish itself from its mundane counterpart, further implements `-P,--perl-regexp` — regexers' dream. It's there but I can't use it, except in an interactive shell. `awk` has more than two implementations and will be left out of this discussion.

Anyway, despite all these flavor issues, I can usually get away with BRE, although it's verbose and unreadable as hell (quantifiers in particular) and doesn't support alternation. I would be thankful if BRE is the end of the story, but it is not. There are more tools lurking around trying to sabotage scripters. `find` is a perfect example. BSD `find`, unsurprisingly, uses BRE by default with `-regex` and `-iregex`, and ERE may be turned on with the `-E` flag. GNU findutils `find`, however, tries to be helpful and future-proof by having a `-regextype` option:

> Changes the regular expression syntax understood by `-regex` and `-iregex` tests which occur later on the command line. Currently-implemented types are `emacs` (this is the default), `posix-awk`, `posix-basic`, `posix-egrep` and `posix-extended`.

The Emacs flavor? You mean Elisp regexp? Okay fine, [BRE](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html) — with few features other than grouping (`\(...\)`), quantifiers (`*` or `\{n,m\}`), bracket expressions and character classes — should still be pretty much compatible with Elisp regexp. However, the "Emacs flavor" isn't even the Elisp flavor. It's a [stripped version](https://www.gnu.org/software/findutils/manual/html_node/find_html/emacs-regular-expression-syntax.html) specifically for findutils. In particular, there are `*`, `+` and `?` but no curly braces quantifiers, so gone is the dream of writing even just mildly complex regexps that are compatible with both BSD `find` and GNU findutils `find`. By the way, in case you wonder, the [POSIX `find`](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/find.html) doesn't even have a `-regex` primary/operator...

What a cruelly realistic world we live in.
