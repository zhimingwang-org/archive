---
title: "Bash function exporting fiasco"
date: 2015-11-25T15:38:13-08:00
date_display: November 25, 2015
---

Bash is the only major shell (and the only shell that I know of) that implements function exporting. By now everyone should have heard of this feature, I suppose, after the publicity of Shellshock last year. I was personally introduced to it while writing parallel processing scripts [with GNU Parallel](https://www.gnu.org/software/parallel/parallel_tutorial.html#Transfer-environment-variables-and-functions) (long before Shellshock), and it seemed useful and clever at that time. Back then I often wondered why it didn't make its way into Z shell. However, now that I'm much more seasoned in shell scripting, I can see why and how this feature is troubled and of debatable value.

Two problems lie at the heart of function exporting:

1. As always, everything clever comes at a cost;
2. Code execution from untrusted source.

Regarding the first problem, the cost of function exporting is to mess with the environment, in a very hackish way. The environment was designed to hold data, not code, and we're not in the utopia of Lisp; but bash forced its way through. Pre-shellshock, exported `func` was stored as `func=() {...` in env; post-shellshock, it was first `BASH_FUNC_func()=() {...` (which didn't entirely fix the issue), and then `BASH_FUNC_func%%=() {...`.

The second problem doesn't need much explanation — *shellshock it was*. It has been extensively documented elsewhere, so I'll just succinctly comment that to load exported functions into a subshell, function definitions have to be retrieved from the environment and executed (again because we're not in the utopia of Lisp[^lisp]), and loading is done passively from the subshell user's point of view, hence the code execution bug(s). The bug(s) has(have) allegedly been fixed, but code execution (presumably with the appropriate safeguards now) still can't be avoided altogether, so just like a sanitized `eval`, it would still wake you up at night.

Well, if that's all I have to say, I wouldn't have started this post today. The thing that's bugging me is another issue I've found recently that's entirely avoidable, yet upon which we'll probably never see light ever after due to a combination of factors.

It started with [this question on SO](http://stackoverflow.com/q/33819243/19447840). While troubleshooting I quickly noticed that a Bash-emulated `sh` imports those `BASH_FUNC`s from the environment:

    > bash -c 'func () { echo "exported function loaded"; } && export -f func && ln -sf /bin/bash sh && ./sh -c func'
    exported function loaded

It gets worse when the function isn't Bourne shell compatible (e.g., when it uses process substitution):

    > bash -c 'func () { cat <(echo hello); } && export -f func && ln -sf /bin/bash sh && ./sh -c func'
    cat: <(echo hello): No such file or directory

That's surprising but not scary enough, because if you're not a fool you won't call `func` in `sh` anyway. However, if you're unfortunate enough to be dealing with `/bin/sh` on OS X (bash 3.2 under the hood, modified by Apple or not I'm not sure), then all hell break loose:

    > bash -c 'func () { cat <(echo hello); } && export -f func && /bin/sh -c :'  # OS X only
    /bin/sh: func: line 0: syntax error near unexpected token `('
    /bin/sh: func: line 0: `func () {  cat <(echo hello)'
    /bin/sh: error importing function definition for `func'

Note that we're actively doing nothing in `sh`, yet we get all these syntax errors from loading `func`. This happens to every invocation of `sh`, and as you might expect, there are no shortage of programs that are either `sh` scripts (e.g., fasd) or have internal `sh` calls (e.g., GNU Parallel). A single export of a Bourn shell incompatible function will haunt you through the entire session. Oops.

As I said, I don't know if the displayed error messages are due to Apple's modifications (anyone willing to look at the [source code](https://opensource.apple.com/source/bash/bash-97/)?), since a symlink named `sh` to `/bin/bash` doesn't print error messages, but instead load the wrong function, which is almost as bad but less annoying to innocent users. At any rate, it's not even worth reporting, either to GNU or Apple, because we're stuck with bash 3.2 for `/bin/sh` forever (thank you GPLv3), and it takes a hell of a vulnerability like shellshock to get a small update out of Apple's hands. We can install newer shells to `/usr/local` as much as we'd like to, but `/bin/sh` is simply the final word for many tasks involving the shell. Yet it's stained by this troubled bash-specific feature, and it's not going anywhere. So sad.

[^lisp]: I'm not commenting on the security of Lisp.
