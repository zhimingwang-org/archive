---
title: "Safeguarding git repos against accidental rm"
date: 2015-12-08T00:17:39-08:00
date_display: December 8, 2015
...

Everyone who has spent a sizable portion of their life in terminals has experienced that "oh shit" moment: you realize what you've done immediately after you've hit enter, but it's already too late. And needlessly to say, many of those are associated to accidental `rm`s.

I just had one of those moments. I was going to delete a subdirectory of `~/.config`, but hit return prematurely, and the command line ended up being `rm -r ~/.config`. Imagine the horror one second later. Fortunately I was saved by the read-only objects in `.git`, which triggered prompts; however, damage was already done, to some extent. I had to reinit the repo and do a hard reset, and a corrupted submodule was in my way (it blocked my attempt of `git reset --hard`) which I eventually had to completely remove and re-add. In the end everything was recovered (hopefully) and back to normal, but this episode was definitely not great for heart health, which led me to rethink `rm`.

I've tried several safer `rm` solutions before. The first and obvious is to alias `rm` to `rm -i`, but having to answer dozens of prompts a day (or more) is agonizing and unproductive. I've also tried trashing, but a nonempty trash can makes me sick, so not for me either. I also used `safe-rm` for a couple of months, but without supplying my own blacklist (I have none to be blacklisted), I've never hit the default blacklist; apparently I'm not stupid enough to mess in system locations, so this won't really help much. Fortunately though, this time I might have found a very good solution for myself.

The idea is to protect all git repos. Git repos[^repo] are among the most valuable assets of programmers, and they have the nice property of not being completely removable without `-f` or `--force` (the work tree of a submodule, where `.git` is a regular file containing the relative path of the git dir, can be removed without `--force`, but we don't want to damage submodules anyway, so let's not single them out). It's unlikely that we would intend to remove a repo directory without specifying `-f` or `--force`, so let's just reject all such `rm` calls.

The wrapper is very easy to write. Here's one implementation for Zsh with support for both GNU coreutils and BSD `rm`.

[^repo]: In this article, "repo" stands for the work tree of a repo, unless otherwise noted; the actual repo with git objects is referred to as "git dir".

```zsh
rm () {
    setopt localoptions noshwordsplit noksharrays
    local args_backup force node
    set -A args_backup $@
    while :; do
        case $1 in
            --force|-*f*) force=1 && shift;;
            --) shift && break;;
            -*) shift;;
            *) break;;
        esac
    done
    for node; do
        # -f, --force hasn't been specified && node is a git repo
        [[ -z $force && -e $node/.git ]] && {
            printf "\e[31m'%s' is a git repo -- won't remove without the -f or --force option\e[0m\n" $node
            return 1
        }
    done
    command rm $args_backup
}
```

Personally, I stick it into a [Prezto module](https://github.com/zmwangx/prezto/tree/master/modules/rm_guard) available from my fork. Hopefully it will serve me well this time round.
