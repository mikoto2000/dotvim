""" Common Custom
syntax on
set tabstop=2
set nrformats=unsigned
set cindent
set smartindent
set autoindent
set expandtab
set showmatch
set shiftwidth=2
set softtabstop=2
set nocompatible
set pastetoggle=<f11>
set ignorecase
set hlsearch
set incsearch
set relativenumber
set hidden
set noswapfile
set backup
set backupcopy=yes
set foldenable
set foldmethod=marker
set cursorcolumn
set cursorline
set ambiwidth=double
set breakindent
set cmdheight=1
set nofixeol
set shellslash
set clipboard=unnamed,unnamedplus
set autoread
set diffopt=internal,filler,algorithm:histogram,indent-heuristic
set mouse=

""" {{{ for backup and undo dir
if has('nvim')
  let g:vim_cache_dir = $HOME . "/.cache/nvim"
else
  let g:vim_cache_dir = $HOME . "/.cache/vim"
end

if !isdirectory(g:vim_cache_dir)
  call mkdir(g:vim_cache_dir, "p")
endif

exec "set backupdir=" . g:vim_cache_dir . "/backup"
if !isdirectory(&backupdir)
  call mkdir(&backupdir, "p")
endif

if has('persistent_undo')
    exec "set undodir=" . g:vim_cache_dir . "/undo"
    if !isdirectory(&undodir)
      call mkdir(&undodir, "p")
    endif
    set undofile
endif
""" }}} for backup and undo dir

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

" Windows とそれ以外で vimfiles の場所が違うのでグローバル変数に記録しておく
if has("win32")
    let g:myvimfiles = $HOME . "/vimfiles"
else
    let g:myvimfiles = $HOME . "/.vim"
endif

""" tabline
exec "source " . g:myvimfiles . "/tabconf.vimrc"
""" }}} infomation lines

" Leader
let mapleader = ' '

""" split
noremap <Leader>sp :split<Enter>
noremap <Leader>vs :vsplit<Enter>

""" {{{ for command line mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
""" }}} for command line mode

" 自動折り返しを無効化
set textwidth=0

" 80 文字目をハイライト
set colorcolumn=80

""" コンテナ内にいることがわかりやすいように colorscheme を変更
if get(g:, "devcontainer_vim", v:false)
  colorscheme desert
else
  colorscheme slate
endif


""" restart setting
let g:restart_sessionoptions
            \ = 'blank,buffers,curdir,folds,help,localoptions,tabpages'

""" <C-@> 誤爆防止。ついでに <C-[> として使ってしまえ
inoremap <C-@> <ESC>
noremap <C-@> :nohlsearch<Enter>

""" <ESC> 連打で検索ハイライト削除
nnoremap <Esc><Esc> :nohlsearch<Return>

""" カーソル位置記憶
augroup restore_cursor
  autocmd!
  autocmd BufReadPost * if line("'\'") > 1 && line("'\'") <= line("$") | exe "normal! g'\"" | endif
augroup END

""" auto comment off
augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END

""" 一時ファイル作成
command! Tmp :call create_temp_file#CreateTempFile('')
command! Teirei :call create_temp_file#CreateTempFile('定例')


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
noremap <Leader>b <Esc>:buffer<Space>

""" cNext, cPrev
noremap <Leader>cn <Esc>:cn<Enter>
noremap <Leader>cp <Esc>:cp<Enter>

noremap <Leader>f <Esc>:call file_selector#OpenFileSelector()<Enter>
let g:file_selector_wildignore = '**/bin/**,**/build/**,**/gradle/**,**/node_modules/**'
let g:file_selector_exclude_pattern = '\(^bin\|^build$\|^build[/\\]\|^gradle\|^config\|^config\|^\.git$\|^target\|^node_modules\|^dist\)'

noremap <Leader>mru <Esc>:wviminfo<Enter>:rviminfo!<Enter>:call oldfiles_selector#OpenOldfilesSelector()<Enter>

noremap <Leader>o <Esc>:call outline#OpenOutlineBuffer()<Enter>

