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
set clipboard=unnamedplus " use tmux clipboard
set background=dark
set nowrap
set hlsearch
set updatetime=300 " faster completion?
set ttimeout
set ttimeoutlen=1
set ttyfast
set showmode
set backspace=2
set notermguicolors
set nocursorline
set guicursor=n:ver25-2,i:block-2,v:ver25-2 " reversed for tmux + linux TTY
syntax on
filetype on 

autocmd InsertEnter,InsertLeave * set cul!

colorscheme default
hi Visual guifg=black guibg=yellow
hi CursorLine cterm=underline ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
hi LineNr cterm=NONE guifg=#808080 guibg=NONE ctermfg=White ctermbg=NONE
hi CursorLineNr cterm=NONE term=NONE gui=NONE guifg=NONE ctermfg=NONE

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

" fast scroll, don't add to jumplist (Ctrl+I/O)
nnoremap <silent> J :<C-u>execute "keepjumps normal! 10<C-v><C-e>M"<CR>
nnoremap <silent> K :<C-u>execute "keepjumps normal! 10<C-v><C-y>M"<CR>
" @todo fast scroll in visual mode without adding to jumplist
vnoremap J 10<C-e>M
vnoremap K 10<C-y>M
nnoremap <C-e> J
vnoremap <C-e> J

" don't yank text over paste selection in visual mode
xnoremap p P
