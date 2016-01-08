---
title: "App suggestion: Dropzone 3"
date: 2014-12-19T14:08:57-0800
date_display: December 19, 2014
...

I recently tried and purchased [Dropzone 3](https://aptonic.com/dropzone3/). See a list of features on the linked official website. In short, Dropzone 3 provides an intermediate zone for drag-n-drop. You can use it as a stash (called "Drop Bar" — stacking is available), use it as a shortcut by putting frequently used folders and applications there, or trigger actions by dropping. There are a dozen builtin actions and [an additional list of readily available actions](https://aptonic.com/dropzone3/actions/), covering common web drives, SNS and file sharing sites. **Better yet, you can develop your custom actions with the easy-to-use [Ruby API](https://github.com/aptonic/dropzone3-actions/blob/master/README.md#dzalerttitle-message).** For instance, I wrote a simple Google Translate action, `Google Translate.dzbundle` ([link](https://gist.github.com/zmwangx/b27f106a8ba47468a43d)), based on [translate-shell](https://github.com/soimort/translate-shell). (You know, it's Ruby, so calling external commands and concatenating strings feel at home, as if you are coding in Perl or directly in shell; unlike Python, where you at least need to `import subprocess` then `subprocess.check_output` to get the output of an external command, and have to use a bunch of stupid `+`'s to get your goddamn message to print.)

Although I use the terminal for most tasks, drag-n-drop is still useful and convenient at times, not to mention the custom actions. (And the stock drag-n-drop is kinda hit-and-miss, especially for people like me who are mostly working with windows maximized — except terminal windows.) After using Dropzone 3 for a while, I found it well worth $4.99.

Wait, I didn't mention the pricing? Dropzone 3 is only [$4.99 on MAS](https://itunes.apple.com/us/app/dropzone-3/id695406827?ls=1&mt=12), so get it while supplies last. (Somehow the license is $10 on the developer's online store, so definitely buy from MAS and change to the [unsandboxed version](https://aptonic.com/dropzone3/sandboxing.php) later — de-sandboxing is free.) There's also a 15-day free trial.
