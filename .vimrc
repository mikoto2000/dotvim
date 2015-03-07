""" Common Custom
lcd ~
syntax on
set tabstop=4
set nrformats=
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
set hlsearch
set incsearch
set number
set hidden
set noswapfile
set backupdir=~/.vim/backup
set foldenable
set foldmethod=marker
set cursorcolumn
set ambiwidth=double

""" include confs
source ~/.vim/neobundle.vimrc

colorscheme desert

if (has('clientserver'))
    source ~/.vim/singleton.vimrc
endif

if (has('lua'))
    source ~/.vim/neocomplete.vimrc
endif

source ~/.vim/quickrun.vimrc

""" restart setting
let g:restart_sessionoptions
            \ = 'blank,buffers,curdir,folds,help,localoptions,tabpages'

""" change current directory
augroup grlcd
    autocmd!
    autocmd BufEnter * lcd %:p:h
augroup END

source ~/.vim/ozjava.vim

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

""" comment toggle
vnoremap <Space>cc :normal i//<Return>
vnoremap <Space>uc :s/^\/\///<Return>

""" auto comment off
augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END

""" 開いているファイルが格納されているディレクトリをカレントディレクトリとする
command! CDPWD :exec ":lcd " . expand("%:p:h")


"""""" 今日の日付
let $TODAY = strftime('%Y%m%d')
inoremap <silent> <Space>td <C-R>=strftime('%Y%m%d')<CR>

""" 作業ファイル作成・編集
command! Tmp :e ~/worklog/tmp/$TODAY.txt | :set filetype=page

""" {{{ rc 系を開く
command! Vimrc :e ~/.vimrc
command! Gvimrc :e ~/.gvimrc
command! Bundle :e ~/.vim/neobundle.vimrc
""" }}} rc 系を開く

""" UniteResume
noremap <Space>u <Esc>:UniteResume<Enter>

""" {{{ about buffer
noremap <Space>l <Esc>:Unite buffer<Enter>
noremap <Space>uf <Esc>:Unite file<Enter>
noremap <Space>b <Esc>:Unite bookmark<Enter>

""" 直前のバッファに戻る
noremap <Space>bb <Esc>:b#<Enter>

""" cNext, cPrev
noremap <Space>cn <Esc>:cn<Enter>
noremap <Space>cp <Esc>:cp<Enter>
""" }}} about buffer about buffer

""" VimFiler
noremap <Space>f <Esc>:VimFiler<Enter>

""" VimShell
noremap <Space>s <Esc>:VimShell<Enter>

""" split
noremap <Space>sp <Esc>:split<Enter>
noremap <Space>vs <Esc>:vsplit<Enter>

""" {{{ diff
noremap <Space>ds <Esc>:windo diffthis<Enter>
noremap <Space>dd <Esc>:windo diffoff<Enter>
noremap <Space>du <Esc>:windo diffupdate<Enter>
"" "}}} diff

call unite#custom_default_action("vimshell/history", "insert")
call unite#custom_default_action("vimshell/external_history", "insert")

""" utf8 で再読み込み
noremap <Space>cu <Esc>:e ++enc=utf8<Enter>

""" {{{ encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformat=unix
""" }}} encoding

call unite#custom_default_action('source/bookmark/directory' , 'vimfiler')

""" {{{ infomation lines
""" statusline
set laststatus=2
set statusline=%<%f%h%m%r%y%=[%{&fenc!=''?&fenc:&enc}][%{&ff}][%l,%c%V]\ [%P]

""" tabline
source ~/.vim/tabconf.vimrc
""" }}} infomation lines

""" {{{ for markdown
""" disable underbar highlight
autocmd! FileType markdown hi! def link markdownItalic NONE

""" re-open, set filetype markdown
noremap <Space>fm <Esc>:set filetype=markdown<Enter>

""" }}} for markdown

""" {{{ highlight white spaces
set list
set listchars=tab:>-,eol:$,trail:-

function! SpaceHilight()
    syntax match Space "^\s\+" display containedin=ALL
    highlight Space ctermbg=DarkGray guibg=gray15
endf

if has("syntax")
    syntax on
    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call SpaceHilight()
    augroup END
endif
""" }}} highlight white spaces

""" {{{ for golang
filetype off
filetype plugin off
set rtp+=~/develop/go/misc/vim
set rtp+=~/develop/gopath/src/github.com/nsf/gocode/vim
set rtp+=~/develop/gopath/src/github.com/golang/lint/misc/vim/
"autocmd BufWritePre *.go execute 'Fmt' | cwindow
"autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow
au FileType go setlocal sw=4 ts=4 sts=4 noet
au FileType go setlocal makeprg=go\ build errorformat=%f:%l:\ %m
filetype plugin on
""" }}} for golang

""" {{{ for sonicktemplate-vim
let g:sonictemplate_vim_template_dir = '~/.vim/template'
""" }}} for sonicktemplate-vim

""" PATH
let $PATH = $PATH . ':~/develop/node-v0.8.25-linux-x64/bin:~/develop/adt-bundle-linux-x86_64-201400321/eclipse/'

:au Syntax page   source $VIMRUNTIME/syntax/markdown.vim

""" {{{ for QML
""" QML 用にファイルタイプを設定
augroup QML
    autocmd!
    autocmd BufNewFile,BufRead * setfiletype qml
augroup END

""" QML 用の QuickRun 設定
let g:quickrun_config['qml/qmlscene'] = {
\   'command' : 'qmlscene'
\   ,'exec'    : '%c %s:p'
\   ,'runner'  : 'vimproc'
\   ,'outputter'  : 'null'
\ }
let g:quickrun_config['qml'] = g:quickrun_config['qml/qmlscene']
""" }}} for QML

"""" {{{ for iPad
"inoremap b/ \
"""" }}} for iPad
