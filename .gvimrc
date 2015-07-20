" Windows 版 gvim のメニュー文字化け対策
if has('win32') || has('win64')
    source $VIMRUNTIME/delmenu.vim
    set langmenu=ja_jp.utf-8
    source $VIMRUNTIME/menu.vim
endif

""" メニュー設定
set guioptions=

colorscheme desert

set visualbell
set vb t_vb=

""" 行列の数
set lines=50
set columns=120

""" フォント設定
set guifont=Ricty\ 17

""" {{{ transset
""" from [Linux の gVim の透過度を設定する](https://gist.github.com/anekos/6241052)
function! s:Transset(opacity)
    call system('transset --id ' . v:windowid . ' ' . a:opacity)
endfunction
command! -nargs=1 Transset call <SID>Transset(<q-args>)
""" GUI 起動時に透過コマンドを実行する
augroup myTrans
    autocmd!
    autocmd GUIEnter * Transset 0.85
augroup END
""" }}} transset

