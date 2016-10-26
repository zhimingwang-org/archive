---
title: "pyenv: compiling Python with SQLite in nonstandard location"
date: 2016-10-26T12:16:22-04:00
date_display: October 26, 2016
---

This is a quick post sharing a workaround that I needed just now.

I was trying to compile Pythons with pyenv on a RHEL 6.8 cluster. Unfortunately `sqlite-devel` is not installed and I doubt I can convince my sysadmin to install a package for me. The lack of SQLite headers resulted in Pythons without `_sqlite3` which is essential for me. Hitting at SQLite headers from Linuxbrew with `CPATH` did not help either.

Digging into CPython source code, turns out that CPython only looks into [a fixed set of paths](https://github.com/python/cpython/blob/59fa72e34da71fb24f52251c1cc88ed3c3b14797/setup.py#L1132-L1138):

```python
sqlite_inc_paths = [ '/usr/include',
                     '/usr/include/sqlite',
                     '/usr/include/sqlite3',
                     '/usr/local/include',
                     '/usr/local/include/sqlite',
                     '/usr/local/include/sqlite3',
                     ]
if cross_compiling:
    sqlite_inc_paths = []
```

Well that's unfortunate. Luckily pyenv makes it really easy to patch Python source code; take a look at [`plugins/python-build/share/python-build/patches`](https://github.com/yyuu/pyenv/tree/master/plugins/python-build/share/python-build/patches) and you'll get the idea. Therefore, in the case of Linuxbrew'ed pyenv and SQLite, say we want to build Python 3.5.2 with SQLite support, we simply put the following patch at `~/.linuxbrew/opt/pyenv/plugins/python-build/share/python-build/patches/3.5.2/Python-3.5.2/linuxbrew-sqlite3.patch`:

```diff
diff --git a/setup.py b/setup.py
index 174ce72..774fd65 100644
--- a/setup.py
+++ b/setup.py
@@ -1108,6 +1108,7 @@ class PyBuildExt(build_ext):
                              '/usr/local/include',
                              '/usr/local/include/sqlite',
                              '/usr/local/include/sqlite3',
+                             os.path.expanduser('~/.linuxbrew/opt/sqlite/include/'),
                              ]
         if cross_compiling:
             sqlite_inc_paths = []
```

That's it. Now

```
$ pyenv install 3.5.2
```

and enjoy.
