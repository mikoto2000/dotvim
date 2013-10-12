""" neocomplcache
" neocomplcache の自動有効化
let g:neocomplcache_enable_at_startup = 1

""" スニペットのディレクトリ設定
let g:neosnippet#snippets_directory = $HOME . '/.vim/snippets'

" 大文字小文字を区別する
let g:neocomplcache_smart_case = 1

" キャメルケース補完を有効にする
let g:neocomplcache_enable_camelcase_completion = 1

" アンダーバー補完を有効にする
let g:neocomplcache_enable_underbar_completion = 1
"
"" シンタックスファイルの補完対象キーワードとする最小の長さ
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_min_keyword_length = 3

imap <expr><C-l>
\ neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<C-n>"

""" for golang
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'
