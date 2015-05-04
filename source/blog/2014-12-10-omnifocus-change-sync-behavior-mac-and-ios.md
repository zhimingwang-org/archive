---
title: "OmniFocus: change sync behavior, Mac and iOS"
date: 2014-12-10 22:45:34 -0800
date-display: December 10, 2014
---
On OS X, the following URIs are relevant:

* <a href="omnifocus:///change-preference?MaximumTimeBetweenSync=30">omnifocus:///change-preference?MaximumTimeBetweenSync=30</a>
* <a href="omnifocus:///change-preference?TimeFromFirstEditToSync=2">omnifocus:///change-preference?TimeFromFirstEditToSync=2</a>

What they do are self-evident.

On iOS, use the following URIs instead:

* <a href="x-omnifocus-debug:set-default:MaximumTimeBetweenSync:60">x-omnifocus-debug:set-default:MaximumTimeBetweenSync:60</a>
* <a href="x-omnifocus-debug:set-default:TimeFromFirstEditToSync:2">x-omnifocus-debug:set-default:TimeFromFirstEditToSync:2</a>

Source: [Change Default Sync Times of OmniFocus For Mac and iOS](http://www.macstories.net/links/change-default-sync-times-of-omnifocus-for-mac-and-ios/).
