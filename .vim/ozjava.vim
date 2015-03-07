" カレントディレクトリが eclipse プロジェクト内ならば、
" そのクラスパスを取得する。
" テストが入るのが邪魔だけど目をつぶろう。
" TODO: windows 対応
function! ozjava#get_project_classpath()
    let l:classpaths = javaclasspath#source_path() . ':' . javaclasspath#classpath()
    let l:classpath_array = split(l:classpaths, ':')
    let l:return_classpath_array = []
    let l:project_root = unite#util#path2project_directory(expand('%'))
    for classpath in l:classpath_array
        " 取得したクラスパスが絶対パスならそのまま、
        " 相対パスならばプロジェクトルートからの相対パスと認識
        if classpath[0] == '/'
            call add(l:return_classpath_array, classpath)
        else
            call add(l:return_classpath_array, l:project_root . '/' . classpath)
        endif
    endfor
    " クラスパス文字列として返却する。
    return join(l:return_classpath_array, ':')
endfunc

augroup syntastic_classpath_set
    autocmd!
    autocmd BufEnter *.java execute 'lcd' unite#util#path2project_directory(expand('%'))
    autocmd BufEnter *.java let g:syntastic_java_javac_classpath=ozjava#get_project_classpath()
augroup END

nnoremap <Space>fj :Unite find<Enter><Enter>*.java<Enter>
