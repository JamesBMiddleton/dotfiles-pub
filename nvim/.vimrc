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
set notermguicolors
set nocursorline
syntax on
filetype on 

autocmd InsertEnter,InsertLeave * set cul!

" Not all terminals support termguicolors
" cterm colours could be 8bit, 16bit or 24bit - (see :help cterm)
" the actual colour of a cterm value is dependent on the terminal
" Conclusion - there are no truly portable colorschemes
colorscheme industry
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

" fast scroll
nnoremap J 10<C-e>M
nnoremap K 10<C-y>M
nnoremap <C-e> J

" don't yank text over paste selection in visual mode
xnoremap p P

" xterm cursor change between normal and insert
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

let s:comment_map = { 
    \   "c": '\/\/',
    \   "cpp": '\/\/',
    \   "go": '\/\/',
    \   "java": '\/\/',
    \   "javascript": '\/\/',
    \   "lua": '--',
    \   "scala": '\/\/',
    \   "php": '\/\/',
    \   "python": '#',
    \   "ruby": '#',
    \   "rust": '\/\/',
    \   "sh": '#',
    \   "desktop": '#',
    \   "fstab": '#',
    \   "conf": '#',
    \   "profile": '#',
    \   "bashrc": '#',
    \   "bash_profile": '#',
    \   "mail": '>',
    \   "eml": '>',
    \   "bat": 'REM',
    \   "ahk": ';',
    \   "vim": '"',
    \   "tex": '%',
    \ }

function! ToggleComment()
    if has_key(s:comment_map, &filetype)
        let comment_leader = s:comment_map[&filetype]
        if getline('.') =~ "^\\s*" . comment_leader . " " 
            " Uncomment the line
            execute "silent s/^\\(\\s*\\)" . comment_leader . " /\\1/"
        else 
            if getline('.') =~ "^\\s*" . comment_leader
                " Uncomment the line
                execute "silent s/^\\(\\s*\\)" . comment_leader . "/\\1/"
            else
                " Comment the line
                execute "silent s/^\\(\\s*\\)/\\1" . comment_leader . " /"
            end
        end
    else
        echo "No comment leader found for filetype"
    end
endfunction

nnoremap gcc :call ToggleComment()<cr>
vnoremap gc :call ToggleComment()<cr>
