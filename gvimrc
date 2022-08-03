" Windows 版 gvim のメニュー文字化け対策
if has('win32') || has('win64')
    source $VIMRUNTIME/delmenu.vim
    set langmenu=ja_jp.utf-8
    source $VIMRUNTIME/menu.vim
endif

""" メニュー設定
set guioptions=

highlight Error term=none ctermfg=15 ctermbg=124 gui=bold guifg=#ff5050 guibg=#343434
highlight ErrorMsg term=none ctermfg=15 ctermbg=124 gui=bold guifg=#ff5050 guibg=#343434

set visualbell
set vb t_vb=

""" フォント設定
if has('win32') || has('win64')
    set guifont=Osaka－等幅:h9,Ricty_Diminished:h16:cSHIFTJIS:qDRAFT,ＭＳ_ゴシック:h12:cSHIFTJIS:qDRAFT
    set rop=type:directx
else
    set guifont=Ricty_Diminished\ 13
endif

" 引数なしで開いた場合にホームディレクトリに移動する
augroup cdhome
    autocmd VimEnter * nested if @% == '' | lcd ~/ | endif
augroup END

""" {{{ for windows position save
""" from [vim-jp » Hack #120: gVim でウィンドウの位置とサイズを記憶する](http://vim-jp.org/vim-users-jp/2010/01/28/Hack-120.html)
let g:save_window_file = expand(g:myvimfiles . '/winpos')
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ 'set columns=' . &columns,
      \ 'set lines=' . &lines,
      \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
      \ ]
    call writefile(options, g:save_window_file)
  endfunction
augroup END

if filereadable(g:save_window_file)
  execute 'source' g:save_window_file
endif
""" }}} for windows position save
