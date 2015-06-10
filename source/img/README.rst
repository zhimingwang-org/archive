The icon and favicon files are generated via the following commands: ::

  cd source/img
  xelatex icon.tex
  for size in 100 400 2048; do convert icon.pdf -density 400 -resize $sizex$size icon-$size.png; done
  for size in 16 32 48 144 152; do convert icon.pdf -density 400 -resize $sizex$size favicon-$size.png; done
  optipng favicon-*.png icon-*.png
  convert favicon-16.png favicon-32.png favicon-48.png ../favicon.ico
  rm favicon-16.png favicon-32.png favicon-48.png

Credit to `audreyr/favicon-cheat-sheet <https://github.com/audreyr/favicon-cheat-sheet>`_ for favicon handling tips.

The feed icon isn't so easy to create with TikZ (I don't know the necessary parameters), so I downloaed one (256x256) from `IconFinder <https://www.iconfinder.com/icons/49861/feed_rss_icon>`_. The original PNG can be found `here <http://i.imgur.com/4XE3iL3.png>`_. Then I processed the PNG with ``optipng``, the result of which is ``feed-256.png``. The smaller ``feed-14.png`` is generated through::

  convert feed-256.png -resize 14x14 feed-14.png
  optipng feed-14.png

Next, the horizontal mirror ``rss-14.png`` is generated through::

  convert feed-14.png -flop rss-14.png
  optipng rss-14.png

The CreativeCommons icon ``cc.svg`` is pulled from `the official downloads page <https://creativecommons.org/about/downloads>`_ and converted to 16x16 PNG through::

  convert cc.svg -resize 16x16 cc-16.png
  optipng cc-16.png
