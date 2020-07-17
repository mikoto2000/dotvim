#!/bin/bash

THIS_DIR=$(cd ${0%/*}&&pwd)

if [ ! -e ~/.vim ]; then
    ln -s ${THIS_DIR}/../.vim ~/.vim
fi

if [ ! -e ~/.vimrc ]; then
    ln -s ${THIS_DIR}/../.vimrc ~/.vimrc
fi

if [ ! -e ~/.gvimrc ]; then
    ln -s ${THIS_DIR}/../.gvimrc ~/.gvimrc
fi

