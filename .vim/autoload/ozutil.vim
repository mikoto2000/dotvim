" path の絶対パスを求めて返却する。
function! ozutil#abs(path)
    return fnamemodify(a:path, ":p")
endfunc

" path がルートディレクトリかどうかを判定する
" TODO: windows 対応
function! ozutil#is_root_directory(path)
    let l:target = fnamemodify(a:path, ":p")
    " 最後に '/' があるかないかで '/' or '/../' になるので、
    " どちらかだったらルートディレクトリと判断する。
    if target == "/" || target == "/../"
        return 1
    else
        return 0
    endif
endfunc

" dir とその親ディレクトリを巡っていって、
" 各ディレクトリに対して isReturnDirectory で条件確認。
" isReturnDirectory == true ならそのディレクトリパスを返却する。
" TODO: windows 対応
function! ozutil#findParentDirectory(dir, isReturnDirectory)
    " ディレクトリ末尾にセパレータがあった場合、削除
    let l:absDir = substitute(ozutil#abs(a:dir), "/$", "", "g")

    " 返却条件を確認
    let l:isReturnDirectory = call(a:isReturnDirectory, [l:absDir])

    if l:isReturnDirectory == 1
        " ファイルが見つかったらファイルパスを返却する
        return l:absDir
    elseif ozutil#is_root_directory(a:dir) == 1
        " ファイルが見つからない、かつ、
        " ここがルートディレクトリならば 0 を返却する
        return 0
    else
        " ファイルが見つからない、かつ、
        " ここがルートディレクトリ出ないならば、
        " 再帰的に親ディレクトリを探す。
        let l:parentDir = fnamemodify(l:absDir, ":h")
        return ozutil#findParentDirectory(l:parentDir, a:isReturnDirectory)
    endif
endfunc

