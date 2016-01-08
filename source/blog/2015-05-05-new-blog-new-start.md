---
title: "New blog, new start"
date: 2015-05-05T02:42:44-07:00
date_display: May 5, 2015
---

Octopress has been serving me for the past six months, during which even Octopress itself underwent major changes — in fact, [Octopress 3.0.0](https://github.com/octopress/octopress/releases/tag/v3.0.0) was only released 3 days ago, which I never got to try. Anyway, Octopress's heavily colored interface grew old on me fairly quickly. I'm especially unhappy with the inline `<code>` tag, which is always wrapped in a white box and stands out too much (worse still, there's no visual difference when such a `<code>` tag is placed inside an `<a>` tag). Since I use inline code/verbatim a lot, many of my articles were littered with arbitrary boxes everywhere.

![Farewell, Octopress.](https://i.imgur.com/hxfSnOk.png)

Apparently I need something simpler. Because

> Simplicity is the ultimate sophistication.

But how? Simiplicity 101: get rid of the "platform". There's no reason why I need a blogging platform like Jekyll (let alone the WordPress monster). When I initially switched to Octopress, I thought code highlighting was something fancy that I need heavy machinery to achieve, but it turned out that Pandoc is battery-included when it comes to syntax highting,[^pandoc] so all I need is to specify a highlight style, e.g., Pygments:

[^pandoc]: Well, Pandoc is heavy-machinery, but it's both generic and self-contained, unlike a specialized blogging platform.

```
pandoc input.md --highlight-style=pygments --template template.html --output output.html
```

That's it. Write the Markdown, compile with Pandoc, instantly awesome. So the HTML posts are there (assuming the HTML template is written, which is not hard to kick off).

The rest of the job is to design the stylesheets and compile the posts into a coherent blog — basically, generate an index. I was able to realize both in several hours. For the former task, I borrowed a lot from [mort.ninja](http://mort.ninja/) by [Mort Yao](https://github.com/soimort). Interestingly, we were born in the same city (Nanjing, China), and I benefit from at least two of his open source projects: [you-get](https://github.com/soimort/you-get) and [translate-shell](https://github.com/soimort/translate-shell). The latter task is more interesting but also not hard. I'm rolling my own toolchain in Python, which you can find in [`pyblog`](https://github.com/zmwangx/zmwangx.github.io/blob/source/pyblog). In fact, the complete source of this blog (down to how image assets are generated) are in the [`source` branch](https://github.com/zmwangx/zmwangx.github.io/tree/source) of my GitHub Pages repo, so you may take a look if you're interested. `pyblog` is highly specialized[^pyblog] and is still a work in progress at the time of writing, but it's already well capable of generating the blog — currently missing are auto gen-deploy and preview (with auto-update), which will also come soon.

[^pyblog]: Which is fine since I don't expect anyone else to use it, anyway.

By the way, the most annoying thing in the development process was working with XML and generating [the Atom feed](/atom.xml). Standard library `xml.etree.ElementTree` doesn't support the `![CDATA[` tag, and in the end I had to hack [library internals](https://github.com/zmwangx/zmwangx.github.io/blob/source/pyblog#L34-L54), which is likely to break in future versions. Remember the quotes?

> XML is a classic political compromise: it balances the needs of man and machine by being equally unreadable to both.

> XML combines the efficiency of text files with the readability of binary files.

Sigh.

Anyway, here is my new shiny blog.

![Welcome to the completely revamped dl? cmplnts?](https://i.imgur.com/VS5f9eJ.png)

It looks ten times better than Octopress, and ever builds much faster than Octopress[^speed]. As a bonus, the codebase is so small that it's super trivial to hack (no, not *that* hack).

[^speed]: I have the impression that a complete build of all posts (about fifty of them) with `pyblog` is faster than regenerating for a single modified post in Octopress. That's in the context of absolutely no categories; when you have a dozen or more categories, Octopress slows down to a halt.
