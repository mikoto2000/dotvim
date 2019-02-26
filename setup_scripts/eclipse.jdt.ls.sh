#!/bin/bash
#
# eclipse.jdt.ls.sh
#
# vim-lsp に使用する eclipse.jdt.ls をダウンロードして配置する
#
# 配置場所: ~/.vim/lsp/eclipse.jdt.ls/
#
# 必要なコマンド:
#     - wget
#     - tar
#     - dirname

THIS_DIR=$(cd $(dirname $BASH_SOURCE); pwd)

cd ${THIS_DIR}/../.vim

if [ ! -e lsp ]; then
    mkdir lsp
fi

if [ ! -e lsp/eclipse.jdt.ls ]; then
    mkdir lsp/eclipse.jdt.ls
fi

cd lsp/eclipse.jdt.ls

# eclipse.jdt.ls をダウンロード
JDT_LS_BASE_PATH=https://download.eclipse.org/jdtls/milestones/0.32.0
JDT_LS_TAR_GZ=jdt-language-server-0.32.0-201901231649.tar.gz
if [ ! -e ${JDT_LS_TAR_GZ} ]; then
    wget ${JDT_LS_BASE_PATH}/${JDT_LS_TAR_GZ}
fi

# eclipse.jdt.ls を展開(plugin フォルダの有無で展開の要否判定)
if [ ! -e plugins ]; then
    tar xf ${JDT_LS_TAR_GZ}
fi

cd ${THIS_DIR}

