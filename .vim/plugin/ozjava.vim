augroup java
    autocmd!
    autocmd BufEnter *.java let g:syntastic_java_javac_options = '-Xlint -J-Dfile.encoding=UTF-8'
    autocmd BufEnter *.java call ozjava#initJavaProject()
    autocmd BufEnter *.gradle call ozjava#initJavaProject()
"    autocmd BufEnter *.java let g:JavaComplete_SourcesPath = ozjava#getProjectRoot()
"    autocmd BufEnter *.gradle let g:JavaComplete_SourcesPath = ozjava#getProjectRoot()
    autocmd BufEnter *.java set omnifunc=javacomplete#Complete
augroup END
