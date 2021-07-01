filetype off

" let vundle manage vundle- https://github.com/junegunn/vim-plug
" set rtp+=~/.vim/bundle/Vundle.vim/
call plug#begin('~/.vim/plugged')

Plug 'honza/vim-snippets'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'ryanoasis/vim-devicons'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'benmills/vimux'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale' " replace syntastic
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'garbas/vim-snipmate'
Plug 'editorconfig/editorconfig-vim'
Plug 'tomtom/tlib_vim'
Plug 'sotte/presenting.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-vinegar'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'vim-scripts/matchit.zip'
" Plug 'sickill/vim-pasta' " context-aware pasting
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } " distraction-free writing
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' } " focus tool. Good for presentating with vim
Plug 'jiangmiao/auto-pairs'

" language-specific plugins
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'gregsexton/MatchTag', { 'for': 'html' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'moll/vim-node', { 'for': 'javascript' }
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'wavded/vim-stylus', { 'for': ['stylus', 'markdown'] }
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'ap/vim-css-color', { 'for': 'css' }
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
Plug 'itspriddle/vim-marked', { 'for': 'markdown', 'on': 'MarkedOpen' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'timcharper/textile.vim', { 'for': 'textile' }
Plug 'davidhalter/jedi-vim', { 'for': 'python'}
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer'}
Plug 'majutsushi/tagbar'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'nvie/vim-flake8', {'for': 'python'} "pep8 style checker
Plug 'kshenoy/vim-signature'
Plug 'sainnhe/artify.vim'
"
" Colors schemes
Plug 'morhetz/gruvbox'
Plug 'rishikanthc/skyfall-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'arcticicestudio/nord-vim'
Plug 'sainnhe/gruvbox-material'
Plug 'ghifarit53/tokyonight-vim'
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }

"Plug 'ehamberg/vim-cute-python' "math symbols for python

call plug#end()
filetype plugin indent on
