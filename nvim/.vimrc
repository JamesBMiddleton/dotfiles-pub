set number " numbers
set splitbelow " split window the way you'd expect
set splitright " split window the way you'd expect
set scrolloff=4 " stop 4 lines before bottom and top
set incsearch " start searching while typing
set ignorecase " case sensitive only when you use an uppercase
set smartcase " ^
set expandtab " tab becomes spaces
set tabstop=4 "  num spaces in a tab
set softtabstop=4 " idk
set autoindent " autoindent code
set shiftwidth=4 " autoindent num spaces
set smartindent " use code to inform autoindent
set mouse=nvi " normal, visual, insert mode enable mouse 
set clipboard=unnamedplus " use the system clipboard - requires 'xclip' 
set background=dark
set nowrap
set nohlsearch
set updatetime=300 " faster completion?
set ttimeout
set ttimeoutlen=1
set ttyfast
set showmode
set backspace=2
colorscheme slate
syntax on 
filetype on 

" better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" stay in visual mode when indenting
vnoremap < <gv 
vnoremap > >gv

" don't include newline when going to end of line in visual mode
vnoremap $ $h

" fast scroll
nnoremap J 10<C-e>M
nnoremap K 10<C-y>M
nnoremap <C-e> J

" don't yank text over paste selection in visual mode
xnoremap p P

" xterm cursor change between normal and insert
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
