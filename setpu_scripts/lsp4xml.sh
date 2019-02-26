#!/bin/bash
#
# lsp4xml.sh
#
# vim-lsp に使用する lsp4xml をダウンロードして配置する
#
# 配置場所: ~/.vim/lsp/lsp4xml/
#
# 必要なコマンド:
#     - wget
#     - tar
#     - dirname

THIS_DIR=$(cd $(dirname $BASH_SOURCE); pwd)
SERVER_NAME=lsp4xml

DL_BASE_PATH=https://github.com/angelozerr/lsp4xml/releases/download/0.3.0
DL_FILE_NAME=org.eclipse.lsp4xml-0.3.0-uber.jar

cd ${THIS_DIR}/../.vim

if [ ! -e lsp ]; then
    mkdir lsp
fi

if [ ! -e lsp/${SERVER_NAME} ]; then
    mkdir lsp/${SERVER_NAME}
fi

cd lsp/${SERVER_NAME}

# lsp4xml をダウンロード
if [ ! -e ${DL_FILE_NAME} ]; then
    wget ${DL_BASE_PATH}/${DL_FILE_NAME}
fi

cd ${THIS_DIR}

