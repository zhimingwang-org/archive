---
title: "Virtualenvs for everyone"
date: 2016-01-01T22:21:14-08:00
date_display: January 1, 2016
---
Python distutils for the most part is rather pleasant to work with. That is, pleasant until you've accumulated so many packages that you eventually run into a clash of namespace, or a dependency conflict (or dependency hell as most would affectionately call it).[^trouble] In contrast, npm's approach to dependencies shuts out dependency hell completely, but it is so paranoid and costs so much duplication that I find it hard to appreciate unless necessary. Somewhere in between there's the virtualenv approach which I find most appealing for smallish projects — keep a single copy of each package in the dependency tree in a contained environment specific to the project at hand. This is how we debug Python projects, and it certainly also should be *the* way we run command line tools written in Python.

There's another reason I like virtualenvs. There are tons of problems associated with choosing between Python 2 and 3 — some projects are Python 2 only, some are instead Python 3, some claim to be compatible with both but actually present subtle problems when you use one instead of the other. However, without virtualenvs, there's only one `bin` — `/usr/local/bin` — and everything's competing for it. Most programs (especially ones with a typical `setup.py`) don't install a soft/hardlink with a helpful `2` or `3` suffix when installing executables, let alone detailed suffixes like `2.7` or `3.5`, so without probing into the shebangs you're never sure which version of Python you're running your program with, and as a result Python 2/3 (or even a point release)-specific bugs occur randomly. Virtualenvs solve the problem by allowing you to have as many bins (and includes, and libs) as you like.

Hence the title "virtualenvs for everyone". I would like to install each command line program written in Python into a separate virtualenv. The only issue is that apparently I don't want too many bins in my `$PATH`; to solve this issue, the executable bits of each project should be linked to a central place, for which I choose `$HOME/bin`. There could be as many symlinks as we like, so now we can have multiple links with increasing detailed version suffixes, e.g., `3`, `3.5`, `3.5.1`. Very nice.

This task could clearly be automated; the only slightly tricky bit is to programmatically figure out which scripts a project installs to `bin`. Luckily, for projects using `setuptools.setup`, we can simply spoof that function. Here's my `setuptools/__init__.py`:

```python
#!/usr/bin/env python3

"""setuptools stubs.

Here we only stubbed the symbols in setuptools.__all__. Hopefully that's
enough (actually I can't remember seeing any setup.py using more than
setup and find_packages).

setup has been spoofed to print the names of scripts, console_scripts
and gui_scripts defined in the arguments to setup. Some user-friendly
messages are also printed to stderr.

"""

from __future__ import print_function

import re
import sys
import os

__all__ = [
    'setup', 'Distribution', 'Feature', 'Command', 'Extension', 'Require',
    'find_packages'
]

def setup(**kwargs):
    scripts = [os.path.basename(script_path)
               for script_path in kwargs.pop('scripts', [])]
    if scripts:
        print('scripts:\n  - %s' % '\n  - '.join(scripts), file=sys.stderr)
    entry_points = kwargs.pop('entry_points', {})
    for entry_point in ['console_scripts', 'gui_scripts']:
        extra_scripts = [re.split('(\s|=)', spec.strip())[0]
                         for spec in entry_points.pop(entry_point, [])]
        if extra_scripts:
            print('%s:\n  - %s' % (entry_point, '\n  - '.join(extra_scripts)),
                  file=sys.stderr)
        scripts.extend(extra_scripts)
    print('\n'.join(sorted(scripts)))

class Distribution(object): pass
class Feature(object): pass
class Command(object): pass
class Extension(object): pass
class Require(object): pass
def find_packages(**kwargs): pass
```

Now, let `$HERE` be the directory containing our fake `setuptools/`, and `$PROJECT_ROOT` be the project root directory containing `setup.py`. Run

    PYTHONPATH=$HERE:$PYTHONPATH python $PROJECT_ROOT/setup.py

and bam! We get the names of all scripts on stdout.

My full automation scripts, including the Zsh main function `virtual-install`, can be found in [`modules/python/functions` in zmwangx/prezto](https://github.com/zmwangx/prezto/tree/master/modules/python/functions). I'm not including it here because it uses some custom helper, and it's just too long (200+ lines, but not very sophisticated). Happy virtualenving!

[^trouble]: In rare cases, even installing a single package could land you in trouble. The classical example is installing the `readme` package on a case-insensitive filesystem (e.g., the default mode of HFS+). "Unfortunately" [this](https://bugs.python.org/issue24633) has been fixed.
