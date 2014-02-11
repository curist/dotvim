#!/bin/sh

git clone https://github.com/curist/dotvim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

go get -u github.com/jstemmer/gotags
go get -u github.com/nsf/gocode

# should've installed `python-dev`

./update.sh
