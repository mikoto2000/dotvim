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
set foldenable
set foldmethod=marker
set cursorcolumn
set ambiwidth=double
set breakindent
set cmdheight=2
set nofixeol
set shellslash

if has("win32")
    let g:myvimfiles = $HOME . "/vimfiles"
else
    let g:myvimfiles = $HOME . "/.vim"
endif

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
    command! Shell !start C:\msys64\msys2_shell.cmd -here
endif
""" }}} for Windows

exec "set backupdir=" . g:myvimfiles . "/backup"

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
    exec "set undodir=" . g:myvimfiles . "/undo"
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
command! Tmp :call CreateTempFile()

function! CreateTempFile()
    " 日付取得
    let l:today = strftime('%Y%m%d')
    let l:seq_no = 1
    while filereadable(fnamemodify('~/worklog/' . l:today . '_' . printf('%02s', l:seq_no) . '.md', ':p'))
        let l:seq_no = l:seq_no + 1
    endwhile
    execute 'e ~/worklog/' . l:today . '_' . printf('%02s', l:seq_no) . '.md'
endfunction

""" {{{ rc 系を開く
command! Vimrc :e $MYVIMRC
command! Gvimrc :e $MYGVIMRC
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
exec "source " . g:myvimfiles . "/tabconf.vimrc"
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
command! Bash execute "terminal ++close c:/tools/msys64/usr/bin/env.exe CHERE_INVOKING=1 /bin/bash.exe --login"
""" }}} for terminal

""" {{{ for sonicktemplate-vim
let g:sonictemplate_vim_template_dir = g:myvimfiles . '/template'
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

"packadd vim-lsp
"packadd vim-lsp-settings

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

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

" {{{ for vim-lsp
packadd vim-lsp-tiny-snippet-support
packadd vim-lsp-settings
packadd vim-lsp

inoremap <silent> <C-j> <Esc>:call lsp#tinysnippet#select_next()<Enter>
nnoremap <silent> <C-j> <Esc>:call lsp#tinysnippet#select_next()<Enter>
vnoremap <silent> <C-j> <Esc>:call lsp#tinysnippet#select_next()<Enter>
inoremap <silent> <C-k> <Esc>:call lsp#tinysnippet#select_prev()<Enter>
nnoremap <silent> <C-k> <Esc>:call lsp#tinysnippet#select_prev()<Enter>
vnoremap <silent> <C-k> <Esc>:call lsp#tinysnippet#select_prev()<Enter>

let g:lsp_settings = {
\   'lemminx': {
\       'workspace_config': {
\           'implementation': {
\               'completionItem': {
\                   'snippetSupport': v:true
\               }
\           }
\       }
\   }
\}

""" for xml development {{{
autocmd FileType xml setlocal omnifunc=lsp#complete
autocmd FileType xml packadd emmet-vim
autocmd FileType xml setlocal iskeyword+=-
autocmd FileType xml setlocal iskeyword+=:
""" }}} for xml development

" {{{ for snippet
call lsp#register_server({
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
    \     '--snippet',
    \     expand('~/.vim/snippets/asciidoc.yaml'),
    \ ]},
    \ 'whitelist': ['markdown', 'asciidoc'],
    \ })
""" }}} for snippet

" }}} for vim-lsp

" {{{ for ARXML
autocmd BufNewFile,BufRead *.arxml set filetype=xml
" }}} for ARXML

