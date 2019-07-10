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
set breakindent
set cmdheight=2
set nofixeol

" Leader
let mapleader = ' '

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" 自動折り返しを無効化
set textwidth=0

" 80 文字目をハイライト
set colorcolumn=80

if has('termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
    colorscheme forest-night
else
    colorscheme desert
endif

""" for Windows {{{
if has("win32")
    set runtimepath+=$HOME/.vim,$HOME/.vim/after
    set packpath+=$HOME/.vim,$HOME/.vim/after

    command! Shell !start C:\msys64\msys2_shell.cmd -here
endif
""" }}} for Windows

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
inoremap <silent> <Leader>td <C-R>=strftime('%Y%m%d')<CR>
command! Tmp :e ~/worklog/$TODAY.md

""" {{{ rc 系を開く
command! Vimrc :e ~/.vimrc
command! Gvimrc :e ~/.gvimrc
""" }}} rc 系を開く

""" {{{ about buffer

""" 直前のバッファに戻る
noremap <Leader>bb :b#<Enter>

""" バッファ一覧表示
noremap <Leader>l <Esc>:call buffer_selector#OpenBufferSelector()<Enter>

""" バッファ移動
noremap <Leader>b <Esc>:buffer 

""" cNext, cPrev
noremap <Leader>cn <Esc>:cn<Enter>
noremap <Leader>cp <Esc>:cp<Enter>

noremap <Leader>f <Esc>:call file_selector#OpenFileSelector()<Enter>
let g:file_selector_exclude_pattern = '\(^bin\|^build$\|^build[/\\]\|^gradle\|^config\)'

noremap <Leader>o <Esc>:call outline#OpenOutlineBuffer()<Enter>

""" }}} about buffer about buffer

""" split
noremap <Leader>sp :split<Enter>
noremap <Leader>vs :vsplit<Enter>

""" {{{ encoding
set encoding=utf-8
set fileencoding=utf-8
if has("kaoriya")
    set fileencodings=guess,utf-8
else
    set fileencodings=utf-8
endif
set fileencodings+=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformats=unix,dos,mac
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
set listchars=tab:>-,trail:-,space:˽
set showbreak=\\\ 
""" }}} highlight white spaces

""" {{{ for ctags
" <C-]>でタグジャンプ時にタグが複数あったらリスト表示。カーソルがウィンドウの中心行になるようにジャンプ
nnoremap <C-]> g<C-]>zz
" タグファイルはカレントファイルのパスを基準に上向き検索
set tags=./tags;
" (l以外で始まる)QuickFixコマンドの実行が終わったらQuickFixウィンドウを開く
autocmd QuickfixCmdPost [^l]* copen
""" }}} for ctags

""" {{{ for terminal
" terminal でも <C-r> をインサートモードと同じ挙動にする
tnoremap <C-r> <C-w>"

command! Powershell execute "terminal ++close powershell"

" msys64 の bash で日本語入力できるように、 `$LANG` を `ja_JP.UTF-8` にする
let $LANG = "ja_JP.UTF-8"
command! Bash execute "terminal ++close c:/msys64/usr/bin/env.exe CHERE_INVOKING=1 /bin/bash.exe --login"
""" }}} for terminal

""" {{{ for sonicktemplate-vim
let g:sonictemplate_vim_template_dir = '~/.vim/template'
""" }}} for sonicktemplate-vim

""" restart setting
let g:restart_sessionoptions
    \ = 'blank,buffers,curdir,folds,help,localoptions,tabpages'

""" {{{ for Netrw
let g:netrw_banner = 0
"nnoremap <Leader>e :Explore<Return>
augroup netrw
    autocmd!
    autocmd FileType netrw map <buffer> l <Return>
    autocmd FileType netrw map <buffer> h -
    autocmd FileType netrw map <buffer> <Space> mf
    autocmd FileType netrw map <buffer> q :bd<Return>
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
nnoremap <Leader>fo :foldopen<Return>
nnoremap <Leader>fc :foldclose<Return>
""" }}}

""" {{{ for grep
nnoremap <Leader><Leader> viwy:grep <C-r>" ./<Left><Left><Left>
nnoremap <Leader>s viwy:grep <C-r>" ./<Left><Left><Left>
set grepprg=grep\ -rnIH\ --exclude-dir=.git\ --exclude-dir=.hg\ --exclude-dir=.svn\ --exclude=tags
""" }}} for grep

filetype plugin indent off

packadd! vim-go-extra
packadd! buffer_selector.vim
packadd! file_selector.vim
packadd! ctags_selector.vim
packadd! c_previewer.vim
packadd! hex_edit.vim
packadd! outline.vim

filetype plugin indent on

""" {{{ for blog
augroup m2h
    autocmd!
    autocmd FileType markdown command! M2h call m2h#M2H()
    autocmd FileType markdown command! M2hsc call m2h#M2H_SC()
augroup END
""" }}} for blog

""" {{{ radix conversion
command! Num2b execute "normal viwc<C-R>=printf(\"0b%b\", <C-R>\")<Return><Esc>"
command! Num2d execute "normal viwc<C-R>=printf(\"%d\", <C-R>\")<Return><Esc>"
command! Num2x execute "normal viwc<C-R>=printf(\"0x%04X\", <C-R>\")<Return><Esc>"
command! Num2Mask0 execute "normal viwc<C-R>=printf(\"0x%04X\", printf(\"%.f\", pow(2, <C-R>\")))<Return><Esc>"
command! Num2Mask1 execute "normal viwc<C-R>=printf(\"0x%04X\", printf(\"%.f\", pow(2, <C-R>\"-1)))<Return><Esc>"
""" }}} radix conversion

