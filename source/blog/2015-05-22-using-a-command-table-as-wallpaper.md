---
title: "Using a command table as wallpaper"
date: 2015-05-22T00:48:19-07:00
date-display: May 22, 2015
---
Recently I cleaned up my source code directory, removed a lot of rarely-used, dated scripts, and grouped the remaining standalone scripts into a central place (`~/dev/scripts`)[^dev]. One thing I learned in this process is that I tend to write a reusable script but rarely actually reuse it (even if it sits on `PATH`), sometimes implementing the same functionality twice or typing a long command line over and over again.

[^dev]: The `~/dev` directory stands for development, and contains all my source code and almost all local builds. The point is by having a `~/dev` directory, I no longer need to have `bin`, `include`, `lib`, and `share` in my `HOME`, thus saving a few slots. Backing up and restoring is also slightly easier.

To remind myself of which scripts are at my fingertip, I decided to use a command table as wallpaper on my secondary display. So I wrote a shitty Python script[^shitty] (depending on XeLaTeX and ImageMagick) to automate the generation of such a wallpaper. It's pretty customizable, and anyone may grab it and do whatever they want to with it (also [available as a gist](https://gist.github.com/zmwangx/b06aa923abf061b33fc9)):

[^shitty]: Yeah, I know it's a shitty script, so don't nitpick on style problems.

```python
#!/usr/bin/env python3

"""Generate command table."""

import argparse
import os
import shlex
import subprocess
import sys
import tempfile

# pylint: disable=wildcard-import,unused-wildcard-import

from zmwangx.colorout import *

DEFAULT_COLUMN_WIDTH = 120
DEFAULT_FOREGROUND_COLOR = "white"
DEFAULT_BACKGROUND_COLOR = "black"
DEFAULT_FONT = "Consolas"
DEFAULT_BORDER = 20
DEFAULT_DENSITY = 300
DEFAULT_SIZE = "1280x800"

HERE = os.path.dirname(os.path.realpath(sys.argv[0]))
XELATEX_PROGRAM = (r"""
\documentclass[varwidth=\maxdimen,border={border}pt]{{standalone}}
\usepackage{{color}}
\pagecolor{{{background}}}
\color{{{foreground}}}
\usepackage{{fontspec}}
\setmonofont{{{font}}}

\begin{{document}}
\begin{{verbatim}}
{table}
\end{{verbatim}}
\end{{document}}
""")

def text_table(**kwargs):
    """Generate the text version of the table."""
    width = kwargs["width"] if "width" in kwargs else DEFAULT_COLUMN_WIDTH
    directory = kwargs["directory"] if "directory" in kwargs else HERE
    command_line = (r"find {directory} -maxdepth 1 -type f -perm -u=x -exec basename {{}} \; "
                    "| column -c {width} | expand".format(
                        directory=shlex.quote(directory), width=width))
    ccommand(command_line)
    return subprocess.check_output(command_line, shell=True).decode("utf-8")

def pdf_table(**kwargs):
    """Generate the PDF version of the table.

    Returns 0 on success or 1 on failure. Generated PDF is "table.pdf"
    in the current working directory.

    """
    border = kwargs["border"] if "border" in kwargs else DEFAULT_BORDER
    foreground = kwargs["foreground"] if "foreground" in kwargs else DEFAULT_FOREGROUND_COLOR
    background = kwargs["background"] if "background" in kwargs else DEFAULT_BACKGROUND_COLOR
    font = kwargs["font"] if "font" in kwargs else DEFAULT_FONT
    program = XELATEX_PROGRAM.format(table=text_table(**kwargs).strip(),
                                     font=font, border=border,
                                     foreground=foreground, background=background)
    with open("table.tex", "w") as texfileobj:
        texfileobj.write(program)
    try:
        ccommand("xelatex table.tex")
        subprocess.check_call(["xelatex", "table.tex"],
                              stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        return 0
    except subprocess.CalledProcessError:
        cerror("xelatex failed on the following program:")
        cerrnewline()
        cerrwrite("default", program)
        return 1

def png_table(**kwargs):
    """Generate the PNG version of the table.

    Returns 0 on success or 1 on failure. Generated PNG is "table.png"
    in the current working directory.

    """
    if pdf_table(**kwargs) == 1:
        return 1
    density = kwargs["density"] if "density" in kwargs else DEFAULT_DENSITY
    size = kwargs["size"] if "size" in kwargs else DEFAULT_SIZE
    background = kwargs["background"] if "background" in kwargs else DEFAULT_BACKGROUND_COLOR
    command_line = ("convert -density {density} table.pdf -resize {size} -size {size} "
                    "xc:{background} +swap -gravity center -composite table.png".format(
                        density=density, size=size, background=background))
    try:
        ccommand(command_line)
        subprocess.check_call(shlex.split(command_line))
        return 0
    except subprocess.CalledProcessError:
        cerror("the following ImageMagick command failed:")
        cerrprint("default", command_line)
        return 1

def main():
    """CLI."""
    description = "Generate a PNG table of all executable commands in a directory."
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument("--width", type=int, default=DEFAULT_COLUMN_WIDTH,
                        help="""line width, default is 120""")
    parser.add_argument("--directory",
                        help="""directory containing executables, default is
                        the directory containing this command""")
    parser.add_argument("--border", type=int, default=DEFAULT_BORDER,
                        help="""default is 20pt""")
    parser.add_argument("--foreground", default=DEFAULT_FOREGROUND_COLOR,
                        help="""foreground color, default is white""")
    parser.add_argument("--background", default=DEFAULT_BACKGROUND_COLOR,
                        help="""background color, default is black""")
    parser.add_argument("--font", default=DEFAULT_FONT,
                        help="""default is Consolas""")
    parser.add_argument("--density", default=DEFAULT_DENSITY,
                        help="""used for the -density argument of convert,
                        default is 300""")
    parser.add_argument("--size", default=DEFAULT_SIZE,
                        help="""size of image, default is 1280x800""")
    args = parser.parse_args()
    kwargs = {k: v for (k, v) in args.__dict__.items() if v is not None}

    fd, tmpfilepath = tempfile.mkstemp(suffix=".png", prefix="table-")
    os.close(fd)
    with tempfile.TemporaryDirectory(prefix="table-") as working_directory:
        os.chdir(working_directory)
        if png_table(**kwargs) == 1:
            cerror("execution failed")
            os.remove(tmpfilepath)
        else:
            os.rename("table.png", tmpfilepath)
            cprogress("saved to:")
            print(tmpfilepath)

if __name__ == "__main__":
    main()
```

By the way, the `zmwangx.colorout` module is [here](https://github.com/zmwangx/pyzmwangx/blob/41b0bffaad9439888d68097a85c7aed594240283/zmwangx/colorout.py), just to ease the printing of progress and errors to tty. You may safely remove all the `ccommand`, `cerr*` and `cprogress` calls.

Here is an example wallpaper reflecting my current `~/dev/scripts`:

![Command table wallpaper for my secondary display (MBP 13'' builtin display).](https://i.imgur.com/mccQu1e.png)
