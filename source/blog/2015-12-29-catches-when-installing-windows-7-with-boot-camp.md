---
title: "Catches when installing Windows 7 with Boot Camp"
date: 2015-12-29T15:09:16-08:00
date_display: December 29, 2015
---
I was looking for a use for my retired Mid-2012 Non-Retina MacBook Pro 13''^[2.9 GHz i7 + Intel HD Graphics 4000 + 16 GB RAM + frigging slow 750 GB 5400-rpm spinning disk I've yet to replace.], and unsurprisingly I figured that I would turn it into a OS X-Windows dual boot for some occasional gaming. I'm a CnC fan (not hardcore, but still), mainly for RA2/YR and TW/KW, and playing these inside Fusion is really a subsubpar experience. Due to the age of these games and their compatibility problems on Windows 8 and higher^[RA2/YR used to have problems even on Windows 7, at least inside Fusion, so I used to play them in XP SP3 VMs; I've yet to try them with Windows 7 running on bare metal.], I chose to shoot for a Windows 7 install.

Apple has a pretty thorough walkthrough in the support article [Install Windows 7 and earlier on your Mac using Boot Camp](https://support.apple.com/en-us/HT205016). There are, however, some catches that I would like to collect and share in this post.

1. Win 7 ISO isn't available for download in the appropriate language (given your product key). This one sounds incredibly stupid... But it is a real problem at least for me and several others (just Google). I have a valid Win 7 Ultimate license from my institution, so I went to <https://www.microsoft.com/en-us/software-download/windows7> to grab my ISO (just for fun; I already have the image). However, after verifying my product key, here's the list of languages that I'm asked to choose from, where English is apparently missing (!!!):

    <div class="figure">
    <img height="365px" src="/img/20151229-win7-iso-language-choice.png" alt="da !@#$?"/>
    <p class="caption">da !@#$?</p>
    </div>

    I don't know the solution to this problem. In my case I've archived English Win 7 Ultimate SP1 images (both x86 and x64) before, so I just proceeded with my old image.

2. FileVault. It is my belief that FileVault needs to turned off before partitioning the drive with Boot Camp.^[I'm not completely sure that this is necessary. I was greeted with partitioning errors initially which I thought was due to FileVault, so I switched it off (the actual process is much longer than "switching it off", since the whole disk has to be decrypted and rewritten), but as you'll see later, the partitioning errors were at least partly due to a slightly corrupt filesystem.]

3. *An error occured while partitioning the disk.* That's the unhelpful message from Boot Camp. If you try to manually partition the drive with Disk Utility, you'll probably get a much more helpful message like *Partition failed with the error: couldn't modify partition map because file system verification failed*. Now the problem is obvious, and the solution is simple. Boot to single user mode and repair the filesystem with `/sbin/fsck -fy`, or safer, `/sbin/fsck -f` which might require interaction.

4. During Windows installation you'll obviously be prompted to choose a system partition at some point, and due to Boot Camp only formatting to FAT32, you'll get the message *Windows cannot be installed to this hard disk space. Windows must be installed to a partition formatted as NTFS.* This one is easy, just click "Drive options (advanced)" then "Format", which automatically formats the partition to NTFS. This is actually documented in Apple's walkthrough, but mortals do panic in face of error messages, so let's also note it here.

5. Even after formatting the Boot Camp partition, it is still possible to get the error *Setup was unable to create a new system partition or locate an existing system partition*. It this happens, check if you have any USB drives (other than the installation media) plugged in. In my case my Time Capsule was plugged in, and rebooting with it unplugged fixed the problem. The exact cause of the problem is unclear to me. Some say it's due to Master Boot Record limiting the number of partitions to four, but why the heck is my external drive counted towards that limitation? I'd go for Win 7 installer is just confused. Anyway, just unplug anything that's not needed during Windows installation.

Hopefully you're good after solving the aforementioned problems. If you followed Apple's walkthrough correctly, Boot Camp's setup.exe will be invoked automatically immediately after Windows finishes installation, and after a certain number of reboots your drivers will be up and running. Now you're ready to take control of your Windows. Install Chrome ^[You can't even browse Microsoft's own websites with stock IE8. And IE11 is locked behind a hell lot of Windows Updates (even then it is crap). Doing Windows Update is like building up a tech tree.] and Microsoft Security Essentials immediately, then hop right into the Windows Update hell to patch your four-year-old system. Of course, Windows Update being Windows Update won't be smooth — servers will be crowded as ever and just checking for updates will likely take forever, let alone downloads. After a semi-infinite amount of time you'll get your estimates (I got 212 updates). Click update and let Windows Update grind for hours. And wish yourself a good luck (that no update errors will occur — luckily I didn't get any).

By the way, the otherwise great Apple trackpad is almost unusable on Boot Camp Windows under any setting. I'm forced to use a mouse.
