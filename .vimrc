""" MyCustom
lcd ~
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
set noswapfile
set backupdir=~/.vim/backup

""" include confs
source ~/.vim/neobundle.vimrc
source ~/.vim/singleton.vimrc
source ~/.vim/neocomplcache.vimrc
source ~/.vim/quickrun.vimrc

""" restart setting
let g:restart_sessionoptions
    \ = 'blank,buffers,curdir,folds,help,localoptions,tabpages'

""" change current directory
augroup grlcd
   autocmd!
   autocmd BufEnter * lcd %:p:h
augroup END

""" <C-@> 誤爆防止。ついでに <C-[> として使ってしまえ
inoremap <C-@> <ESC>
noremap <C-@> :nohlsearch<Enter>

""" <ESC> 連打で検索ハイライト削除
nnoremap <Esc><Esc> :nohlsearch<Return>

""" カーソル位置記憶
au BufReadPost * if line("'\'") > 1 && line("'\'") <= line("$") | exe "normal! g'\"" | endif

""" undo 設定
if has('persistent_undo')
	set undodir=~/.vim/undo
	set undofile
endif

""" clipboard
set clipboard=unnamed,autoselect


""" 開いているファイルが格納されているディレクトリをカレントディレクトリとする
command! CDPWD :exec ":lcd " . expand("%:p:h")


"""""" 今日の日付
let $TODAY = strftime('%Y%m%d')
inoremap <silent> <Space>td <C-R>=strftime('%Y%m%d')<CR>

""" 作業ファイル作成・編集
command! Tmp :e ~/worklog/tmp/$TODAY.txt

""" rc 系を開く
command! Vimrc :e ~/.vimrc
command! Gvimrc :e ~/.gvimrc

""" UniteResume
noremap <Space>u <Esc>:UniteResume<Enter>

""" about buffer
noremap <Space>l <Esc>:Unite buffer<Enter>

noremap <Space>uf <Esc>:Unite file<Enter>

noremap <Space>b <Esc>:Unite bookmark<Enter>

""" 直前のバッファに戻る
noremap <Space>bb <Esc>:b#<Enter>

""" cNext, cPrev
noremap <Space>cn <Esc>:cn<Enter>
noremap <Space>cp <Esc>:cp<Enter>

""" VimFiler
noremap <Space>f <Esc>:VimFiler<Enter>

""" VimShell
noremap <Space>s <Esc>:VimShell<Enter>

""" split
noremap <Space>sp <Esc>:split<Enter>
noremap <Space>vs <Esc>:vsplit<Enter>

""" diff
noremap <Space>ds <Esc>:windo diffthis<Enter>
noremap <Space>dd <Esc>:windo diffoff<Enter>
noremap <Space>du <Esc>:windo diffupdate<Enter>

call unite#custom_default_action("vimshell/history", "insert")
call unite#custom_default_action("vimshell/external_history", "insert")

""" utf8 で再読み込み
noremap <Space>cu <Esc>:e ++enc=utf8<Enter>

""" encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformat=unix

call unite#custom_default_action('source/bookmark/directory' , 'vimfiler')

""" statusline
set statusline=%<%f%h%m%r%y%=[%{&fenc!=''?&fenc:&enc}][%{&ff}][%l,%c%V]\ [%P]

""" tabline
source ~/.vim/tabconf.vimrc

""" PATH
let $PATH = $PATH . ':~/develop/node-v0.8.25-linux-x64/bin:~/develop/adt-bundle-linux-x86_64-20130522/eclipse/'
