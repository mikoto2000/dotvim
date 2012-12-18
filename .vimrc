""" MyCustom
syntax on
set tabstop=4
set cindent
set smartindent
set autoindent
set expandtab
set showmatch
set shiftwidth=4
set softtabstop=4
set nocompatible
set pastetoggle=<f11>
set ignorecase
set incsearch
set number
set hidden

""" include confs
source ~/.vim/neocomplcache.conf
source ~/.vim/neobundle.conf
source ~/.vim/quickrun.conf

""" change current directory
augroup grlcd
   autocmd!
   autocmd BufEnter * lcd %:p:h
augroup END

""" 開いているファイルが格納されているディレクトリをカレントディレクトリとする
:command! CDPWD :exec ":lcd " . expand("%:p:h")


"""""" 今日の日付
:let $TODAY = strftime('%Y%m%d')
:imap <silent> <Space>td <C-R>=strftime('%Y%m%d')<CR>

""" 作業ファイル作成・編集
:map <Space>wwl <Esc>:w ~/worklog/<C-R>=strftime('%Y%m%d')<CR>.txt<Enter>
:map <Space>ewl <Esc>:e ~/worklog/<C-R>=strftime('%Y%m%d')<CR>.txt<Enter>

""" UniteResume
map <Space>u <Esc>:UniteResume<Enter>

""" about buffer
map <Space>l <Esc>:Unite buffer<Enter>

map <Space>uf <Esc>:Unite file<Enter>

map <Space>b <Esc>:Unite bookmark<Enter>

""" 直前のバッファに戻る
map <Space>bb <Esc>:b#<Enter>

""" cNext, cPrev
map <Space>cn <Esc>:cn<Enter>
map <Space>cp <Esc>:cp<Enter>

""" VimFiler
map <Space>vf <Esc>:VimFiler<Enter>
map <Space>f <Esc>:VimFiler<Enter>

""" VimShell
map <Space>vs <Esc>:VimShell<Enter>
map <Space>s <Esc>:VimShell<Enter>

call unite#custom_default_action("vimshell/history", "insert")
call unite#custom_default_action("vimshell/external_history", "insert")

""" utf8 で再読み込み
map <Space>cu <Esc>:e ++enc=utf8<Enter>

""" encoding
:set encoding=utf-8
:set fileencoding=utf-8
:set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
:set fileformat=unix

call unite#custom_default_action('source/bookmark/directory' , 'vimfiler')

""" statusline
:set statusline=%<%f%h%m%r%=[%{&fenc!=''?&fenc:&enc}][%{&ff}][%l,%c%V]\ [%P]
