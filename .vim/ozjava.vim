" vim-javaclasspath のためのクラスパスファイルを探して、
" バッファーローカル変数に設定する
" TODO: l:classpath が取得できなかった時の処理
function! ozjava#set_classpath(dir)
    let l:classpath = ozutil#find(a:dir, ".classpath")
    let l:config = {'filename':classpath}

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
    call ozjava#set_classpath('.')
    let l:classpaths = javaclasspath#source_path() . ':' . javaclasspath#classpath()
    let l:classpath_array = split(l:classpaths, ':')
    let l:return_classpath_array = []
    for classpath in l:classpath_array
        " 取得したクラスパスが絶対パスならそのまま、
        " 相対パスならばプロジェクトルートからの相対パスと認識
        if classpath[0] == '/'
            call add(l:return_classpath_array, classpath)
        else
            call add(l:return_classpath_array, ozutil#findDir('.', '.classpath') . '/' . classpath)
        endif
    endfor
    " クラスパス文字列として返却する。
    return join(l:return_classpath_array, ':')
endfunc

augroup syntastic_classpath_set
    autocmd!
    autocmd BufEnter *.java let g:syntastic_java_javac_classpath=ozjava#get_project_classpath()
augroup END
