---
title: "This blog is now behind CloudFlare"
date: 2016-09-01T20:11:00+08:00
date_display: September 1, 2016
---

Back in July I registered the domain [zhimingwang.org](http://zhimingwang.org) and pointed this GitHub Pages-powered blog at it. Since then I have lost the HTTPS badge due to GitHub Pages not supporting HTTPS on custom domains (see [isaacs/github#156](https://github.com/isaacs/github/issues/156)).

There have been a lot of discussions on isaacs/github#156 (and stupid [+1's](/blog/2016-01-18-me-too-comments-on-github.html) too). Among the proposed solutions is putting the website behind CloudFlare. I carefully investigated [this option](https://blog.cloudflare.com/secure-and-fast-github-pages-with-cloudflare/) and read almost all the arguments against it. I fully understand CloudFlare's SSL models (summarized in the image below), and I do realize most if not all of the limitations of CloudFlare, including CloudFlare being a huge MITM (which is inevitable for a CDN anyway), as well as most if not all of its annoyances, including CAPTCHAs which I myself would occasionally run into when I'm browsing with PIA VPN, and JavaScript-based browser checks.

![|500| CloudFlare's SSL modes. I use the Full SSL mode so that both ends of the connection are encrypted. Again, I know CloudFlare is a big MITM and could be a high profile target. Credit: [CloudFlare](https://blog.cloudflare.com/secure-and-fast-github-pages-with-cloudflare/).](/img/20160901-cloudflare-ssl-modes.png)

After careful evaluation, I decided that CloudFlare's SSL model is good enough for me. After all, this is just a damn blog, with nothing sensitive. TLS is still nice because it guards against prying eyes and unethical ad-injecting ISPs or Wi-Fi hotspots, but other than that, it isn't necessary.

End result: this blog is now behind CloudFlare. Readers should now see that green HTTPS badge again (note that I'm enforcing HTTPS — without HSTS though). As for CAPTCHAs, I have adjusted the firewall settings on CloudFlare's dashboard — "Security Level" to "Essentially Off" and "Challenge Passage" to 1 year, so hopefully it won't be too annoying.[^tor]

[^tor]: I don't use Tor, and don't intend to raise Big Brother's suspicion by using it, so I have no idea of the actual Tor experience.

**09/01/2016 Update.** I just realized that [CloudFlare supports whitelisting Tor traffic](https://support.cloudflare.com/hc/en-us/articles/203306930-Does-CloudFlare-block-Tor-). Did that.
