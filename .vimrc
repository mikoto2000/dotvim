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

" Leader
let mapleader = ' '

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" 自動折り返しを無効化
set textwidth=0

" 80 文字目をハイライト
set colorcolumn=80

colorscheme desert

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
command! Tmp :e ~/worklog/$TODAY.mkd | :set filetype=markdown

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
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
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
set listchars=tab:>-,eol:$,trail:-
set showbreak=\\\ 

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

""" for java development
command! Javad call StartJavaDevelopment()
function! StartJavaDevelopment()
    packadd unite.vim
    packadd vim-javaclasspath
    packadd vim-unite-javaimport

    let g:javaimport_config.exclude_packages = ['com.oracle', 'cum.sun', 'sun', 'sunw', 'org.ietf', 'org.jcp', 'org.omg']

    command! Import call QuickImport()
    function! QuickImport()
        normal viwy
        let word = @"
        Unite javaimport/class
        call feedkeys('i' . word)
    endfunction
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


""" {{{ Filer

""" カレントディレクトリで FileBrowser を開く
nnoremap <Leader>e :call StartFileBrowser(getcwd())<Enter>

augroup file_browser
    autocmd!
    autocmd FileType filebrowser nnoremap <buffer> l :call OpenFileOrDirectory()<Enter>
    autocmd FileType filebrowser nnoremap <buffer> <Enter> :call OpenFileOrDirectory()<Enter>
    autocmd FileType filebrowser nnoremap <buffer> h :call MoveUpperDirectory()<Enter>
    autocmd FileType filebrowser nnoremap <buffer> c :call LcdCurrent()<Enter>
augroup END

function! StartFileBrowser(path)
    let g:file_browser_pwd = a:path

    " 呼び出し元のウィンドウ ID を記憶
    let g:caller_window_id = win_getid()

    " 新しいバッファを作成
    if bufexists(bufnr('__FILE_BROWSER_FILE_LIST__'))
        bwipeout! __FILE_BROWSER_FILE_LIST__
    endif
    silent hide noswap enew
    silent file `='__FILE_BROWSER_FILE_LIST__'`

    " ファイルリスト取得
    call UpdateBuffer('')

    " リスト用バッファの設定
    setlocal noshowcmd
    setlocal noswapfile
    setlocal buftype=nofile
    setlocal nobuflisted
    setlocal nomodifiable
    setlocal wrap
    setlocal nonumber
    setlocal filetype=filebrowser
endfunction

function! UpdateBuffer(dir)
    setlocal modifiable
    silent normal ggVGd
    if a:dir != ''
        let g:file_browser_pwd = fnamemodify(g:file_browser_pwd . '\\' . a:dir, ':p')
    endif
    let fullpath_files = glob(g:file_browser_pwd . '/*')
    let files = substitute(fullpath_files, substitute(g:file_browser_pwd . '\', '\\', '\\\\', 'g'), '', 'g')
    silent put! = files
    normal gg
    setlocal nomodifiable
endfunction

function! MoveUpperDirectory()
    call UpdateBuffer('..')
endfunction

function! OpenFileOrDirectory()
    let target = getline('.')
    if isdirectory(g:file_browser_pwd . '\\' . target)
        call OpenDirectory(target)
    else
        call OpenFile(target)
    endif
endfunction

function! OpenDirectory(target)
    call UpdateBuffer(a:target)
endfunction

function! OpenFile(target)
    execute 'e ' . g:file_browser_pwd . '/' . a:target
endfunction

function! GetPath()
    return substitute(g:file_browser_pwd . getline('.'), '\\', '\\\\', 'g')
endfunction

function! LcdCurrent()
    execute ":lcd " . g:file_browser_pwd
endfunction
""" }}} Filer
