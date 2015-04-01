augroup syntastic_classpath_set
    autocmd!
    autocmd BufEnter * call ozjava#checkJavaProjectRoot()
    autocmd BufEnter *.java call ozjava#initJavaProject()
    autocmd BufEnter *.gradle call ozjava#initJavaProject()
augroup END

" gradle プロジェクトのルートかを確認して、
" ルートなら色々設定する
function! ozjava#checkJavaProjectRoot()
    if filereadable('build.gradle') == 1
        call ozjava#initJavaProject()
    endif
endfunc
