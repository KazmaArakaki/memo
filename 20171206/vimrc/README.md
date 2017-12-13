``` vim
filetype plugin on
filetype indent on

set clipboard+=unnamed
set colorcolumn=120
set cursorcolumn
set cursorline
set encoding=utf8
set expandtab
set nowrap
set number
set shiftwidth=2
set softtabstop=2
set tabstop=4
set wildmenu

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <C-w>h :vsplit<CR>
nnoremap <C-w>j :split<CR> <C-w>j
nnoremap <C-w>k :split<CR>
nnoremap <C-w>l :vsplit<CR> <C-w>l

nnoremap / /\v

autocmd QuickFixCmdPost *grep* cwindow

" ==========
" NeoBundle Setting
" ==========

set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'mattn/emmet-vim'

call neobundle#end()
NeoBundleCheck

" ==========

syntax on
color dracula
```
