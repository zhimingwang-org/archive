[![Build Status](https://travis-ci.org/zmwangx/zmwangx.github.io.svg?branch=source)](https://travis-ci.org/zmwangx/zmwangx.github.io)

This blog can be built with the `pyblog` script. The `pyblog` script currently provides the following actions:

* `new_post` (aliases: `n`, `new`);
* `touch` (aliases: `t`, `tou`);
* `generate` (aliases: `g`, `gen`);
* `regenerate` (aliases: `r`, `regen`);
* `preview` (aliases: `p`, `pre`).
* `deploy` (aliases: `d`, `dep`);
* `gen_deploy` (aliases: `gd`, `gendep`);
* `edit` (aliases: `e`, `ed`).

Run `pyblog --help` for more information, and `pyblog <action> --help` for what the action does and how to perform the action.

Note that `pyblog` is incompatible with Python 2.x, and in fact only tested on Python 3.4+.

The theme of this blog is largely based on that of [mort.ninja](http://mort.ninja) by [Mort Yao](https://github.com/soimort). See [this post](https://zmwangx.github.io/blog/2015-05-05-new-blog-new-start.html) for more details.

Self-hosted Google Web Fonts are downloaded from [google-webfonts-helper](https://google-webfonts-helper.herokuapp.com/fonts), courtesy of [Mario Ranftl](http://ranf.tl/2014/12/23/self-hosting-google-web-fonts/).

## Markdown features of `pyblog`

`pyblog` uses Pandoc for Markdown processing. The HTML template is
located at [`source/template.html`](source/template.html).

Beyond Pandoc's standard Markdown to HTML conversion, `pyblog`
postprocesses Pandoc-generated HTML to add a few Markdown extensions and
blogging-friendly HTML transforms.

### Markdown extensions

#### Image size

Allows specifying image size in a Markdown image construct `![]()`. The
syntax is:

    ![|width(xheight)?| alt](src)

where `width` and `height` are positive integers (`xheight` is
optional), and `alt` is the regular `alt` string (either plain or with
some Markdown formatting). The `alt` string, as usual, is optional.

Examples:

    ![|1920x1080| Hello, world!](http://example.com/hello.png)
    ![|1920| *Hey!*](http://example.com/hey.png)
    ![|1280x800|](http://example.com/noalt.png)

See `process_image_sizes` in [`pyblog`](pyblog).

### Other HTML transforms

#### Link images to originals

`img` tags are automatically converted to clickable links to their
originals (with `target="_blank"` so the original is opened in a new
tab).

See `link_img_tags` in [`pyblog`](pyblog).

#### Footnote backlinks

Pandoc Markdown has footnote support, but unfortunately doesn't support
backlinks. This transform inserts a backlink to the end of each
footnote so that readers won't get lost after finish reading a footnote.
