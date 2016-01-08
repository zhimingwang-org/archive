---
title: "Apple's customer service is still the best (plus an Authy horror story)"
date: 2015-05-29T20:40:05-07:00
date_display: May 29, 2015
---

Recently the mute switch (officially known as the Ring/Silent switch) on my little-more-than-half-a-year-old iPhone 6 Plus stopped working. It almost always bounced back to ON (ring) position upon turning, and even if I could keep it at the OFF position for five seconds, it would most likely bounce back when I thrust it into my pocket. I got bitten a few times — almost got heart attacks when the phone dinged loudly in class. Minor yet annoying problem.

So I took my phone to the Genius Bar today, prepared to have it sent to a repair center[^repair-center] and get a loan in the mean time — basically, I was prepared for all sorts of trouble. But nope. I demoed the problem for three seconds, my agent explained to me in five seconds that the switch alone was hard to replace and took fifteen seconds to verify my warranty status (I suppose), then off he went to retrieve a brand new replacement for me. No questions asked about the little dent on my old phone or whatever. *So I ended up with a brand new phone in less than five minutes.* (Of course, redoing setup and restoring backup took much longer than that.)

[^repair-center]: As I see no obvious way to replace the switch in store. My intuition was later confirmed.

This is *the* customer service we should receive everywhere. Unfortunately, Apple seems to be one of the very few tech giants (or the only one?) that take customers seriously. Yeah, Apple sells products at a premium; but hey, they also live up to what one would expect from a premium product.

---

By the way, my only gripe during the process wasn't with Apple; it's about setting up Authy on the new phone. I verified my phone number via SMS and signed into Authy. I entered my backup password, which must be correct since it came straight off 1Password. My Authenticator accounts were displayed (I didn't verify if they would produce TOTPs) but a weird error message along the line of "data is corrupted" was shown to me, asking me to verify my phone for a second time. Unsuspecting, I asked Authy to send me another SMS, and entered the code I got. Then boom! All of a sudden *all my Authenticator accounts were gone*, leaving me with merely an Authy dev and a Coinbase account, which were the only ones that use Authy's native auth system. My heart almost sank for a second; I could almost foresee hours going down the drain, recovering (dozens of) accounts and regenerating new keys for two-factor auth.

That was before I immediately realized that all my secret keys were safe and sound in 1Password's database. In the past few months, AgileBits implemented TOTP support in both the iOS and OS X versions of 1Password. The day [OS X support came into stable 5.3](https://blog.agilebits.com/2015/04/06/1password-5-3-for-mac-the-bionic-edition-is-out/), I exported all my Authenticator secret keys from Authy to 1Password (with help from [this blog post](https://www.pommepause.com/2014/10/how-to-extract-your-totp-secrets-from-authy/)[^blog-post]). At that time I didn't expect 1Password would save my day later. Overall, the $50 (OS X) plus $17 (iOS) I spent on 1Password was my most worthwhile spend on software, ever.

[^blog-post]: The first comment below that post is mine.

The lesson to learn from my Authy horror story is that one should export and backup Authenticator secret keys from Authy before it's too late. Moreover, this one shitty experience with Authy is enough to keep me away from it for the ages to come, except for services that are Authy-specific, e.g., Coinbase[^bitcoin]. 1Password is the way to go, and with the addition of TOTP, it is one more step towards a truly one password experience. If you don't own 1Password yet, you should really get it, now.

[^bitcoin]: I have a Coinbase account and probably around 0.01 BTC in my wallet, but I don't really use bitcoins. At the time I signed up for two-factor auth on Coinbase, Authy seemed to be only supported system; however, I just signed in again and it seems that Coinbase is now supporting Authenticator also. Whatever the case, Authy is practically dead for me.