" 選択範囲の式を評価して置き換える(改行未対応)
vnoremap <Leader>= c<C-R>=eval("<C-R>"")<Return><Esc>

""" for hex edit
command! StartHexEdit call hex_edit#StartHexEdit()
command! SaveHexEdit call hex_edit#SaveHexEdit()
command! EndHexEdit call hex_edit#EndHexEdit()

" :w でセーブできるようにマッピング追加
augroup hex_edit
    autocmd!
    autocmd FileType xxd nnoremap <buffer> :w :call hex_edit#SaveHexEdit()<Return>
augroup END

""" for c_previewer
let g:c_previewer_toolchain = 'aarch64-linux-gnu-'
let g:c_previewer_cflags = ' -I c:/Users/mikoto/project/raspberrypi_bare_metal/util/include '

command! Assenble call c_previewer#OpenAssembleBuffer()
command! Headers call c_previewer#OpenHeadersBuffer()
command! Symbols call c_previewer#OpenSymbolsBuffer()
command! Hex call c_previewer#OpenHexBuffer()
command! Cpp call c_previewer#OpenPreprocessBuffer()

""" for complete
" プレビューウィンドウを開かないようにする
" 補完呼び出し時に自動で先頭のアイテムが選択状態になるのを防ぐ
set completeopt=menuone,noselect

" <C-Space> でオムニ補完を行えるようにマッピング
" オムニ補完開始直後に、インクリメンタル絞り込みができるようにマッピング
inoremap <C-Space> <C-X><C-O><C-P>

""" for java development
command! Javad call StartJavaDevelopment()
function! StartJavaDevelopment()
    packadd async.vim
    packadd vim-lsp

    " let g:lsp_log_verbose = 1
    " let g:lsp_log_file = expand('~/vim-lsp.log')

    " for asyncomplete.vim log
    " let g:asyncomplete_log_file = expand('~/asyncomplete.log')

    " bat ファイルを作ってそれを叩くようにしたら、 'invalid content-length'
    " というエラーになってしまうのでここに全部オプションを書くようにしている。
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'eclipse.jdt.ls',
        \ 'cmd': {server_info->[
        \     'java',
        \     '--add-modules=ALL-SYSTEM',
        \     '--add-opens',
        \     'java.base/java.util=ALL-UNNAMED',
        \     '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        \     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        \     '-Dosgi.bundles.defaultStartLevel=4',
        \     '-Declipse.product=org.eclipse.jdt.ls.core.product',
        \     '-Dlog.level=ALL',
        \     '-noverify',
        \     '-Dfile.encoding=UTF-8',
        \     '-Xmx1G',
        \     '-jar',
        \     expand('~/.vim/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.300.v20190213-1655.jar'),
        \     '-configuration',
        \     expand('~/.vim/lsp/eclipse.jdt.ls/config_win'),
        \     '-data',
        \     expand('~/.vim/lsp/eclipse.jdt.ls/workspace'),
        \ ]},
        \ 'whitelist': ['java'],
        \ })

    call lsp#enable()
    autocmd FileType java setlocal omnifunc=lsp#complete
