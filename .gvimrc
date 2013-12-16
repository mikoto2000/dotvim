" Windows 版 gvim のメニュー文字化け対策
if has('win32') || has('win64')
    source $VIMRUNTIME/delmenu.vim
    set langmenu=ja_jp.utf-8
    source $VIMRUNTIME/menu.vim
endif

""" メニュー設定
set guioptions=m

set visualbell
set vb t_vb=

""" 行列の数
set lines=50
set columns=120
