The icon and favicon files are generated via the following commands: ::

  cd source/img
  xelatex icon.tex
  for size in 100 400; do convert icon.pdf -quality 400 -resize ${size}x${size} icon-${size}.png; done
  for size in 16 32 48 144 152; do convert icon.pdf -density 400 -resize ${size}x${size} favicon-${size}.png; done
  optipng favicon-16.png favicon-32.png favicon-48.png favicon-144.png favicon-152.png icon-100.png icon-400.png
  convert favicon-16.png favicon-32.png favicon-48.png ../favicon.ico
  rm favicon-16.png favicon-32.png favicon-48.png

Credit to `audreyr/favicon-cheat-sheet <https://github.com/audreyr/favicon-cheat-sheet>`_ for favicon handling tips.

The feed icon isn't so easy to create with TikZ (I don't know the necessary parameters), so I downloaed one (256x256) from `IconFinder <https://www.iconfinder.com/icons/49861/feed_rss_icon>`_. The original PNG can be found `here <http://i.imgur.com/4XE3iL3.png>`_. Then I processed the PNG with ``optipng``, the result of which is ``feed-256.png``. The smaller ``feed-14.png`` is generated through::

  convert feed-256.png -resize 14x14 feed-14.png
  optipng feed-14.png
