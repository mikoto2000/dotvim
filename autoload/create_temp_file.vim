""" 作業ファイル作成・編集
function! create_temp_file#CreateTempFile(suffix)
    " サフィックス計算
    if a:suffix == ''
        let l:suffix_str = ''
    else
        let l:suffix_str = '_' . a:suffix
    endif

    " 日付取得
    let l:today = strftime('%Y%m%d')

    " ファイル名生成
    let l:seq_no = 1
    let l:file_name = fnamemodify('~/worklog/' . l:today . l:suffix_str . '_' . printf('%02s', l:seq_no) . '.md', ':p')
    while filereadable(l:file_name)
        let l:seq_no = l:seq_no + 1
        let l:file_name = fnamemodify('~/worklog/' . l:today . l:suffix_str . '_' . printf('%02s', l:seq_no) . '.md', ':p')
    endwhile

    execute 'e ' . l:file_name
endfunction