endfunction

""" for xml development
command! Xmld call StartXmlDevelopment()
function! StartXmlDevelopment()
    packadd async.vim
    packadd vim-lsp
    packadd emmet-vim

    " let g:lsp_log_verbose = 1
    " let g:lsp_log_file = expand('~/vim-lsp.log')

    " for asyncomplete.vim log
    " let g:asyncomplete_log_file = expand('~/asyncomplete.log')

    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'lsp4xml',
        \ 'cmd': {server_info->[
        \     'java',
        \     '-noverify',
        \     '-Xmx1G',
        \     '-XX:+UseStringDeduplication',
        \     '-Dfile.encoding=UTF-8',
        \     '-jar',
        \     expand('~/.vim/lsp/lsp4xml/org.eclipse.lsp4xml-0.3.0-uber.jar')
        \ ]},
        \ 'whitelist': ['xml', 'arxml'],
        \ })

    call lsp#enable()
    autocmd FileType arxml setlocal omnifunc=lsp#complete
    autocmd FileType xml setlocal omnifunc=lsp#complete

    " arxml では、`:`, `-` 区切りの文字列も 1 単語として扱いたい
    autocmd FileType xml setlocal iskeyword+=-
    autocmd FileType xml setlocal iskeyword+=:

    " TODO: ExpandOrSerchNextMark みたいなことをしたい
    imap <C-L> <C-Y><Plug>(emmet-expand-abbr)
endfunction

""" for lsp
function! SearchProjectRoot(target_file)
    let l:project_root = lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), a:target_file))

    if l:project_root ==# ''
        let l:project_root = expand('%:p:h')
    endif

    return l:project_root
endfunction


""" for ctags
nnoremap <C-]> :call ctags_selector#OpenTagSelector()<Enter>

""" for markdown
" 見出し用の線を引く
augroup auto_markdown
    autocmd!
    autocmd FileType markdown nnoremap <buffer> <Leader>h1 :call Heading('=')<Return>
    autocmd FileType markdown nnoremap <buffer> <Leader>h2 :call Heading('-')<Return>
augroup END

function! Heading(char)
    " 末尾に移動
    normal $

    " 末尾の見た目の列数を取得
    let h1_char_num = virtcol('.')

    " 直下に空行を挿入
    normal o

    " 必要な数だけ文字を挿入
    execute "normal " . h1_char_num . "i" . a:char

    " 行の先頭へ移動
    normal 0

endfunction


""" for sphinx {{{
augroup auto_sphinx_rst
    autocmd!
    autocmd FileType rst noremap <buffer> gf :call CreateCursorPath()<Enter>
    autocmd FileType rst nnoremap <buffer> <Leader>h1 :call Heading('=')<Return>yykP
    autocmd FileType rst nnoremap <buffer> <Leader>h2 :call Heading('-')<Return>yykP
    autocmd FileType rst nnoremap <buffer> <Leader>h3 :call Heading('-')<Return>
    autocmd FileType rst nnoremap <buffer> <Leader>h4 :call Heading('^')<Return>
augroup END

""" カーソル下のファイルパスを取得
function! GetCursorPath()
    let current_buffer = @"
    normal BvEy
    let ret = @"
    let @" = current_buffer
    return ret
endfunction

