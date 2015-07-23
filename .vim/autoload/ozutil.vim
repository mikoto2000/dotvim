" path の絶対パスを求めて返却する。
function! ozutil#abs(path)
    return fnamemodify(a:path, ":p")
endfunc

" path がルートディレクトリかどうかを判定する
function! ozutil#is_root_directory(path)
    let l:target = fnamemodify(a:path, ":p")
    if has("win32") || has("win64")
        " windows のルート判定処理
        if match(l:target, "[A-Za-z]:\\\\$") == 0
            let l:is_root = 1
        else
            let l:is_root = 0
        endif
    else
        " unix のルート判定処理
        " 最後に '/' があるかないかで '/' or '/../' になるので、
        " どちらかだったらルートディレクトリと判断する。
        if l:target == "/" || l:target == "/../"
            let l:is_root = 1
        else
            let l:is_root = 0
        endif
    endif

    return l:is_root
endfunc

" dir とその親ディレクトリを巡っていって、
" 各ディレクトリに対して isReturnDirectory で条件確認。
" isReturnDirectory == true ならそのディレクトリパスを返却する。
" TODO: windows 対応
function! ozutil#findParentDirectory(dir, isReturnDirectory)
    let l:absDir = ozutil#abs(a:dir)
    " 返却条件を確認
    let l:isReturnDirectory = call(a:isReturnDirectory, [l:absDir])

    if l:isReturnDirectory == 1
        " ファイルが見つかったらファイルパスを返却する
        return l:absDir
    elseif ozutil#is_root_directory(l:absDir) == 1
        " ファイルが見つからない、かつ、
        " ここがルートディレクトリならば空文字を返却する
        return ""
    else
        " ファイルが見つからない、かつ、
        " ここがルートディレクトリ出ないならば、
        " 再帰的に親ディレクトリを探す。

        " ディレクトリ末尾にセパレータがあった場合、削除
        if has("win32") || has("win64")
            let l:normalizedAbsDir = substitute(l:absDir, "\\\\$", "", "g")
        else
            let l:normalizedAbsDir = substitute(l:absDir, "/$", "", "g")
        endif

        " 親ディレクトリのパス取得
        let l:parentDir = fnamemodify(l:normalizedAbsDir, ":h")

        " 親ディレクトリを指定して再帰
        return ozutil#findParentDirectory(l:parentDir, a:isReturnDirectory)
    endif
endfunc

