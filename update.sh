#!/bin/sh

vim +BundleInstall! +qa

cd ~/.vim/bundle/YouCompleteMe/
./install.sh --clang-completer

cd ~/.vim/bundle/ctrlp-cmatcher/
./install_linux.sh
