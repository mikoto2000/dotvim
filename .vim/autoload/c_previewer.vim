" 使用するコマンドの定義
let g:c_previewer_toolchain = get(g:, 'c_previewer_toolchain', '')
let g:c_previewer_gcc = get(g:, 'c_previewer_gcc', g:c_previewer_toolchain . 'gcc')
let g:c_previewer_objdump = get(g:, 'c_previewer_objdump', g:c_previewer_toolchain . 'objdump')
let g:c_previewer_cpp = get(g:, g:c_previewer_toolchain . 'c_previewer_cpp', 'cpp')
let g:c_previewer_hexdump = 'hexdump'
let g:c_previewer_nm = 'nm'
let g:c_previewer_cflags = get(g:, 'c_previewer_cflags', '')

" 使用するバッファの定義
let s:buffer_assemble = ""
let s:buffer_headers = ""
let s:buffer_symbols = ""
let s:buffer_hex = ""
let s:buffer_cpp = ""

" 使用する一時ファイルの定義
let s:tempfile_object = ""
let s:tempfile_assemble = ""
let s:tempfile_headers = ""
let s:tempfile_symbols = ""
let s:tempfile_hex = ""
let s:tempfile_cpp = ""

function! c_previewer#init()
    let s:tempfile_object = tempname()
    let s:tempfile_assemble = tempname()
    let s:tempfile_headers = tempname()
    let s:tempfile_symbols = tempname()
    let s:tempfile_hex = tempname()
    let s:tempfile_cpp = tempname()
endfunction

function! c_previewer#OpenAssembleBuffer()
    let source = fnamemodify(expand("%"), ":p")
    silent execute "!" . g:c_previewer_gcc . " -S " . g:c_previewer_cflags . " -o " . s:tempfile_assemble . " " . source
    execute "split " . s:tempfile_assemble

    " バッファの設定
    call c_previewer#InitBufferOption()
endfunction

function! c_previewer#OpenHeadersBuffer()
    let source = fnamemodify(expand("%"), ":p")
    execute "split " . s:tempfile_headers
    call c_previewer#SetBufferOption_edit()
    silent execute "!" . g:c_previewer_gcc . " -c " . g:c_previewer_cflags . " -o " . s:tempfile_object . " " . source
    silent execute "read !" . g:c_previewer_objdump . " --all-headers " . s:tempfile_object

    " バッファの設定
    call c_previewer#InitBufferOption()
endfunction

function! c_previewer#OpenSymbolsBuffer()
    let source = fnamemodify(expand("%"), ":p")
    execute "split " . s:tempfile_symbols
    call c_previewer#SetBufferOption_edit()
    silent execute "!" . g:c_previewer_gcc . " -c " . g:c_previewer_cflags . " -o " . s:tempfile_object . " " . source
    silent execute "read !" . g:c_previewer_nm . " " . s:tempfile_object

    " バッファの設定
    call c_previewer#InitBufferOption()
endfunction

function! c_previewer#OpenHexBuffer()
    let source = fnamemodify(expand("%"), ":p")
    execute "split " . s:tempfile_hex
    call c_previewer#SetBufferOption_edit()

    silent execute "!" . g:c_previewer_gcc . " -c " . g:c_previewer_cflags . " -o " . s:tempfile_object . " " . source
    silent execute "read !" . g:c_previewer_hexdump . " " . s:tempfile_object

    " バッファの設定
    call c_previewer#InitBufferOption()
endfunction

function! c_previewer#OpenPreprocessBuffer()
    let source = fnamemodify(expand("%"), ":p")
    silent execute "!" . g:c_previewer_cpp . " " . g:c_previewer_cflags . " -o " . s:tempfile_cpp . " " . source
    execute "split " . s:tempfile_cpp

    " バッファの設定
    call c_previewer#InitBufferOption()
    set filetype=c
endfunction

function! c_previewer#InitBufferOption()
    setlocal noshowcmd
    setlocal noswapfile
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    setlocal nomodifiable
    setlocal nowrap
    setlocal nonumber
endfunction

function! c_previewer#SetBufferOption_edit()
    setlocal modifiable
endfunction

