---
title: "StackOverflow review system is completely BS"
date: 2015-06-07T18:58:57-07:00
date_display: June 7, 2015
---

I just answered an interesting question about ZLE [on StackOverflow](http://stackoverflow.com/q/30699242/1944784), and in the process I also improved my own toolchain. For the record, the OP asked for tab completion to present working directory items (executable files and directories) on an empty command line, which led to the following widget:

```zsh
# This widget inserts "./" to the buffer and list possible completions
# (executable files and directories in the present working directory) if the
# buffer is empty or only contains whitespace.
function complete_pwd_items_on_empty_buffer
{
    if [[ $BUFFER =~ ^[[:space:]]*$ ]]; then
        BUFFER+="./"
        CURSOR+=2
        zle list-choices
    else
        zle expand-or-complete
    fi
}

zle -N complete_pwd_items_on_empty_buffer
```

This is all good stuff.

However, at some point a [security architect and mobile security engineer](https://stackoverflow.com/users/608639/jww) jumped in and made [the following comment](https://stackoverflow.com/questions/30699242/first-tab-completion-enhancement#comment49457640_30699242):

> Stack Overflow is a site for programming and development questions. This question appears to be off-topic because it is not about programming or development. See [What topics can I ask about here](https://stackoverflow.com/help/on-topic) in the Help Center. Perhaps Super User or Unix & Linux Stack Exchange would be a better place to ask. Also see [Where do I post questions about Dev Ops](http://meta.stackexchange.com/q/134306)?

Then the question was put on hold by several not-so-high-rep users as off-topic, and the reason given is

> Questions about general computing hardware and software are off-topic for Stack Overflow unless they directly involve tools used primarily for programming. You may be able to get help on Super User.

WTF. First, *programming ZLE widgets is programming.* Hell, I even gave chunks of Zsh code in the answer (and they saw that, because the stupid comment and its upvotes came after my answer was put up). If writing an interactive Android crapp in Java for your Samsung counts as programming, why is writing an interactive widget for my Z shell any inferior? Second, even if you want to follow what the Help Center says, this question clearly falls under

> software tools commonly used by programmers.

Maybe Zsh isn't used by those specific voters (I guess most of them are Windows lusers), but it has a very vibrant community, and it clearly rules. Maybe the specific voters don't realize that Zsh is a programming language; that alone shows how ignorant they are.

However, these are just specific lusers. Why do I generalize and insist that "StackOverflow review system is completely BS"? Well, just look at the voters' stats; I searched for their involvement in the `zsh` tag, and here are the results: [1](https://stackoverflow.com/search?q=user:2422776+[zsh]), [2](https://stackoverflow.com/search?q=user:683218+[zsh]), [3](https://stackoverflow.com/search?q=user:608639+[zsh]), [4](https://stackoverflow.com/search?q=user:3836229+[zsh]), [5](https://stackoverflow.com/search?q=user:2772643+[zsh]). Unsurprisingly, nothing, except one guy has answered a question about ASCII art, which shouldn't be placed under `zsh` in the first place. While someone knowlegeable of Zsh doesn't necessarily need to ask or answer questions about Zsh on SO, this quick search does reveal that these voters, rather than following the `zsh` tag, just popped out of nowhere, probably from the review queues. In this case it's pretty obvious that they're going after a new user (the OP just registered). And that is one of the main problems with SO's review system that makes it highly questionable in many cases:

**The review tasks are handed to people who have no knowledge of the topics,[^approved-edit] and these people just operate under assumptions (e.g., new users will ask off-topic questions.)[^new]**

[^approved-edit]: This problem isn't limited to reviews; it also applies to, for instance, approved edits. My *tag edits* (with explanations) got rejected quite a few times because the reviewers clearly didn't understand the topic — e.g., some morons assume that command line problems equal Bash problems.

[^new]: This is actually a good assumption, because this is the case at least 50% of the time from my limited experience. But one shouldn't operate under this assumption, especially if one doesn't understand the topic.

The solution? I'm afraid *there's no solution as long as the system is in place*. Ideally one should skip questions from topics that they don't understand, but in reality people just do as they damned well please, whether because they are working toward a badge, or because they *think* they understand the topic but really don't, or because they are outright jerks. Also, there are tons of totally fucked-up questions lying in every corner of SO (like questions displaying such profound ignorance[^bad] that no one would answer due to embarrassment, or those despicable "I can has code" questions) that no one cares about cleaning up, but instead they chose to target this well-meaning question that generated a pretty useful answer. By the way, this is the kind of thing I see all the time.

[^bad]: I think I asked quite a few stupid questions back in the days, and now I'm totally ashamed of them. Insterestingly, some of those questions are my highest voted ones and got me quite some reps (compared to my total rep — I'm by no means a high rep user). See [*Why I no longer contribute to StackOverflow*](http://michael.richter.name/blogs/why-i-no-longer-contribute-to-stackoverflow) for a thorough discussion of the broken rep system and its disastrous effects.

I hope SO could abandon this questionable "review queue" practice altoghether. Let people who actually follow the tags do the reviewing and voting. Honestly, no one really cares about dangling low-quality questions anyway.
