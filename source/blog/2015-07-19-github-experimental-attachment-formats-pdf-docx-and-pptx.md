---
title: "GitHub experimental attachment formats: PDF, DOCX and PPTX!?!"
date: 2015-07-19T21:58:01-07:00
date_display: July 19, 2015
...

I was browsing [github/hub](https://github.com/github/hub), and noticed something funny in the issue tracker:

> Attach more than just images: Now you can attach PDF, **Word**, and **PowerPoint** files to your comments on Issues and Pull Requests. This experimental feature is only available to some repositories.[^bold]

[^bold]: Bold by me.

!["Attach more than just images: Now you can attach PDF, Word, and PowerPoint files to your comments on Issues and Pull Requests." WOW, JUST WOW.](/img/20150719-github-attachment-new-formats.png)

For a moment I wondered if today's April Fools', but apparently it isn't. Which makes me wonder: is GitHub expanding its customer base to grandparents? Or is this a heavily demanded feature on GitHub Enterprise by nontechnical managers and sales personnel? Attaching PDF to issues and PRs is already laughable enough; I just can't imagine any developer asking for Microsoft Office support. I mean, what should we do with those? Download those crap, wait ten minutes for Microsoft applications to launch, just to read a few pages of text? I know GitHub is expanding to designers by rolling out features like PSD diffing[^psd] and Large File Storage ([`git-lfs`](https://git-lfs.github.com/)) for assets, so is this feature also targeting nontechnical designers? Not sure. **At any rate, this "feature" is simply ridiculous.**

[^psd]: That's not even new; PSD viewing and diffing support has been around [for a year](https://github.com/blog/1845-psd-viewing-diffing).

GitHub has long been lacking good attachment support. Granted, one can dump files to gists and then link to them from issues, but that's a pain for most people (and not all people are aware of that). The lack of attachment support (other than images) is keeping some projects from hosting their issue trackers on GitHub, whose issue tracking system is otherwise extraodinary.[^compare] One notable example that I care about is [iTerm2](https://gitlab.com/gnachman/iterm2/issues), which asks users to attach the user preference plist and a gzipped debug log when opening a new bug. **Therefore, GitHub should improve their attachment support by accepting plain text files[^text], small gzips, common binary config file formats like binary Plist XML and so on that developers care about. But instead, they are working on... Microsoft Office???**

[^compare]: At least compared to Bugzilla, Trac, (the user-facing part of) Jira and FogBugz, SourceForge, Google Code (now closed), BitBucket, Savannah, GitLab, etc.

[^text]: Whether a file is plain text or binary is usually easy to check. Just look for the `NUL` character (`\000`).

My attitude towards Microsoft Office (mostly Word) is best described in a gist/tutorial that I wrote more than a year ago: [*Markdown, LaTeX, etc.*](https://gist.github.com/zmwangx/9987772). The ["Tips for Microsoft Office users"](https://gist.github.com/zmwangx/9987772#tips-for-microsoft-office-users) section is quoted out in full at the end of this post. My feelings toward Microsoft, and by extension, Office, has softened quite a bit since I wrote that tutorial (in particular, unlimited OneDrive storage for Office 365 subscribers was a pretty good bribe), but every word in that section still applies to Microsoft Word. **It is just sad that so many people all around the globe are still stuck in this Microsoft hell, not knowing that they have been liberated, and that they could have been free all along. And this move by GitHub is definitely not helping.**

---

**Appendix.** From my tutorial [*Markdown, LaTeX, etc.*](https://gist.github.com/zmwangx/9987772):

> Tips for Microsoft Office users
> -------------------------------
> 1.  Stop using Microsoft Office, **RIGHT NOW**;
> 2.  Do 1;
> 3.  Do 2;
> 4.  ......
>
> <h3>Why I hate Microsoft Office</h3>
> 1.  Microsoft Office is non-free, free both as in "free speech" and "free beer."
>
> 2.  Microsoft Office is not only non-free, but also expensive.
>
> 3.  `.docx` is proprietary format. Microsoft has full control over it (correct me if I'm wrong). Hopefully they at least released it as a standard, so vendor lock-in won't happen. However, Microsoft could change mind any time.
>
> 4.  Most Microsoft Word documents are text documents. But they are not readable and editable at all with text editors (in principle you could read and edit XML, but seriously, who would bother to do that). **So why Microsoft Office when plain text is nice, elegant, efficient, fast, and free?** Even when you need some formatting, there are Markdown and other plain text, human readble, and open source formats. I really hate it when people send me docx or ask me to send docx. Why assume I have the crap proprietary software installed? You could at least save as PDF before sending to me.
>
>     (PDF is another story. It started as proprietary, but was released free of charge a long time ago, and has since been made an open standard. There are a good number of great open source PDF generators, PDFLaTeX being one notable example. And after all, PDF and PostScript are intended for printers — they are not so easily made human readable without an interpreter, so using a proprietary format in this setting is reasonable.)
>
>     You might argue that docx can be edited with LibreOffice, OpenOffice, etc. However, first of all, documents created by Microsoft Office are not always (always not) rendered the same in these Offices; 100% compatibility has never been achieved. If you choose to work with Microsoft Office documents, you either be cheap and worry about lock-out/lock-in/damage/permanent damage (people who love Microsoft Office are often not competent enough to do back-up right), or throw your money at Microsoft. And point is: **plain text is both free and reliable in the first place.**
>
> 5.  Microsoft could change their pricing model at any time, just as Adobe did to their Creative Suite. They've already been exploring the subscription model via Office 365 for a while, which is $99.99 a year (home). In the future, Office might turn to subscription only, meaning that you would never have a full copy of your (already crappy) software that is guaranteed to work regardless of time, and that they could raise the subcription price at any time and drive you nuts instantly. (Microsoft recently released Office on iPad, which is already subscription only. Watch out for the trend.)
>
> 6.  Forgot to highlight one major annoyance. As you already know, I hate Microsoft Office; however, as mentioned in 4, I'm forced to keep the crap installed and occasionally launch it (which takes something around ten minutes just to launch) thanks to other people who insist on Microsoft Office. Every single launch deepens the hatred.
>
> 7.  (*05/04/2014* update) Apart from storage, transmission, and distribution, Microsoft Office &mdash; and word processors in general &mdash; are also bad for *writing*. To quote the [AsciiDoc official introduction](http://asciidoctor.org/docs/what-is-asciidoc/), the "Word processors, the real writer’s block" section,
>
>     > When you are in the writing (i.e., [typing](http://blog.stoyanstefanov.com/writing-vs-typing/)) phase, you want the words to flow onto the screen with minimal distractions and interruptions. Flow, not just time, is essential.
>     >
>     > Most word processor excel at distracting you from writing. The result: *you write less* (ironic, huh?).
>     >
>     > In a word processor, before you can type the first word on a blank screen, you're forced to think about what font family you want, what font size you want, what lines spacing you want and so on. Once you do get going, auto-correct, spelling and grammar suggestions entice you to backtrack and lose your next thought. "Smart" quotes and auto-linking messes with the text as fast as you can enter it. If you paste text, it likely gets added to the document with a different font family, size and even color.
>     >
>     > **Undo. Undo. Undo!**
>     >
>     > Let's not even talk about inserting source code. The designers of word processors clearly did not.
>     >
>     > **Format. Format. Format!**
>     >
>     > After burning time fighting with its interface, you rightfully conclude that the word processor is trying to *sabotage* your writing process.
>     >
>     > **We *need* an easier way to write!**
>     >
>     > But how?
>
>     It's kind of ironic to quote AsciiDoc in a document promoting Markdown, but at the very least, we are all against Word. This section is so well written that I can't resist the temptation to quote it out in full. Moreover, I actually typed it in myself to enjoy it to the fullest.
>
> 8.  (*05/04/2014* update) By the way, there is more to quote against docx (and XML in general), this time from Linus Torvalds, in a [Google+ comment](https://plus.google.com/+LinusTorvalds/posts/X2XVf9Q7MfV):
>
>     > no [sic], XML isn't even good for document markup.
>     >
>     > Use 'asciidoc' for document markup. Really. It's actually **readable** by humans, and easier to parse and way more flexible than XML.
>     >
>     > XML is crap. Really. There are no excuses. XML is nasty to parse for humans, and it's a disaster to parse even for computers. There's just no reason for that horrible crap to exist.
>
>     If you don't believe in me, you certainly believe in Linus don't you, who is much better at this art than you and me. If you don't even believe in Linus, you are not my reader in mind anyway.
>
> 9.  There are infinitely many other reasons to hate Microsoft Office, **which grabs money from the most basic workflow — text editing**. The reasons to hate Microsoft Office occur infinitely often in the decimal expansion of π.
