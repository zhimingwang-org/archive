---
layout: post
title: "Going Diceware"
date: 2014-11-28 19:05:59 -0800
comments: true
categories: 
---
Today I'm officially going [Diceware](http://world.std.com/~reinhold/diceware.html). I published my simple C implementation of diceware on [GitHub](https://github.com/zmwangx/diceware).

I've been using 1Password for a couple years now, and I've always been a bit worried about my master password. It's a ~30 byte monster with uppercase, lowercase letters, numbers, and special symbols. By any measure it is very safe. The problem is there are (extremely) personal things in there. I assembled several unrelated things that I (secretly) hold dearest to my heart, obfuscated them with rules not found in best64, and mixed with semi-gibberish. My daily login password is a combo similar in nature, with less obfuscation to facilitate typing. People who dig really deep into my identity might be able to compromise it (or not); I'm afraid that I'm more predictable than I thought I was. I know, the worry is pretty much unwarranted, as I’m not likely the target of a focused attack — I’m neither rich nor equipped with sensitive information or power, and for wide-range exploits, 99.9% of people are lower-hanging fruits. Even for a targeted attack, [xkcd 538: Security](http://xkcd.com/538/) broke a crypto nerd’s imagination with a $5 wrench. However, a geek is a geek, you can’t block a geek’s imagination.

Therefore, after worrying for so long, today I’m going Diceware. Eight diceware words give you at least 100 bits of true entropy. Unfortunately I don’t have a die, and don’t bother to get one. (Amazon Prime: get it Monday? No. Target, six miles away? No.) So I read my random bits from `/dev/urandom`. The C implementation is [here](https://github.com/zmwangx/diceware). By publishing this I’m announcing to the world that I’m using diceware. But I’m not afraid, since I’m now protected by true entropy that’s not compromised by publishing the scheme.
