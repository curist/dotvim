#!/bin/sh

git clone https://github.com/curist/dotvim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim +GoInstallBinaries! +qa

# should've installed `python-dev`

./update.sh
