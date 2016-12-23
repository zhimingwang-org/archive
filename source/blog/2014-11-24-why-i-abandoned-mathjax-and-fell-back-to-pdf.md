---
title: "Why I abandoned MathJax and fell back to PDF"
date: 2014-11-24T20:54:36-0800
date_display: November 24, 2014
---

Recently I wrote an expository article, [*Convolution of irreducible characters*](https://dl.bintray.com/zmwangx/generic/20141119-convolution-of-irreducible-characters.pdf), and posted it [here](/blog/2014-11-19-convolution-of-irreducible-characters.html). At first I intended to use MathJax, but in the end I fell back to good ol' PDF. Here's why.

In short, I'm a mathematician. I write math *articles*, not just standalone expressions or formulas. I use AMSLaTeX to its fullest (not really, but at least I use numbering and the `amsthm` package to its fullest). HTML simply wasn't designed for this. Here are two influential markup languages designed for totally different use cases, and bridging them is painful. I tried to use `pandoc`, but it doesn't support `\input`, doesn't support `\def`, and swallows `\begin{theorem} \end{theorem}`, among other things. I tried to use `htlatex`; even the MathML output is suboptimal, with many math symbols translated to non-math (apart from totally human-unreadable), and it uses its custom CSS files that don't play well with everything else. I tried other things. In the end I gave up. Maybe I don't know enough about MathJax, but I certainly don't want to write a translator myself. Leave LaTeX alone. Distribute as PDF. MathJax may be great for Wikis (like Wikipedia) and for math lite blogs, but it's no replacement for real, beefy LaTeX. It's not for mathematicians who want to distribute real articles.

By the way, Terry Tao and others use [Luca's LaTeX to WordPress, aka LaTeX2WP](http://lucatrevisan.wordpress.com/latex-to-wordpress/) for math blogging. From Terry's experience it works fairly well. I don't know if `amsthm` and `\def` are in the feature set, though. Anyway, since WordPress handles LaTeX as pre-compiled images (which is also the default on Wikipedia, and which looks poor in general and plays horribly with scaling), LaTeX2WP won't help MathJax users the slightest.
