---
title: "OS X system ruby encoding annoyance"
date: 2015-01-01T22:49:39-0800
date_display: January  1, 2015
---

I've been using RVM (with fairly up-to-date Rubies) and pry since my day one with Ruby (well, almost), so it actually surprises me today when I found out by chance how poorly the system Ruby behaves when it comes to encoding.

The major annoyance with the current system Ruby (2.0.0p481) is that it can't convert `UTF8-MAC` to `UTF-8` (namely, NFD to NFC, as far as I can tell), at least not with Korean characters. Consider the following script:

```ruby
# coding: utf-8
require 'hex_string'
str = "에이핑크"
puts str.to_hex_string
puts str.encode("UTF-8", "UTF8-MAC").to_hex_string
```

Here are what I get with the system Ruby and the latested brewed Ruby:

```bash
> /usr/bin/ruby --version
ruby 2.0.0p481 (2014-05-08 revision 45883) [universal.x86_64-darwin14]
> /usr/local/bin/ruby --version
ruby 2.2.0p0 (2014-12-25 revision 49005) [x86_64-darwin14]
> /usr/bin/ruby utf8-mac.rb
e1 84 8b e1 85 a6 e1 84 8b e1 85 b5 e1 84 91 e1 85 b5 e1 86 bc e1 84 8f e1 85 b3
e1 84 8b e1 85 a6 e1 84 8b e1 85 b5 e1 84 91 e1 85 b5 e1 86 bc e1 84 8f e1 85 b3
> /usr/local/bin/ruby utf8-mac.rb
e1 84 8b e1 85 a6 e1 84 8b e1 85 b5 e1 84 91 e1 85 b5 e1 86 bc e1 84 8f e1 85 b3
ec 97 90 ec 9d b4 ed 95 91 ed 81 ac
```

As you can see, in the case of the system Ruby, NFD is left untouched. This leads to problems with, for instance, Google Translate. One obvious solution is to outsource the task to `iconv`, but I have the impression that outsourcing language features to shell commands is a generally despised practice.

There's one more surprise. While `pry` with latest Rubies tend to handle Unicode very well (unlike `irb`), I tried `pry` with the current system Ruby, and it doesn't work; due to this annoying limitation, I couldn't even test the above problem interactively, and had to resort to a script. Maybe the problem can be resolved by compiling Ruby with `readline` or whatever; I didn't bother. The bottom line is, the system Ruby is not very pleasant for men in the 21st century — good Unicode support ought to be a must. (By the way, NFD in HFS+ is maddening. It breaks Terminal, iTerm, Google Translate, scp with Linux hosts, and the list goes on.)

P.S. In Dropzone 3 custom actions you can select a custom Ruby with the `RubyPath` meta field, e.g.,

```ruby
# RubyPath: /usr/local/bin/ruby
```
