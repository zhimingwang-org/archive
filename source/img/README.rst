The icon and favicon files are generated via the following commands: ::

  cd source/img
  xelatex icon.tex
  xelatex icon-square.tex
  for size in 16 32 48 144; do convert icon.pdf -density 400 -resize $sizex$size favicon-$size.png; done
  convert icon-square.pdf -density 400 -resize 152x152 apple-touch-icon-152.png
  optipng favicon-*.png apple-touch-icon-152.png
  convert favicon-16.png favicon-32.png favicon-48.png ../favicon.ico
  rm favicon-16.png favicon-32.png favicon-48.png

Credit to `audreyr/favicon-cheat-sheet <https://github.com/audreyr/favicon-cheat-sheet>`_ for favicon handling tips.
