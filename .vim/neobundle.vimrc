""" neobundle
filetype off

set rtp+=~/.vim/bundle/neobundle.vim/
call neobundle#rc(expand('~/.vim/bundle/'))

""" for develop
if (has('lua'))
    NeoBundle 'Shougo/neocomplete'
endif
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'mattn/sonictemplate-vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-openbuf'
NeoBundle 'thinca/vim-quickrun'
if (has('clientserver'))
    NeoBundle 'thinca/vim-singleton'
endif
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'vim-scripts/Processing'
NeoBundle 'vim-scripts/sudo.vim'

""" for vim setting
NeoBundle 'tyru/restart.vim'

""" for twitter
NeoBundle 'vim-scripts/TwitVim'

filetype plugin indent on