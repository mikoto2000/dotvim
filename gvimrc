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

""" {{{ highlight white spaces
set listchars=tab:>-,trail:-
""" }}} highlight white spaces

" 引数なしで開いた場合にホームディレクトリに移動する
if argc() == 0
  cd ~
endif

""" {{{ for windows position save
""" from [vim-jp » Hack #120: gVim でウィンドウの位置とサイズを記憶する](http://vim-jp.org/vim-users-jp/2010/01/28/Hack-120.html)
"""let g:save_window_file = expand(g:myvimfiles . '/winpos')
"""augroup SaveWindow
"""  autocmd!
"""  autocmd VimLeavePre * call s:save_window()
"""  function! s:save_window()
"""    let options = [
"""      \ 'set columns=' . &columns,
"""      \ 'set lines=' . &lines,
"""      \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
"""      \ ]
"""    call writefile(options, g:save_window_file)
"""  endfunction
"""augroup END
"""
"""if filereadable(g:save_window_file)
"""  execute 'source' g:save_window_file
"""endif
""" }}} for windows position save

""" {{{ for guifont
command! UpFontSize call AddGuifontSize(1)
nnoremap <Leader>fu :UpFontSize<Enter>
command! DownFontSize call AddGuifontSize(-1)
nnoremap <Leader>fd :DownFontSize<Enter>
function! AddGuifontSize(number)
    " 現在の guifont を取得
    let guifont = &guifont

    " 現在の guifont に列挙されているフォント定義ごとにフォントサイズ更新処理を実施
    let fonts = []
    for font in split(l:guifont, ",")
        let new_font = UpdateFontSize(l:font, a:number)
        call add(l:fonts, l:new_font)
    endfor

    " 更新したフォント定義を ',' 区切りで結合
    let new_guifont = join(l:fonts, ",")

    " guifont へ設定
    call SetGuiFont(l:new_guifont)
endfunction

function! UpdateFontSize(font, number)
    let font_size_str = split(a:font, ":")[1][1:]
    let font_size = str2nr(l:font_size_str)
    let new_font_size = font_size + a:number
    return substitute(a:font, l:font_size_str, l:new_font_size, "")
endfunction
""" }}} for guifont

""" vim/neovim 別設定
if has('nvim')
  exec "source " . g:myvimfiles . "/nvim/gvimrc"
else
  exec "source " . g:myvimfiles . "/vim/gvimrc"
endif
