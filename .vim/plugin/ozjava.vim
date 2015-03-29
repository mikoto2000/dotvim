augroup syntastic_classpath_set
    autocmd!
    autocmd BufEnter *.java call ozjava#goToProjectRoot()
    autocmd BufEnter *.java let g:syntastic_java_javac_classpath=ozjava#get_project_classpath()
augroup END

