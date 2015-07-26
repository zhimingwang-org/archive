The icon and favicon files are generated via the following commands: ::

  cd source/img
  xelatex icon.tex
  xelatex icon-square.tex
  for size in 100 150 200 300 400 2048; do convert icon.pdf -density 400 -resize $sizex$size icon-$size.png; done
  for size in 16 32 48 144; do convert icon.pdf -density 400 -resize $sizex$size favicon-$size.png; done
  convert icon-square.pdf -density 400 -resize 152x152 apple-touch-icon-152.png
  optipng favicon-*.png icon-*.png apple-touch-icon-152.png
  convert favicon-16.png favicon-32.png favicon-48.png ../favicon.ico
  rm favicon-16.png favicon-32.png favicon-48.png

Credit to `audreyr/favicon-cheat-sheet <https://github.com/audreyr/favicon-cheat-sheet>`_ for favicon handling tips.

The feed icon isn't so easy to create with TikZ (I don't know the necessary parameters), so I downloaed one (256x256) from `IconFinder <https://www.iconfinder.com/icons/49861/feed_rss_icon>`_. The original PNG can be found `here <http://i.imgur.com/4XE3iL3.png>`_. Then I processed the PNG with ``optipng``, the result of which is ``feed-256.png``. The smaller ``feed-14.png`` is generated through::

  for size in 16 32; do convert feed-256.png -resize $sizex$size feed-$size.png; done
  optipng feed-*.png

Next, the horizontal mirror ``rss-14.png`` is generated through::

  for size in 16 32; do convert feed-$size.png -flop rss-$size.png; done
  optipng rss-*.png

The CreativeCommons icon ``cc.svg`` is pulled from `the official downloads page <https://creativecommons.org/about/downloads>`_ and converted to 16x16 PNG through::

  for size in 16 32; do convert cc.svg -resize $sizex$size cc-$size.png; done
  optipng cc-*.png
