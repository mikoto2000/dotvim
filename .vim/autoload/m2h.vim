function! m2h#M2H_CB(job, status)
    call job_start("cmd /c " . s:m2h_tmp, {'out_io': 'null'})

    " 出力用一時バッファを split して開く
    new `=s:m2h_tmp`
endfunction

function! m2h#M2H()
    " 開いているバッファにファイルが紐づいているなら格納されているディレクトリを取得
    let cwd = expand('%:h')
    if cwd == ''
        cwd = getcwd()
    endif

    " 一時ファイル名をもらう
    let tempfile_in = tempname()
    let tempfile_out = fnamemodify(tempname().".html", ":p")
    let s:m2h_tmp = tempfile_out

    " 入力用一時ファイルに現在のバッファの内容を保存
    w `=tempfile_in`

    " pandoc で Markdown -> html 変換
    " 出力先は出力用一時バッファ
    call job_start("pandoc --toc --toc-depth 4 -f markdown+pandoc_title_block-ascii_identifiers -t html5 --standalone " . tempfile_in, {'cwd': cwd, 'out_io': 'file', 'out_name': tempfile_out, 'exit_cb': function("m2h#M2H_CB")})
endfunction

function! m2h#M2H_SC()
    " 開いているバッファにファイルが紐づいているなら格納されているディレクトリを取得
    let cwd = expand('%:h')
    if cwd == ''
        cwd = getcwd()
    endif

    " 一時ファイル名をもらう
    let tempfile_in = tempname()
    let tempfile_out = fnamemodify(tempname().".html", ":p")
    let s:m2h_tmp = tempfile_out

    " 入力用一時ファイルに現在のバッファの内容を保存
    w `=tempfile_in`

    " pandoc で Markdown -> html 変換
    " 出力先は出力用一時バッファ
    call job_start("pandoc --toc --toc-depth 4 -f markdown+pandoc_title_block-ascii_identifiers -t html5 --standalone --self-contained " . tempfile_in, {'cwd': cwd, 'out_io': 'file', 'out_name': tempfile_out, 'exit_cb': function("m2h#M2H_CB")})
endfunction

