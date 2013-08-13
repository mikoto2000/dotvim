""" neobundle
filetype off

set rtp+=~/.vim/bundle/neobundle.vim/
call neobundle#rc(expand('~/.vim/bundle/'))

" www.vim.org
NeoBundle 'git.zip'

""" for develop
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-openbuf'
NeoBundle 'thinca/vim-singleton'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'vim-scripts/Processing'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scrooloose/syntastic'
" NeoBundle 'cocoa.vim'

""" 
NeoBundle 'tyru/restart.vim'

""" for twitter
NeoBundle 'vim-scripts/TwitVim'

filetype plugin indent on
