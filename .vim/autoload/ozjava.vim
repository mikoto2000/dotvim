" vim-javaclasspath のためのクラスパスファイルを探して、
" バッファーローカル変数に設定する
" TODO: l:classpath が取得できなかった時の処理
function! ozjava#set_project_classpath_for_javaclasspath(dir)
    let l:classpathFile = ozjava#getProjectRoot() . '/.classpath'
    let l:config = {'filename': l:classpathFile}

    " 定義済みのバッファローカル変数を削除
    if (exists('b:javaclasspath_config'))
        unlet b:javaclasspath_config
    endif

    " 新規バッファローカル変数を設定
    let b:javaclasspath_config = javaclasspath#get_config()
    let b:javaclasspath_config['eclipse'] = l:config
endfunc

" カレントディレクトリが eclipse プロジェクト内ならば、
" そのクラスパスを取得する。
" テストが入るのが邪魔だけど目をつぶろう。
" TODO: windows 対応
function! ozjava#get_project_classpath()
    call ozjava#set_project_classpath_for_javaclasspath(expand('%'))
    let l:classpaths = javaclasspath#source_path() . ':' . javaclasspath#classpath()
    let l:classpath_array = split(l:classpaths, ':')
    let l:return_classpath_array = []
    for classpath in l:classpath_array
        " 取得したクラスパスを絶対パスにして追加
        call add(l:return_classpath_array, ozutil#abs(l:classpath))
    endfor
    " クラスパス文字列として返却する。
    return join(l:return_classpath_array, ':')
endfunc

" バッファに開かれたファイルが所属する
" Java プロジェクトルートのパスを取得する。
"
" return バッファに開かれたファイルが所属する Java プロジェクトルートのパス
function! ozjava#getProjectRoot()
    return ozutil#findParentDirectory(
\            fnamemodify(expand('%'), ':p:h'),
\            function('ozjava#isProjectDir'))
endfunc

" バッファに開かれたファイルが所属する
" Java プロジェクトルートのパスに移動する。
function! ozjava#goToProjectRoot()
    execute ":lcd" ozjava#getProjectRoot()
endfunc

" 指定されたディレクトリが Java プロジェクトの
" ルートディレクトリかどうかを判定する。
"
" return true  : プロジェクトルートである
"        false : プロジェクトルートでない
function! ozjava#isProjectDir(dir)
    let l:absDir = ozutil#abs(a:dir) . "/build.gradle"
    if filereadable(l:absDir) == 1
        return 1
    else
        return 0
    endif
endfunc

function! ozjava#initJavaProject()
    " make プログラムを gradle へ
    setlocal makeprg=gradle

    " プロジェクトルートっぽいところへ移動
    call ozjava#goToProjectRoot()

    " .classpath 確認・作成
    if filereadable('.classpath') == 0
        call vimproc#system_bg('gradle eclipseClasspath')
    endif

    " syntastic 設定
    let g:syntastic_java_javac_classpath=ozjava#get_project_classpath()
endfunc
