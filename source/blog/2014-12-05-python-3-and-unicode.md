---
title: "Python 3 and Unicode"
date: 2014-12-05 15:01:54 -0800
date-display: December  5, 2014
---
I never realized that in Python 3 Unicode is the default; in particular, `str` in Python 3 is practically equivalent to `unicode` in Python 2. This might be the *one thing* that convince me to migrate. `str.encode()`, `str.decode()`, `unicode.encode()`, `unicode.decode()`, etc. are so confusing that I'm never 100% sure what I'm doing (only-occasionally-used-but-unavoidable-and-worst-of-all-very-confusing "features" are nightmares).