""" }}} about buffer

""" {{{ for markdown
""" disable underbar highlight
autocmd! FileType markdown hi! def link markdownItalic NONE
autocmd! FileType markdown packadd emmet-vim

"let g:markdown_fenced_languages = ['sh', 'bash', 'java', 'go', 'javascript', 'typescript']

" ※ Simai(https://github.com/mikoto2000/Simai) が必要
if get(g:, "devcontainer_vim", v:false)
  let g:simai_host = "host.docker.internal"
else
  let g:simai_host = "localhost"
endif
command! MdPreviewStart :call send_to_simai#StartPreview(g:simai_host, 7878)
command! MdPreviewStop :call send_to_simai#StopPreview()
""" }}} for markdown

""" {{{ for devcontainer
augroup devcontainer_json
    autocmd!
    autocmd BufEnter *devcontainer.json setlocal ft=json5
    autocmd BufEnter *devcontainer.vim.json setlocal ft=json5
augroup END
""" }}}

""" {{{ highlight white spaces
set list
set listchars=tab:>-,trail:-
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

" msys64 の bash で日本語入力できるように、 `$LANG` を `ja_JP.UTF-8` にする
let $LANG = "ja_JP.UTF-8"

" docker 用プロキシ設定
tnoremap <Leader><Leader>dproxy export http_proxy=http://host.docker.internal:3142<Return>
" ターミナルを最小化して次のウィンドウへ
tnoremap <Leader><Leader>_ <C-w><S-N>1<C-w>_a<C-w><C-w>

augroup terminal_ambiwidth
  autocmd!
  autocmd BufEnter * if &buftype == "terminal" | call setcellwidths([]) | endif
  autocmd BufLeave * if &buftype == "terminal" | call ambiwidth#set_ambiwidth() | endif
augroup END

""" }}} for terminal

""" {{{ for sonicktemplate-vim
let g:sonictemplate_vim_template_dir = g:myvimfiles . '/template'
""" }}} for sonicktemplate-vim

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
set grepprg=grep\ -rnIH\ --exclude-dir=.git\ --exclude-dir=.hg\ --exclude-dir=.svn\ --exclude=tags
""" }}} for grep

filetype plugin indent off

packadd codex.vim
packadd comment
packadd vim-surround
packadd vim-go-extra
packadd vim-suda
packadd buffer_selector.vim
packadd file_selector.vim
packadd oldfiles_selector.vim
packadd ctags_selector.vim
packadd outline.vim
packadd keyinput-delayer.vim

filetype plugin indent on

""" {{{ for blog
augroup m2h
    autocmd!
    autocmd FileType markdown command! M2h call m2h#M2H()
    autocmd FileType markdown command! M2hsc call m2h#M2H_SC()
augroup END
""" }}} for blog

""" {{{ radix conversion
command! Num2b execute "normal! viwc<C-R>=printf(\"0b%b\", <C-R>\")<Return><Esc>"
command! Num2d execute "normal! viwc<C-R>=printf(\"%d\", <C-R>\")<Return><Esc>"
command! Num2x execute "normal! viwc<C-R>=printf(\"0x%04X\", <C-R>\")<Return><Esc>"
command! Num2Mask0 execute "normal! viwc<C-R>=printf(\"0x%04X\", printf(\"%.f\", pow(2, <C-R>\")))<Return><Esc>"
command! Num2Mask1 execute "normal! viwc<C-R>=printf(\"0x%04X\", printf(\"%.f\", pow(2, <C-R>\"-1)))<Return><Esc>"
""" }}} radix conversion

" 選択範囲の式を評価して置き換える(改行未対応)
vnoremap <Leader>= c<C-R>=eval("<C-R>"")<Return><Esc>

""" for complete
" プレビューウィンドウを開かないようにする
" 補完呼び出し時に自動で先頭のアイテムが選択状態になるのを防ぐ
set completeopt=menuone,noselect

" <C-Space> でオムニ補完を行えるようにマッピング
" オムニ補完開始直後に、インクリメンタル絞り込みができるようにマッピング
inoremap <C-Space> <C-X><C-O><C-P>


""" for ctags
nnoremap <C-]> :call ctags_selector#OpenTagSelector()<Enter>

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
    normal! BvEy
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
    silent normal! gvy
    let @* = @@

    " OpenGoogleTranslate スクリプトを呼び出す
    let command = fnamemodify(g:OpenGoogleTranslateCommand, ":p")
    silent execute "!start cmd /c " . command

    " 元の内容を復元
    let @@ = tmp
endfunction
""" }}} for Google Translate

""" {{{ for c3tr Translate
""" Require:
""" - https://huggingface.co/webbigdata/C3TR-Adapter_gguf
""" - https://github.com/ggerganov/llama.cpp(llama-server)
""" - https://github.com/koron/c3tr-client
""" TODO: 結果表示をいい感じにしたい
""" TODO: 複数行を結合して渡したい
let g:OpenLlamaTranslateCommand = "F:/llm/c3tr-client.exe"
command! -range OpenLlamaTranslate :call OpenLlamaTranslate()
function! OpenLlamaTranslate() range
    " 選択範囲の文字列をクリップボードにコピー
    let tmp = @@
    silent normal! gvy
    let @* = @@

    " OpenGoogleTranslate スクリプトを呼び出す
    execute "!cmd /c F:/llm/c3tr-client.exe " . @@

    " 元の内容を復元
    let @@ = tmp
endfunction
""" }}} for c3tr Translate

