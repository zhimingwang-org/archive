---
title: "OS X package receipts"
date: 2014-10-25T13:26:02-0700
date-display: October 25, 2014
---
I just learned something new. Whenever you install a `pkg` on OS X, OS X stores a receipt of what was installed in `/var/db/receipts` (I'm running OS X 10.9.5 at the time of writing), called a **bom** — bill of materials (I’d rather call it a manifest, whatever). This feature was introduced in NeXTSTEP. From `man 5 bom`:

> The Mac OS X Installer uses a file system "bill of materials" to determine which files to install, remove, or upgrade. A bill of materials, **bom**, contains all the files within a directory, along with some information about each file. File information includes: the file's UNIX permissions, its owner and group, its size, its time of last modification, and so on.  Also included are a checksum of each file and information about hard links.

`man 5 bom` is actually badly maintained, as it says "The bill of materials for installed packages are found within the package receipts located in /Library/Receipts," whereas those have been migrated to `/var/db/receipts` a long time ago.

`.bom` files are binary, but you can access the contents via `lsbom`. For instance, to list the files installed,

    lsbom -f /var/db/receipts/org.macports.MacPorts.bom

Note that the paths printed are always relative to `/`. See `man 1 lsbom` for detailed option listing.

(Beware when you try to clean up unwanted packages using the `lsbom` listing. Packages might overwrite files, so make sure you review the listing first and know what you are doing. "Knowing what you are doing" is the prerequisite for using `sudo` anyway.)
