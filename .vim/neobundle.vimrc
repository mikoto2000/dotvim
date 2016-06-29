""" neobundle
filetype off

set rtp+=~/.vim/bundle/neobundle.vim/
call neobundle#rc(expand('~/.vim/bundle/'))

""" for develop
NeoBundle 'vim-jp/vital.vim'
NeoBundle 'kana/vim-submode'
if (has('lua'))
    NeoBundle 'Shougo/neocomplete'
else
    NeoBundle 'Shougo/neocomplcache'
endif
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
"NeoBundle 'Shougo/vimproc'
NeoBundle 'osyo-manga/vital-reunions'
NeoBundle 'Shougo/vimshell'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'mattn/sonictemplate-vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'thinca/vim-openbuf'
NeoBundle 'thinca/vim-quickrun'
if (has('clientserver'))
    NeoBundle 'thinca/vim-singleton'
endif
"""NeoBundle 'rhysd/committia.vim'
NeoBundle 'rhysd/vim-grammarous'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'vim-scripts/Processing'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'artur-shaik/vim-javacomplete2'
NeoBundle 'kamichidu/vim-javaclasspath'
NeoBundle 'kamichidu/vim-unite-javaimport'

""" notification
NeoBundle 'supermomonga/thingspast.vim'
NeoBundle 'supermomonga/Shaberu.vim'

""" for vim setting
NeoBundle 'tyru/restart.vim'

""" for twitter
NeoBundle 'vim-scripts/TwitVim'

""" colorscheme
NeoBundle 'twerth/ir_black'

""" qml
NeoBundle 'peterhoeg/vim-qml'

""" go
NeoBundle 'vim-jp/vim-go-extra'
NeoBundle 'rhysd/vim-go-impl'

""" html
NeoBundle 'mattn/emmet-vim'

filetype plugin indent on
