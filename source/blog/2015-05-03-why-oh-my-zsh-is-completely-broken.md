---
title: "Why Oh My Zsh is completely broken"
date: 2015-05-03T17:15:49-0700
date_display: May  3, 2015
---
Today I moved from [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh) to [Prezto](https://github.com/sorin-ionescu/prezto), after using Oh My Zsh for about three years since 2012. I'll try to shed some light on the reasons in this post.

Zsh is a rather complicated shell (compared to Bash), with a hell lot of builtins and a complex completion system. The complexity makes it powerful, but also makes it intimidating to mortals; moreover, it doesn't look as sweet as it could be out of box. Most mortals, me included, want an interactive shell that's sweet and "just works", so we need wizards to guide us in configuring this beast. Oh My Zsh and Prezto are just two of such configuration frameworks. Oh My Zsh is somewhat older: the first commit of Oh My Zsh dates back to [August 2009](https://github.com/robbyrussell/oh-my-zsh/commit/e20401e04e057a39c228dbb99dda68ec7fa4235a), while Prezto was forked from Oh My Zsh in [February 2011](https://github.com/sorin-ionescu/prezto/commit/8d487d4f6c2d38cb108d7c8c0c2de9f0385da402), and has since been completely rewritten. `robbyrussell/oh-my-zsh` as of today has 23,610 stars on GitHub, while `sorin-ionescu/prezto` has 4,069. This doesn't imply Oh My Zsh is any better — I guess the fancy name of Oh My Zsh earned it a lot more undeserved stars; you'll see why soon.

I was hardly involved in Oh My Zsh development, and I haven't even carefully inspected Oh My Zsh's source code until yesterday, so my soon-to-come complaints about Oh My Zsh might not be completely true. But here it is: **Oh My Zsh brings the worst of community-driven development, where the "community" knows not of what it is doing, and just wants to get things done in the sloppiest way possible.** Let's look at some examples. All discussions are based on [`1400346`](https://github.com/robbyrussell/oh-my-zsh/commit/140034605edd0f72c548685d39e49687a44c1b23), the latest commit at the time of writing.

## The core lib hodgepodge

First, look at Oh My Zsh's core [lib](https://github.com/robbyrussell/oh-my-zsh/tree/140034605edd0f72c548685d39e49687a44c1b23/lib):

```zsh
> ls lib
bzr.zsh         directories.zsh  grep.zsh          misc.zsh                   spectrum.zsh
completion.zsh  functions.zsh    history.zsh       nvm.zsh                    termsupport.zsh
correction.zsh  git.zsh          key-bindings.zsh  prompt_info_functions.zsh  theme-and-appearance.zsh
```

Wait, why do I see `bzr.zsh`, `git.zsh`, and even `nvm.zsh` in the core lib? Why are all of these mandatory (all files in `lib` are sourced from `oh-my-zsh.sh`)? Why should I load `bzr.sh` and `nvm.zsh` when I don't use Bazaar or NVM at all?[^bazaar] Moreover, since we already have `bzr.sh`, `git.zsh` and `nvm.zsh` in the core library, why don't we also have `hg.zsh`, `rvm.zsh`, `svn.zsh` and `virtualenv.zsh`, just to name a few?

[^bazaar]: This is not entirely true. I use [git-remote-bzr](https://github.com/felipec/git-remote-bzr) when I have to clone a Bazaar repo for some reason.

I suppose these marginal scripts are in the core because they define functions (`bzr_prompt_info`, `git_prompt_info`, `nvm_prompt_info`, etc.) that are called from many themes; well, at least this is the case for `git.zsh`. But that doesn't answer any of the questions above. **The underlying question is: why aren't they simply plugins?**[^plugins] Loading a plugin in Oh My Zsh isn't sophiscated at all (compared to Prezto; see discussion below), just annoying to type in full, which [boils down to](https://github.com/robbyrussell/oh-my-zsh/blob/140034605edd0f72c548685d39e49687a44c1b23/oh-my-zsh.sh#L68-L72):

```zsh
if [ -f $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH_CUSTOM/plugins/$plugin/$plugin.plugin.zsh
elif [ -f $ZSH/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH/plugins/$plugin/$plugin.plugin.zsh
fi
```

where `$plugin` is the name of the plugin. They can easily wrap this in a function and let theme authors painlessly load plugins,[^pollution] but they just don't. Also, the consistency issue (think of my question about `hg`, `rvm`, `svn` and `virtualenv`) is beyond my grasp. The only way I could make sense of this situation is that all the mess was created by clueless community contributions that didn't think about the code base as a whole (the code base is small!), and maintainers didn't care either.

[^plugins]: Note that outside the core, there are additional plugins for `git` and `nvm`. Oh well.
[^pollution]: Whether aliases defined in a plugin (e.g. for `git`) should be loaded can be easily controlled via a switch.

Meanwhile, Prezto does it right. Prezto is highly modular, with the `pmodload` function defined in [`init.zsh`](https://github.com/sorin-ionescu/prezto/blob/08676a273eba1781ddcb63c4f89cfff9bd62eac4/init.zsh) to load modules (doing things like sourcing module init scripts and marking module functions for autoloading). That's about the entirety of Prezto's core; everything else are in optional [modules](https://github.com/sorin-ionescu/prezto/blob/08676a273eba1781ddcb63c4f89cfff9bd62eac4/modules), including essential configs like `editor` (ZLE configs), `completion`, and `prompt`. Note that module loading order matters in some cases, but still, working with Prezto's modular structure is a joy. Apart from `init.zsh` and the `modules` directory, the Prezto repo does contain one other [`runcoms`](https://github.com/sorin-ionescu/prezto/tree/08676a273eba1781ddcb63c4f89cfff9bd62eac4/runcoms) directory with rc files, but those are just recommendations that one may safely ignore. In fact, there are a total of eight lines related to Prezto in my `.zshrc`, and nowhere else (note that I only switched to Prezto today, so this freshly baked `.zshrc` is subject to change):

```zsh
# prezto
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:environment:termcap' color 'no' # disable coloring of less, which looks horrible
zstyle ':prezto:load' pmodule environment editor history directory utility colors spectrum git completion prompt ruby
zstyle ':prezto:module:editor' key-bindings 'emacs'
zstyle ':prezto:module:prompt' theme 'zmwangx'
[[ "$OSTYPE" == darwin* ]] && export BROWSER='open'
source ~/.zprezto/init.zsh
```

Here `zmwangx` is my [personal theme](https://github.com/zmwangx/prezto/blob/master/modules/prompt/functions/prompt_zmwangx_setup) that looks like [this](https://i.imgur.com/nCBK8ZB.png).

## Incredibly poor code quality

Oh My Zsh's code quality is incredibly poor. Even within the core library. Pick any file from `lib/`, and you'll be amazed by the hot mess in front of your eyes. There's no coding standard whatsoever:

* You can find four-space indents and two-space indents mixed [in the same file](https://github.com/robbyrussell/oh-my-zsh/blob/140034605edd0f72c548685d39e49687a44c1b23/lib/functions.zsh);
* You can find function definitions with the `function` keyword and without [in the same file](https://github.com/robbyrussell/oh-my-zsh/blob/140034605edd0f72c548685d39e49687a44c1b23/lib/git.zsh);
* You can find [167-character-long lines](https://github.com/robbyrussell/oh-my-zsh/blob/140034605edd0f72c548685d39e49687a44c1b23/lib/functions.zsh#L2) mixed with early-broken lines (yes, sometimes [in the same file](https://github.com/robbyrussell/oh-my-zsh/blob/140034605edd0f72c548685d39e49687a44c1b23/lib/git.zsh#L69));
* You can find completely commented out blocks of code [in the core lib](https://github.com/robbyrussell/oh-my-zsh/blob/140034605edd0f72c548685d39e49687a44c1b23/lib/key-bindings.zsh#L70-L87), where the average user is not supposed to touch;

I guess the list could go on; I didn't spend more time inspecting this crap.

We were discussing styles, but obviously style isn't the only problem with this code base. Next onto a case study of how Oh My Zsh does something in the most inefficient way possible. Let's have a look at [`git.zsh`](https://github.com/robbyrussell/oh-my-zsh/blob/140034605edd0f72c548685d39e49687a44c1b23/lib/git.zsh). It suffers from almost all problems we have talked about so far, but let's focus specifically on [the `git_prompt_status` function](https://github.com/robbyrussell/oh-my-zsh/blob/140034605edd0f72c548685d39e49687a44c1b23/lib/git.zsh#L78-L122):

```zsh
git_prompt_status() {
  INDEX=$(command git status --porcelain -b 2> /dev/null)
  STATUS=""
  if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  fi
  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    STATUS="$ZSH_THEME_GIT_PROMPT_STASHED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## .*ahead' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_AHEAD$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## .*behind' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_BEHIND$STATUS"
  fi
  if $(echo "$INDEX" | grep '^## .*diverged' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_PROMPT_DIVERGED$STATUS"
  fi
  echo $STATUS
}
```

**This one single function intended to be invoked from a precmd hook (basically executed every time the prompt is printed), calls `grep` a staggering 14 times inside command substitutions, forking the process 28 times — while all the greps can be replaced with pattern/regex matching right within the shell.** (Keep in mind that forking is the most expensive operation of the shell.) For instance,

```zsh
$(echo "$INDEX" | grep '^A  ' &> /dev/null)
```

may well be replaced with

```zsh
[[ $INDEX == *$'\nA  '* ]]
```

or

```zsh
[[ $INDEX =~ $'\nA  ' ]]
```

(Note that the `git status --porcelain -b` call always prints the branch info such as `## master...origin/master` in the first line, so "<code>A  </code>", if present at the beginning of any line, must be preceded by a newline; that's why the above works.) All other grep calls can be similarly replaced with pattern/regex matching. No forking.

By the way, whoever wrote this function seems to be unaware of the `-q,--quite,--silent` switch of `grep` (which should be available in all implementations), and every call is littered with `&> /dev/null`. In fact, using the `-q` switch is even (slightly) faster: a reasonable implementation of `-q` exits immediately when a match is found, while what is written here waits until all input is processed.

I haven't exhausted the problems with this function just yet. As a bonus: despite being awfully inefficient, **this function *can't even be used* in many cases for which it is designed.** You might have noticed that the order of different status bits is completely fixed by whoever wrote this function (by the way, all those `$ZSH_THEME_GIT_PROMPT_*` variables are documented nowhere, so one who wants to write a theme has to dig into the source — only to find the function useless expect for polluting the namespace). If one wants to use a different order, or put some of the bits in `RPROMPT`, one has to roll his own (or good luck parsing the output of `git_prompt_status`). In fact, even a [dumbed down function `git_prompt_info`](https://github.com/robbyrussell/oh-my-zsh/blob/140034605edd0f72c548685d39e49687a44c1b23/lib/git.zsh#L2-L8), which only prints the branch name and whether it's dirty, is similarly uncustomizable; [the `gallois` theme](https://github.com/robbyrussell/oh-my-zsh/blob/140034605edd0f72c548685d39e49687a44c1b23/themes/gallois.zsh-theme), my first theme and on which I later based my own theme, needs to define a `git_custom_status` function to achieve what it needs — otherwise something as simple as adding a pair of brackets around the branch name is super painful.

One might wonder how Prezto solves the same problem. The answer is in [`modules/git/functions/git-info`](https://github.com/sorin-ionescu/prezto/blob/08676a273eba1781ddcb63c4f89cfff9bd62eac4/modules/git/functions/git-info). The `git-info` function does more, and again in a highly modular way (without grep calls, for God's sake): status bits or their combinations are [formatted on demand with `zformat` and stored in an associative array `git_info`](https://github.com/sorin-ionescu/prezto/blob/08676a273eba1781ddcb63c4f89cfff9bd62eac4/modules/git/functions/git-info#L393-L416), where users specify format strings via `zstyle` with [thoroughly documented escape sequences](https://github.com/sorin-ionescu/prezto/tree/08676a273eba1781ddcb63c4f89cfff9bd62eac4/modules/git#theming). Very beautiful solution.

## The completely broken community contribution process

I'm not sure if the project maintainers are Zsh wizards (I'm afraid not). I'll just assume that most of the code with incredibly poor quality came from community contribution. Okay, community. But even the community contribution process is completely broken.

At the time of writing there are 159 open issues and 446 open pull requests in `robbyrussell/oh-my-zsh` (the stats are 13/35 in `sorin-ionescu/prezto` — not proportional to the number of stars or forks). There's even [a PR called "Easy-to-Merge"](https://github.com/robbyrussell/oh-my-zsh/pull/3809) that is said to collect PRs that are either extremely simple fixes or have been discussed–tested–and–signed-off (wait, then why aren't they already merged?). This makes it almost impossible to open new, substantial PRs (such as a complete rewrite of the `git_prompt_status` criticized above) — God knows whether other people have already proposed the same fix, or a different fix for the same problem, whether it's been discussed–tested–and–signed-off, and how much discussion will be needed for a new PR.

You might infer from the above that the actually merged PRs are discussed–tested–and–signed-off. Well, of course not (think about the code quality), and here's one more case study.

The only time I [submitted a PR](https://github.com/robbyrussell/oh-my-zsh/pull/3591) is when [a previous PR](https://github.com/robbyrussell/oh-my-zsh/pull/3564) broke aliases of the `ls` family, which most of us run tens to hundreds of times every day. The `-h` option was stripped from all aliases but one (which was ridiculous since the option seemed to be lost during copy/paste), and anyone who used the affected aliases regularly and lived with the PR for ten minutes should notice. Apparently nobody looked at the diffs before merging, or nobody cared (before I and one other guy jumped in). My PR was merged three days later; the delay was okay.

[In another instance](https://github.com/robbyrussell/oh-my-zsh/pull/3341), the delay was totally unbearable. [grep 2.21](https://savannah.gnu.org/forum/forum.php?forum_id=8152) was released on November 23, 2014, and it deprecated `GREP_OPTIONS`. Oh My Zsh was using `GREP_OPTIONS` back then, so anyone who upgraded to grep 2.21 and used grep regularly was getting a lot of deprecation warnings (oh, before you ask, `grep.zsh` is in the core lib). Core lib stuff spitting deprecation warnings on all platforms all the time is a pretty big thing, right? There were multiple ways to fix this problem, all of them trivial to the reasonably trained eyes; and they won't break user scripts, unless someone was doing something insane in the first place (like relying on exported `GREP_OPTIONS` for certain behaviors in a script). However, there were quite a bit of discussion spanning multiple issues and PRs (most notably [this one](https://github.com/robbyrussell/oh-my-zsh/pull/3341)), and despite all the discussions, not a single maintainer or collaborator joined or showed any interest. [A fix was merged not until December 14, 2014](https://github.com/robbyrussell/oh-my-zsh/pull/3403). Of course there were temporary fixes (remember, the issue was trivial to begin with), but the problem must have been confusing to the less-proficient Zsh users during the twenty day window.

## Easter egg

One more thing, among countless other problems: the recommended way to install Oh My Zsh is either

```zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
```

or

```zsh
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
```

Cool, huh? How many of you have the `--no-check-certificate` option of `wget` automatically turned on? Thankfully there's no `sudo` in front.

## Summary

Oh My Zsh was a great idea when it took off. Over the years however, through low-quality community contributions from people who barely understand Zsh (and shell scripting idioms and best practices in general), it evolved into a beast that no one except the maintainers could fix or seriously contribute to; yet the maintainers seem to be pretty satisfied with it.

Therefore, I'm moving to Prezto, the project with far better modularity and code quality. In fact, this rant all began from yesterday, when I was about to embark on a stripped down Zsh configuration system for myself. I was thinking about borrowing code from both Oh My Zsh and Prezto; but after reading some code from both projects, I soon realized that Oh My Zsh is totally crap and Prezto can be taken almost unmodified. I hope that more people will take a look at Prezto, realize how awesome it is (especially in comparison to the famed Oh My Zsh), fork it, and possibly submit patches.
