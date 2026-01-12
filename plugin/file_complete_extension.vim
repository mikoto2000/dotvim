" カレントディレクトリを開いているファイルのディレクトリへ移動
function! file_complete_extension#start_lcd_for_insert_completion() abort
  if exists('b:_saved_lcd')
    return ''
  endif

  " 現在のウィンドウの cwd を保存
  let b:_saved_lcd = getcwd(-1)

  " 開いているファイルのディレクトリへ移動
  let l:dir = expand('%:p:h')
  if !empty(l:dir)
    execute 'lcd' fnameescape(l:dir)
  endif
  return ''
endfunction

" CompleteDone で restore_lcd を発火させる
augroup restore_lcd_after_completion
  autocmd!
  autocmd CompleteDone * call file_complete_extension#restore_lcd()
augroup END

" b:_saved_lcd に戻る
function! file_complete_extension#restore_lcd() abort
  " b:_saved_lcd があればそこに戻る
  if exists('b:_saved_lcd') && !empty(b:_saved_lcd)
    execute 'lcd' fnameescape(b:_saved_lcd)
    " 後始末、 b:_saved_lcd を unlet
    unlet b:_saved_lcd
  endif
endfunction

inoremap <expr> <C-x><C-f>
      \ file_complete_extension#start_lcd_for_insert_completion() . "\<C-x>\<C-f>"