" {{{ for vim-lsp
let g:lsp_log_verbose = 0
let g:lsp_log_file = expand('~/vim-lsp.log')

packadd vim-lsp
packadd vim-lsp-settings

let g:lsp_settings_root_markers = [
\   'pom.xml', 'Makefile'
\ ]

"let g:lsp_settings = {
"\   'lemminx': {
"\       'workspace_config': {
"\           'implementation': {
"\               'completionItem': {
"\                   'snippetSupport': v:true
"\               }
"\           }
"\       }
"\   },
"\  'typeprof': {'disabled': 1},
"\}

set omnifunc=lsp#complete

inoremap <silent> <C-.> <C-o>:LspCodeAction<Enter>
nnoremap <silent> <C-.> :LspCodeAction<Enter>
inoremap <silent> <F2> <C-o>:LspRename<Enter>
nnoremap <silent> <F2> :LspRename<Enter>
inoremap <silent> <A-S-f> <C-o>:LspDocumentFormat<Enter>
nnoremap <silent> <A-S-f> :LspDocumentFormat<Enter>
vnoremap <silent> <A-S-f> :LspDocumentRangeFormat<Enter>
inoremap <silent> <F12> <C-o>:LspDefinition<Enter>
nnoremap <silent> <F12> :LspDefinition<Enter>
inoremap <silent> <C-k><C-i> <C-o>:LspHover<Enter>
nnoremap <silent> <C-k><C-i> :LspHover<Enter>

""" for xml development {{{
autocmd FileType xml packadd emmet-vim
autocmd FileType xml setlocal iskeyword+=-
autocmd FileType xml setlocal iskeyword+=:
autocmd FileType xml let g:xml_syntax_folding = 1
autocmd FileType xml setlocal foldmethod=syntax
""" }}} for xml development

" }}} for vim-lsp

" {{{ for ARXML
autocmd BufNewFile,BufRead *.arxml set filetype=xml
" }}} for ARXML

""" {{{ for Html
augroup html
    autocmd!
    autocmd FileType html packadd emmet-vim
augroup END
"""i }}}

""" {{{ for 人と見るときは普通の行番号表示にしたい
command! ToggleNumbers call ToggleNumbers()
function! ToggleNumbers()
    let &number = !&number
    let &relativenumber = !&relativenumber
endfunction
""" }}} for 人と見るときは普通の行番号表示にしたい

""" {{{ for tinysnippet
packadd! tiny-snippet.vim
let g:tiny_snippet_snippet_directories_custom = [g:myvimfiles . "/snippets"]

inoremap <silent> <C-j> <Esc>:call tinysnippet#select_next()<Enter>
nnoremap <silent> <C-j> <Esc>:call tinysnippet#select_next()<Enter>
vnoremap <silent> <C-j> <Esc>:call tinysnippet#select_next()<Enter>
inoremap <silent> <C-k> <Esc>:call tinysnippet#select_prev()<Enter>
nnoremap <silent> <C-k> <Esc>:call tinysnippet#select_prev()<Enter>
vnoremap <silent> <C-k> <Esc>:call tinysnippet#select_prev()<Enter>

set completefunc=tinysnippet#Complete

""" }}} for tinysnippet

