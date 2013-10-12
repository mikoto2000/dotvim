""" neocomplete
" neocomplete の自動有効化
let g:neocomplete#enable_at_startup = 1

" 大文字小文字を区別する
let g:neocomplete#smart_case = 1

" キャメルケース補完を有効にする
let g:neocomplete#enable_camelcase_completion = 1

" アンダーバー補完を有効にする
let g:neocomplete#enable_underbar_completion = 1
"
"" シンタックスファイルの補完対象キーワードとする最小の長さ
let g:neocomplete#min_syntax_length = 3
let g:neocomplete#min_keyword_length = 3

""" {{{ for neosnippet
""" スニペットのディレクトリ設定
let g:neosnippet#snippets_directory = $HOME . '/.vim/snippets'

imap <expr><C-l>
\ neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<C-n>"
""" }}} for neosnippet

""" {{{ for golang
if !exists('g:neocomplete#omni_patterns')
    let g:neocomplete#omni_patterns = {}
endif
let g:neocomplete#omni_patterns.go = '\h\w*\.\?'
""" }}} for golang
