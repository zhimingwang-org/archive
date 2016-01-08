---
title: "Graceful handling of <code>SIGINT</code> when using Python's <code>multiprocessing.Process</code>"
date: 2015-05-05T22:03:39-07:00
date_display: May 5, 2015
...

Today I learned something about Python's (at least CPython's) multiprocessing and signal handling, and I would like to share it here. Basically my situation was such (when developing [`pydoc`](https://github.com/zmwangx/zmwangx.github.io/blob/source/pyblog) that powers this blog):

* I would like to serve the blog with an HTTP server while auto-regenerating for changes;
* The auto-regeneration is handled in the main process with a while loop, whereas the HTTP server (requiring little human intervention) is put in a `multiprocessing.Process` and launched with `http.server.HTTPServer.serve_forever()`;
* Upon sending `SIGINT`, both processes need to clean up and quit; in particular, the server needs to exit its `serve_forever()` loop (which can be done via `shutdown()`, but how to invoke the method is a problem, since `serve_forever()` blocks);
* Handling of `SIGINT` must be graceful in the main process — there might be an ongoing build that must not be interrupted until finishing.

Given this context, I learned the following two critical concepts (at least true in the current version of CPython) through trial and error:

1. **A user-triggered `SIGINT` is sent to both processes** — the main process and the `multiprocessing.Process` instance;
2. **Except for the defined interfaces, a `multiprocessing.Process` instance is almost completely separated from the main process, sharing as little resources as possible**; by "defined interfaces" I mean the defined attributes and methods of a `Process` instance, as well as defined communication channels like `multiprocessing.Pipe` or `multiprocessing.Queue`. And to expand on resource sharing: yes, the two processes have their own copies of global variables, so using global variables as state registers is a no-go.

Both concepts can be used to one's benefit or detriment. Below is how I solved my problem, using the two concepts. Observe that without a custom handler, Python translates a `SIGINT` to a `KeyboardInterrupt` exception; therefore, I use the default `KeyboardInterrupt` to interrupt the HTTP server in its own process (through handling the exception and calling `shutdown()`), but instead install a custom `SIGINT` handler in the main process that translates `SIGINT` to setting a `sigint_raised` flag that can be picked up by the while loop once the current build (if any) is finished. The proof of concept script is as follows (the production code is [here](https://github.com/zmwangx/zmwangx.github.io/blob/a7a0b2073f30b1d0214c3152998d95e40a39b438/pyblog#L567-L635)):

```python
#!/usr/bin/env python3

import http.server
import multiprocessing
import signal
import sys
import time

class HTTPServerProcess(multiprocessing.Process):
    def run(self):
        httpd = http.server.HTTPServer(
            ("", 8000), http.server.SimpleHTTPRequestHandler)
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            httpd.shutdown()

def do_things():
    for i in range(10):
        sys.stderr.write(".")
        sys.stderr.flush()
        time.sleep(1)
    sys.stderr.write("\n")

def main():
    server_process = HTTPServerProcess()
    server_process.start()

    # define and install custom SIGINT handler
    sigint_raised = False

    def sigint_mitigator(signum, frame):
        nonlocal sigint_raised
        sigint_raised = True

    signal.signal(signal.SIGINT, sigint_mitigator)

    while not sigint_raised:
        do_things()

    server_process.join()

if __name__ == "__main__":
    main()
```

Beware that with this solution, if there are external programs or OS level operations happening in the main process, then the operation at the time of `SIGINT` will still be interrupted[^OS-specific] (for example, in the script above, the `time.sleep(1)` at the exact point of `SIGINT` is still interrupted, but otherwise `do_things` is carried on to its completion). I'm not sure how to explain this — maybe the handler isn't capturing the signal fast enough?[^naive] Anyway, one single early interruption is at least more acceptable than a completely corrupted build[^interruption], and certainly more graceful.

[^naive]: That's awfully naive and layman-sounding, I know, but I *am* almost a layman when it comes to system-level programming.

[^OS-specific]: [CPython's `multiprocessing` is written in C](https://hg.python.org/cpython/file/1320ec1b24af/Modules/_multiprocessing), so the behavior might depend on the OS. I'm talking about OS X here. I haven't inspected and won't inspect the C source code.

[^interruption]: That's assuming your build isn't interdependent in which any single failure corrupts everything. In that case, what can we do? I honestly see no way of injecting signal handling in `subprocess.Popen`.
