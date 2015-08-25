---
title: "Automated OS X provisioning"
date: 2015-08-25T08:16:44-07:00
date-display: August 25, 2015
---
After quite a bit of work, I finally have a decent OS X provisioning system, capable of provisioning a blank OS X install (with Xcode and CLT) for development and everyday life.

Here it is: [`zmwangx/dotfiles/provision`](https://github.com/zmwangx/dotfiles/blob/master/provision). In case the path changes in the future and invalidates the aforementioned URL, [here](https://github.com/zmwangx/dotfiles/blob/d8e20b731583d69b380d422c8788f61cd4a4e211/provision) is the archived provisioning script at the current master. Of course the provisioning system is not a single script; it reads and executes modules from a [`provision.d`](https://github.com/zmwangx/dotfiles/tree/master/provision.d) directory, which in turn links into other specialized parts of the system.

Selling points:

* Highly modular due to the `provision.d` structure. New provisioning scripts for specialized tools can be added at any time without complicating the rest of the system.

* Graceful failure and easy error recovery. For most failures, running the provision once more fixes the issues. This is especially helpful when GitHub get DDoS'ed and loads of downloads fail, e.g., [last night](https://web.archive.org/web/20150825150044/https://status.github.com/messages), when I was sleeping with the provisioning system hard at work.

* Very nice, colored console messages. Of course you'd expect that when half of the code is devoted to messaging...

Thus far tested on OS X 10.10 and 10.11. Works pretty well. Of course OS X provisioning (with so many impossible-to-automate tasks) is still a hell lot harder than Linux provisioning, but hopefully this system will safe me a considerable amount of time and trouble during my at-least-twice-a-year clean OS installation and beta testing in VMs.

![`provision` at work. Provisioning a blank machine is probably the only time I need Terminal.app.](/img/20150825-osx-provisioning-system.png)
