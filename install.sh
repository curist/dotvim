#!/bin/sh

BASE=`dirname $0`
cd $BASE

ln -s ~/.vim/vimrc ~/.vimrc
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim +GoInstallBinaries! +qa

# should've installed `python-dev`

./update.sh
