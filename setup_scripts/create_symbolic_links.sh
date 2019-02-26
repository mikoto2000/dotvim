#!/bin/bash

if [ ! -e ~/.vim ]; then
    ln -s ~/project/dotvim/.vim ~/.vim
fi

if [ ! -e ~/.vimrc ]; then
    ln -s ~/project/dotvim/.vimrc ~/.vimrc
fi

if [ ! -e ~/.gvimrc ]; then
    ln -s ~/project/dotvim/.gvimrc ~/.gvimrc
fi