""" {{{ for file complete
inoremap <expr> /
      \ complete_info(['mode']).mode == 'files' && complete_info(['selected']).selected >= 0
      \   ? '<c-x><c-f>'
      \   : '/'
""" }}}

""" {{{ for convert case
command! ConvertToUpperCamel call caseconverter#ToUpperCamelCase()
command! ConvertToLowerCamel call caseconverter#ToLowerCamelCase()
command! ConvertToUpperSnake call caseconverter#ToUpperSnakeCase()
command! ConvertToLowerSnake call caseconverter#ToLowerSnakeCase()
""" }}} for convert case

""" vim/neovim 別設定
if has('nvim')
  exec "source " . g:myvimfiles . "/nvim/vimrc"
else
  exec "source " . g:myvimfiles . "/vim/vimrc"
endif


""" {{{ for copilot.vim
if executable("node")
  " TODO: copilot.vim の help を見て設定する
endif
""" }}} for copilot.vim

""" {{{ Vim ゴルファー養成ギプス
command! ToggleGolfTraining call keyinput_delayer#ToggleKeyInputDelay()
""" }}} Vim ゴルファー養成ギプス

""" from https://zenn.dev/vim_jp/articles/67ec77641af3f2
nmap zz zz<sid>(z1)
nnoremap <script> <sid>(z1)z zt<sid>(z2)
nnoremap <script> <sid>(z2)z zb<sid>(z3)
nnoremap <script> <sid>(z3)z zz<sid>(z1)

""" {{{ ヴィジュアルモード時の p と P 入れ替え
vnoremap p P
vnoremap P p
""" }}} ヴィジュアルモード時の p と P 入れ替え

""" {{{ ウィンドウポジションのセーブとレストア
function! SaveWindowPos()
  let g:restore_window_pos_cmd = winrestcmd()
endfunction
function! RestoreWindowPos()
  execute g:restore_window_pos_cmd
endfunction
nnoremap <Leader>sw :call SaveWindowPos()<Enter>
nnoremap <Leader>rw :call RestoreWindowPos()<Enter>
""" }}} ウィンドウポジションのセーブとレストア

""" {{{ for codex.vim
" 選択範囲のテキストをリクエストとして送るコマンド
command! -range CodexRequest call codex#Request(codex#GetVisualText())

" リクエスト専用バッファを開くコマンド
command! CodexOpenRequestBuffer call codex#OpenRequestBuffer()

" リクエスト専用バッファの内容をリクエストとして送るコマンド
command! CodexRequestFromBuffer call codex#RequestFromBuffer()

" コンテキストをリセットするコマンド
command! CodexResetContext call codex#ResetContext()
""" }}} for codex.vim

""" {{{ カーソル下の単語ハイライト
augroup CursorWordHighlight
  autocmd!
  autocmd CursorMoved,CursorMovedI * call cursorword#HighlightCrsorWord()
augroup END
""" }}} カーソル下の単語ハイライト

""" {{{ サブモード
:vim9 import "./autoload/submode.vim"
:vim9 g:submode_mappings = {
      \   'winsize': {
      \     '+': ':resize +1<CR>',
      \     '-': ':resize -1<CR>',
      \     '<': ':vertical resize -1<CR>',
      \     '>': ':vertical resize +1<CR>',
      \   },
      \ }

nnoremap <C-w>+ :call submode#EnterSubmode('winsize')<Enter>+
nnoremap <C-w>- :call submode#EnterSubmode('winsize')<Enter>-
nnoremap <C-w>< :call submode#EnterSubmode('winsize')<Enter><
nnoremap <C-w>> :call submode#EnterSubmode('winsize')<Enter>>
""" }}} サブモード

highlight CursorWord cterm=bold ctermbg=darkgreen gui=bold guibg=darkgreen
