function buffer_selector#OpenBufferSelector()
    """ 変数 buffer_list に ``:ls`` の結果を格納
    let buffer_list=""
    redir => buffer_list
    silent ls
    redir END

    """ 新しいバッファを作成
    if bufexists(bufnr('__BUFFERLIST__'))
        bwipeout! __BUFFERLIST__
    endif
    silent bo new __BUFFERLIST__

    """ __BUFFERLIST__ に ``:ls`` の結果を表示
    silent put!=buffer_list

    """ 先頭と末尾が空行になるのでそれを削除
    normal G"_dd
    normal gg"_dd

    """ ウィンドウサイズ調整
    let current_win_height=winheight('%')
    let line_num=line('$')
    if current_win_height - line_num > 0
        execute "normal z" . line_num . "\<Return>"
    endif

    """ バッファリスト用バッファの設定
    setlocal noshowcmd
    setlocal noswapfile
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    setlocal nomodifiable
    setlocal nowrap
    setlocal nonumber

    """ 選択したバッファに移動
    map <buffer> <Return> ^viwy:bwipeout!<Return>:buffer <C-r>"<Return>
    map <buffer> q :bwipeout!<Return>
endfunction
