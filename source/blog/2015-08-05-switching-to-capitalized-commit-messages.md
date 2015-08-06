---
title: "Switching to capitalized commit messages"
date: 2015-08-05T19:38:37-07:00
date-display: August 5, 2015
---
This post is a note to self.

As a long time git user, I've always used lowercase commit messages (in the subject line). I never quite liked the idea of capitalized commit messages, which are seldom complete sentences (and they are never period-terminated). Similarly, I avoid capilatization like hell in comments, unless when I write complete sentences. By the way, there's a technical advantage of writing lowercase commit messages: I can easily tell my human-made commits from auto commits like merge and revert commits, because they always begin with a capitalized "Merge", "Revert", etc.

However, most of the projects I've contributed to seem to prefer capitalized commit messages, and by following my own habit, quite often I would go through the "oh crap I messed up the contribution guidelines" realization and had to amend my commits after the fact. Also, when I open a single-commit pull request on GitHub, the subject line of the commit message automatically becomes the subject line of the pull request, and I want my pull requests to have capitalized subject lines. Perhaps I come off as self-contradictory here: lowercase commit message, but capitalized PR subject? I don't know. Maybe a PR subject is more like a real "title". Also, I blame the font: lowercase subject lines don't look remotely as good in, say, Helvetica (which GitHub currently uses for PR and commit message subject lines), as in a good fixed width font, which is what I get when I run any `git-log` variant in a terminal.

Anyway, lowercase commit messages isn't a particularly strong preference of mine, so I'm happy to change my habit from this day onward. Anyone can feel free to tease me if they see me write a lowercase commit message again (unless its in the format `component: changes`). In light of this, I've already [changed the message format](https://github.com/zmwangx/zmwangx.github.io/commit/297225f2ab8a6db4fe75643f511f52499b052aa7) of `pyblog`'s auto commits, which is how I generate this blog.

P.S. To be fair to me, *Pro Git*, the official git tutorial, [uses lowercase commit messages](https://github.com/progit/progit2/blob/6d9867ff2394cb8a08fa3e013b082a7ae547b8af/book/02-git-basics/sections/viewing-history.asc#viewing-the-commit-history) (I guess that's just the personal preference of Scott Chacon — not mandated by anyone). To be fair to the other side, [`git.git` mostly uses capitalized commit messages](https://github.com/git/git/commit/e83c5163316f89bfbde7d9ab23ca2e25604af290).
