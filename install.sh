#!/bin/sh

BASE=`dirname $0`
cd $BASE

ln -s ~/.nvim/vimrc ~/.nvimrc

vim +GoInstallBinaries! +qa

# should've installed `python-dev`

./update.sh
