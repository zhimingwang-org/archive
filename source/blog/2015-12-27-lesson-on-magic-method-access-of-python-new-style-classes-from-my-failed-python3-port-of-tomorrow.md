---
title: "Lesson on magic method access of Python new-style classes (from my failed Python3 port of Tomorrow)"
date: 2015-12-27T16:47:05-08:00
date_display: December 27, 2015
---
I know the title is formidably long, but I can't find something more accurate (and my homegrown mini CMS doesn't support subtitle), so please bear with me.

So, I have [madisonmay/Tomorrow](https://github.com/madisonmay/Tomorrow) — "magic decorator syntax for asynchronous code in Python 2.7" — bookmarked for a long time[^long] without ever trying it, because I simply don't write Python 2 code any more (except when I try to maintain compatibililty). I felt kind of strange that a ~50-line project with ~1000 stars on GitHub hasn't been ported to Python 3 already, so I gave it a shot just now.

I thought it would be easy:

1. Modernize the old-style class `Tomorrow`;
2. Replace `__getattr__` with `__getattribute__` for unconditional attribute routing, then make a few exceptions to prevent infinite recursion;
3. `2to3` test cases;
4. Make meta changes, like removing the `futures` dependency.

However, after doing 1–3, I ran the tests, and out of the five test cases, three failed and one errored. I tried to isolate the problem, and ended up with the following piece of proof-of-concept:

```python
class PassThrough(object):

    def __init__(self, obj):
        self._obj = obj

    def __getattribute__(self, name):
        if name == "_obj":
            return object.__getattribute__(self, name)
        print("Accessing '%s'" % name)
        return self._obj.__getattribute__(name)
```

This snippet is valid in both Python 2.7 and Python 3, but here's the surprise:

```python
>>> g = PassThrough(0)
>>> print(g)
<__main__.PassThrough object at 0x10c662e48>
>>> str(g)
'<__main__.PassThrough object at 0x10c662e48>'
>>> hasattr(g, '__str__')
Accessing '__str__'
True
>>> g.__str__()
Accessing '__str__'
'0'
```

In addition, here's what happens if you try to "pass through" a function:

```python
>>> def f(): return True
>>> g = PassThrough(f)
>>> g()
Accessing '__class__'
Accessing '__class__'
Traceback (most recent call last):
  File "<ipython-input-6-d65ffd94a45c>", line 1, in <module>
    g()
TypeError: 'PassThrough' object is not callable

>>> callable(g)
False
>>> hasattr(g, '__call__')
Accessing '__call__'
True
>>> g.__call__()
Accessing '__call__'
True
```

As you can tell, although `__str__` or `__call__` may have been implemented through `__getattribute__`, and `hasattr` (which in turn depends on `getattr`) has no trouble finding them, they are not picked up by `str` or function call `(...)`. At this point, one would suspect that this is due to `str` or function call only looking at the class instance's `__dict__`. Compare this to the behavior of an old-style class:

```python
class PassThrough():

    def __init__(self, obj):
        self._obj = obj

    def __getattr__(self, name):
        print("Acessing '%s'" % name)
        return self._obj.__getattribute__(name)
```

Now:

```python
>>> g = PassThrough(0)
>>> print(g)
Acessing '__str__'
0
>>> def f(): return True
>>> g = PassThrough(f)
>>> g()
Acessing '__call__'
True
```

Note that magic method access is always routed through `__getattr__`.

After some digging, my suspicion was confirmed: indeed, for new-style classes, rather than invoking `__getattribute__`, the Python interpreter only looks for magic methods in `__dict__`. But is there a workaround for implementing something like the `PassThrough` class above? There's a [nice answer](http://stackoverflow.com/a/9059858/) on StackOverflow that uses a metaclass to "automatically add proxies for magic methods at the time of class creation", to quote the author. However, the thing about Tomorrow is that *we don't have the result and don't know whatever magic methods it might have at class creation* — after all, Python isn't a statically typed language. It is possible for programmers to offer hints, but then Tomorrow won't be as elegant and magical anymore. Therefore, unfortunately enough, Tomorrow isn't portable to Python 3 — at least not without a substantial hack that's beyond my knowledge, or a complete overhaul of its logic (haven't thought about that).

[^long]: Pretty much since the beginning, I believe (the [initial commit](https://github.com/madisonmay/Tomorrow/commit/22a53dfbcf9b516ecd1770eeca9fcf1720271240) was from July 24 of this year). I don't remember how I came accross it though.
