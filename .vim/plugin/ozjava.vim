augroup syntastic_classpath_set
    autocmd!
    autocmd BufEnter * call ozjava#checkJavaProjectRoot()
    autocmd BufEnter *.java call ozjava#initJavaProject()
    autocmd BufEnter *.gradle call ozjava#initJavaProject()
augroup END

" gradle プロジェクトのルートかを確認して、
" ルートなら色々設定する
function! ozjava#checkJavaProjectRoot()
    if has("win32") || has("win64")
        let g:syntastic_java_javac_options = '-Xlint -J-Dfile.encoding=UTF-8'
    endif
    if filereadable('build.gradle') == 1
        call ozjava#initJavaProject()
    endif
endfunc