""" カーソル下のファイルパスを開く、ファイルが存在しなければ、ファイルとその親ディレクトリを自動作成する。
function! CreateCursorPath()
    let cursor_path = GetCursorPath()
    let target_path = split(substitute(fnamemodify(expand("%:p:h") . "/" . cursor_path, ":p:h"), "\\", "/", "g"), "/")
    let target_file = fnamemodify(cursor_path, ":t")

    let current_path = target_path[0] . "/"
    if len(glob(current_path)) == 0
        call mkdir(current_path)
    else
        " do nothing
    endif

    for path in target_path[1:]
        let current_path = current_path . path . "/"
        if len(glob(current_path)) == 0
            call mkdir(current_path)
        else
            " do nothing
        endif
    endfor

    " ファイルを開く
    echo "Open: " . current_path . "/" . target_file
    execute "e " . current_path . "/" . target_file
endfunction

""" }}} for sphinx


""" {{{ for file_explorer

""" カレントディレクトリで FileExplorer を開く
nnoremap <Leader>e :call file_explorer#OpenFileExplorer(expand("%:h:p"))<Enter>

""" }}} for file_explorer

""" {{{ for Google Translate
""" Require: https://github.com/mikoto2000/MiscellaneousTools/tree/master/win/OpenGoogleTranslate
let g:OpenGoogleTranslateCommand = "~/project/MiscellaneousTools/win/OpenGoogleTranslate/OpenGoogleTranslate.bat"
command! -range OpenGoogleTranslate :call OpenGoogleTranslate()
function! OpenGoogleTranslate() range
    " 選択範囲の文字列をクリップボードにコピー
    let tmp = @@
    silent normal gvy
    let @* = @@

    " OpenGoogleTranslate スクリプトを呼び出す
    let command = fnamemodify(g:OpenGoogleTranslateCommand, ":p")
    silent execute "!start cmd /c " . command

    " 元の内容を復元
    let @@ = tmp
endfunction
""" }}} for Google Translate

""" {{{ for Snippets
inoremap <C-j> <Esc>:call SearchNextMark()<Enter>
nnoremap <C-j> <Esc>:call SearchNextMark()<Enter>
vnoremap <C-j> <Esc>:call SearchNextMark()<Enter>
inoremap <C-k> <Esc>:call SearchPrevMark()<Enter>
nnoremap <C-k> <Esc>:call SearchPrevMark()<Enter>
vnoremap <C-k> <Esc>:call SearchPrevMark()<Enter>
""" LSP形式のプレースホルダ(${1:xxx})までジャンプする
function! SearchNextMark()
    call SearchMark('w')
endfunction

function! SearchPrevMark()
    call SearchMark('b')
endfunction

function! SearchMark(search_option)
    normal 

    " 次のマークまで移動
    let l:line = search('\${\d\{-\}:\w\{-\}}', a:search_option)

    " 見つからなければ何もしない
    if l:line == 0
        return
    endif

    " マーク末尾までを置換編集
    normal vf}
endfunction

command! Snip call StartSnippet()
function! StartSnippet()
    packadd async.vim
    packadd vim-lsp

    " let g:lsp_log_verbose = 1
    " let g:lsp_log_file = expand('~/vim-lsp.log')

    " bat ファイルを作ってそれを叩くようにしたら、 'invalid content-length'
    " というエラーになってしまうのでここに全部オプションを書くようにしている。
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'lsp4snippet - md',
        \ 'cmd': {server_info->[
        \     'java',
        \     '--add-modules=ALL-SYSTEM',
        \     '--add-opens',
        \     'java.base/java.util=ALL-UNNAMED',
        \     '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        \     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        \     '-Dosgi.bundles.defaultStartLevel=4',
        \     '-Declipse.product=org.eclipse.jdt.ls.core.product',
        \     '-Dlog.level=ALL',
        \     '-noverify',
        \     '-Dfile.encoding=UTF-8',
        \     '-Xmx1G',
        \     '-jar',
        \     expand('~/project/lsp4snippet/build/libs/lsp4snippet-1.0.0.jar'),
        \     '--snippet',
        \     expand('~/.vim/snippets/markdown.yaml'),
        \ ]},
        \ 'whitelist': ['markdown'],
        \ })

    call lsp#enable()
    autocmd FileType markdown setlocal omnifunc=lsp#complete
endfunction
""" }}} for Snippets

