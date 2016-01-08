---
title: "Printing long, 80-character-per-line plain text document in two columns"
date: 2015-10-10T22:35:15-07:00
date_display: October 10, 2015
...

**TL; DR**. Jump to [code](#code).

---

Printing is hard. Everyone who has ever tried to set up a printer (especially a multifunction unit) will probably agree with me. There are also a million ways to be sabotaged by your printer, e.g., connection failure (over Wi-Fi), toner running low, manual duplex eating two sheets at once when printing the second side. (Do you believe I encountered all three tonight?) Anyway, let's just assume that you have a perfectly connected, perfectly functional printer, and talk about something even harder.

We nerds read 80-character-per-line (or 72, but it's safer to assume longer) plain text documents all the time, or at least occasionally if we exclude source code. A plain text document is extremely versatile; it looks awesome in a text editor or in a browser window — with monospace typeface of your choice and infinite scrolling or arbitrary pagination. However, the problem is, sometimes we want to put things into print for easier reference, and we do *not* have infinite scrolling or arbitrary pagination in print. We want to divide things up into pieces that fit nicely onto 8.5'' by 11'' sheets, without ruining the original formatting of the plain text document. Therefore, some program has to decide the page layout and translate the plain text document into something a printer understands, e.g., PostScript. But since plain text is so versatile, there are a million ways to lay it out on paper.

You would assume that this is a solved problem, since the digital publishing industry has been around for 40 years; and you would assume that this should be easy on a Mac because it is a great platform for "creative professionals". And indeed it's not hard if you just want to print one column of 80 characters. You can even do that in TextEdit, where you pick a plain text font and font size so that lines don't wrap, and there you go. If you are using a more capable GUI text editor like TextWrangler (I use Emacs all the time but I don't know about printing from Emacs), you are given more customization options like header and line numbers. However, 80 character lines look awful on a 8.5'' wide page. Characters are HUGE (to me anyway). Note that monospaced fonts usually look better when they are smaller (I'm a [10pt bitmap Monaco fan](/blog/2015-08-31-after-all-these-years-10pt-non-anti-aliased-monaco-is-still-the-best.html)), and do keep in mind that we are usually farther away from a computer screen than a piece of paper held in hand, so even "10pt" could look pretty big in print. Moreover, you most likely get the outlined version of your font in print rather than the bitmap version, which depending on your font of choice might not be a good thing, and the difference is amplified when characters are big. And above all, you waste a lot of paper this way, and create stapling problems for yourself when the document is long. In short, I don't find it a good solution.

It would be much nicer if we could print in two columns. The characters will be pretty small so it's probably not very good for older people (or they could try two columns in landscape), but I'm still pretty young and have fairly good eyesight, so I like this idea. But turns out this is nontrivial with existing GUI programs, at least the ones that I know of. You could emulate the two-column layout by having four pages on one sheet, but it's really awkward because you get a page divider in each single column (waste of space), and page numbering would be all messed up. Other than that there's little you could do. I guess there's just not enough market for this particular need. Luckily we have a large selection of modular command line utilities that we can stitch together for great results. I'll cut the bullshit here and just show you the <span id="code">code</span> (for US letter):

```bash
curl https://www.gnu.org/software/bash/manual/bash.txt \
    | pr --columns=2 --width=168 --length=120 --form-feed --date-format=%Y-%m-%d --header="Bash Reference Manual" - \
    | enscript --media=Letter --header= --font=Courier5.5 --margins=18:18:0:18 --output - \
    | ps2pdf - bash-print.pdf
```

Here, as an example, I'm printing the ASCII text version of the Bash Reference Manual. `pr` ships with `coreutils` (OS X also ships with the BSD version of `pr`, but geez, I'm a `coreutils` fan), so if you just `brew install coreutils` then you should use `gpr` instead. `enscript` here is [GNU Enscript](https://www.gnu.org/software/enscript/), which could be installed with `brew install enscript` (credit to [Ask Ubuntu](https://askubuntu.com/questions/27097/) for pointing me to this utility). `ps2pdf` ships with GhostScript, so you could do `brew install gs`, but you should already have it if you've got the MacTeX or TeXLive distribution installed. The options I'm using should be pretty self-explanatory and tweakable, but in case you don't understand something, just RTFM (that way you could also find more options). Anyway, a page of `bash-print.pdf` from the above looks like this (this one happen to be a 72-char-per-line document, whereas my numbers are tailored for 80; the image is at 300 ppi):

![Sample page from `bash-print.pdf` generated above. I drew a black, one-pixel border so you could tell the page from the background.](/img/20151010-bash-print-sample-page.png)

P.S. Preview.app on El Capitan just caught me by surprise. If memory serves, exporting PDF to PNG in Preview.app used to produce only one image for the current page, but now apparently you get a single, gigantic [APNG](https://en.wikipedia.org/wiki/APNG) with each page in a frame. It's not very useful at 10 fps, though. Also, exporting to JPEG doesn't give you an MJPEG.
