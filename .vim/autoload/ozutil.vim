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

" dir とその親ディレクトリを巡っていって、 fileName を探す。
" ルートディレクトリまで巡っても見つからなかったら諦める。
" 見つかったら、そのファイルのパスを返却する。
" TODO: windows 対応
function! ozutil#find(dir, fileName)
    return ozutil#findDir(a:dir, a:fileName) . "/" . a:fileName
endfunc

" dir とその親ディレクトリを巡っていって、 fileName を探す。
" ルートディレクトリまで巡っても見つからなかったら諦める。
" 見つかったら、そのファイルが存在するディレクトリのパスを返却する。
" TODO: windows 対応
function! ozutil#findDir(dir, fileName)
    " ディレクトリ末尾にセパレータがあった場合、削除
    let l:absDir = substitute(ozutil#abs(a:dir), "/$", "", "g")

    " ファイルの絶対パスを取得
    let l:filePath = ozutil#abs(l:absDir . "/" . a:fileName)

    if filereadable(filePath) == 1
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
        return ozutil#findDir(l:parentDir, a:fileName)
    endif
endfunc
