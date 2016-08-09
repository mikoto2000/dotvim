""" Common Custom
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
set nonumber
set hidden
set noswapfile
set backupdir=~/.vim/backup
set foldenable
set foldmethod=marker
set cursorcolumn
set ambiwidth=double

" 自動折り返しを無効化
set textwidth=0

" 80 文字目をハイライト
set colorcolumn=80

colorscheme desert

""" restart setting
let g:restart_sessionoptions
            \ = 'blank,buffers,curdir,folds,help,localoptions,tabpages'

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

""" auto comment off
augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END

""" 作業ファイル作成・編集
"""""" 今日の日付
let $TODAY = strftime('%Y%m%d')
inoremap <silent> <Space>td <C-R>=strftime('%Y%m%d')<CR>
command! Tmp :e ~/worklog/tmp/$TODAY.txt | :set filetype=markdown

""" {{{ rc 系を開く
command! Vimrc :e ~/.vimrc
command! Gvimrc :e ~/.gvimrc
""" }}} rc 系を開く

""" {{{ about buffer

""" 直前のバッファに戻る
noremap <Space>bb <Esc>:b#<Enter>

""" バッファ一覧表示
noremap <Space>l <Esc>:buffers<Enter>

""" バッファ移動
noremap <Space>b <Esc>:buffer 

""" cNext, cPrev
noremap <Space>cn <Esc>:cn<Enter>
noremap <Space>cp <Esc>:cp<Enter>
""" }}} about buffer about buffer

""" split
noremap <Space>sp <Esc>:split<Enter>
noremap <Space>vs <Esc>:vsplit<Enter>

""" {{{ encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformat=unix
""" }}} encoding

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

""" {{{ for ctags
" <C-]>でタグジャンプ時にタグが複数あったらリスト表示。カーソルがウィンドウの中心行になるようにジャンプ
nnoremap <C-]> g<C-]>zz
" タグファイルはカレントファイルのパスを基準に上向き検索
set tags=./tags;
" (l以外で始まる)QuickFixコマンドの実行が終わったらQuickFixウィンドウを開く
autocmd QuickfixCmdPost [^l]* copen
""" }}} for ctags

""" {{{ for sonicktemplate-vim
let g:sonictemplate_vim_template_dir = '~/.vim/template'
""" }}} for sonicktemplate-vim

""" {{{ for neosnippet

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

let g:neosnippet#disable_runtime_snippets = {
        \   '_' : 1,
        \ }

""" スニペットのディレクトリ設定
let g:neosnippet#snippets_directory = $HOME . '/.vim/snippets'

"" SuperTab like snippets behavior.
imap <expr><C-l> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<C-l>"
smap <expr><C-l> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<C-l>"

""" }}} for neosnippet

""" {{{ neocomplete
" neocomplete の自動有効化
let g:neocomplete#enable_at_startup = 1

" 大文字小文字を区別する
let g:neocomplete#smart_case = 1

" キャメルケース補完を有効にする
let g:neocomplete#enable_camelcase_completion = 1

" アンダーバー補完を有効にする
let g:neocomplete#enable_underbar_completion = 1
"
"" シンタックスファイルの補完対象キーワードとする最小の長さ
let g:neocomplete#min_syntax_length = 3
let g:neocomplete#min_keyword_length = 3
""" }}} neocomplete

""" restart setting
let g:restart_sessionoptions
    \ = 'blank,buffers,curdir,folds,help,localoptions,tabpages'

if (has('clientserver'))
    packadd vim-singleton
    call singleton#enable()
endif

""" {{{ for Netrw
nnoremap <Space>f :Explore<Return>
augroup netrw
    autocmd!
    autocmd FileType netrw map <buffer> l <Return>
    autocmd FileType netrw map <buffer> h -
augroup END
""" }}} for Netrw

""" {{{ for golang
augroup golang
    autocmd!
    " .go 編集時にタブをスペースに置き換えないようにする
    autocmd BufEnter *.go setlocal noexpandtab
augroup END
""" }}} for golang

""" {{{ for fold
noremap fo :forldopen<Return>
noremap fc :forldclose<Return>
""" }}}

filetype plugin indent off

packadd! vim-go-extra

filetype plugin indent on
