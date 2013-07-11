#!/bin/bash
sudo apt-get install libgtk2.0-dev libpango1.0-dev libcairo2-dev libglib2.0-dev haskell-platform
export PATH=~/.cabal/bin:$PATH
cabal update
cabal install gtk2hs-buildtools
cabal install glib
cabal install gtk
