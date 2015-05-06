The icon and favicon files are generated via the following commands: ::

  cd source/img
  xelatex icon.tex
  for size in 100 400; do convert icon.pdf -quality 400 -resize ${size}x${size} icon-${size}.png; done
  for size in 16 32 48 144 152; do convert icon.pdf -density 400 -resize ${size}x${size} favicon-${size}.png; done
  optipng favicon-16.png favicon-32.png favicon-48.png favicon-144.png favicon-152.png icon-100.png icon-400.png
  convert favicon-16.png favicon-32.png favicon-48.png ../favicon.ico
  rm favicon-16.png favicon-32.png favicon-48.png

Credit to `audreyr/favicon-cheat-sheet <https://github.com/audreyr/favicon-cheat-sheet>`_ for favicon handling tips.
