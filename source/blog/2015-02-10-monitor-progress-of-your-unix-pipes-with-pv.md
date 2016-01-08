---
title: "Monitor progress of your Unix pipes with pv"
date: 2015-02-10T02:18:30-0800
date_display: February 10, 2015
---

Recently I found a very useful utility called `pv` (for "pipe viewer"). [Here](http://www.ivarch.com/programs/pv.shtml) is its home page, and it can be easily installed with `brew`. According to its man page,

> `pv` shows the progress of data through a pipeline by giving information such as time elapsed, percentage completed (with progress bar), current throughput rate, total data transferred, and ETA.

For more info, see its home page (linked above) and [man page](http://linux.die.net/man/1/pv).

Why is it useful? Well, pretty obvious if you are in the right audience. For me, one particularly important use case is with `openssl sha1`. I deal with videos on a daily basis, and back up all of them to OneDrive (ever since OneDrive went unlimited). To ensure integrity of transfer (in future downloads), I append the first seven digits of each video to its filename. This should be more than enough to reveal any error in transfer except for active attacks. One additional advantage is that I can now have multiple versions of a same show, event, or whatever and don't have to worry about naming conflicts (and don't have to artificially say `-ver1`, `-ver2`, etc.). This little merit turns out to be huge and saves me a lot of trouble, since naming things is intrinsically hard:

> There are only three hard things concurrency, in computer science: cache invalidation, naming things, and off-by-one errors.

(I learned this beefed up version of two hard things only recently.) Well, too much digression. So SHA-1 sum is useful. (By the way, I learned in my crypto class that SHA-1 is broken as a collision-resistant hash function — not HMAC, which doesn't assume collision-resistance — and SHA-256 should be used instead. However, I'm not protecting against active attacks — I won't be able to without a shared secret key anyway — so the faster SHA-1 is good for my purpose.) But at the same time, SHA-1 is slow. Maybe what's actually slow is my HDD. Whatever the bottleneck, generating a SHA-1 digest for a 10 GB video file isn't fun at all; it's even more of a torture when there's no progress bar and ETA. But hopelessly waiting has become a thing of the past with the advent (well, discovery in my case) of `pv`. Now I have nice and informative progress bars, which reduces the anxiety of waiting by an order of magnitude.

For the record, here's the current version of my ruby script that attaches the first seven digits of the SHA-1 digests of the given files to their filenames:

```ruby
#!/usr/bin/env ruby

require 'fileutils'

def rename(items)
  num_items = items.length
  num_done = 0
  items.each {|path|
    printf($stderr, "%d/%d: %s\n", num_done + 1, num_items, File.basename(path))

    if ! File.directory?(path)
      extname = File.extname(path)
      basename = File.basename(path, extname)
      dirname = File.dirname(path)
      sha1sum = `pv '#{path}' | openssl sha1`
      new_basename = basename + "__" + sha1sum[0,7]
      new_path = File.join(dirname, new_basename + extname)
      FileUtils.mv(path, new_path)
    else
      STDERR.puts("#{path}: directory ignored")
    end

    num_done += 1
  }
end

rename(ARGV)
```

You might ask why I used ruby (littered with bash) when it's obviously a job for bash or perl. Well, the reason is that I first wrote this thing in ruby as a [Dropzone 3 action](https://gist.github.com/zmwangx/d6406fb8bf51ac768770). I'm lazy, so I just borrowed that script and modified its printout for shell use.

---

By the way, I also found a project called `cv` (Coreutils Viewer), which is [officially described as](https://github.com/Xfennec/cv)

> ... a Tiny, Dirty, Linux-Only C command that looks for coreutils basic commands (cp, mv, dd, tar, gzip/gunzip, cat, etc.) currently running on your system and displays the percentage of copied data.

I'll look into it when I have time, but it from its description, it seems to be limited to coreutils, and OS X support might not be too awesome (at this point).
