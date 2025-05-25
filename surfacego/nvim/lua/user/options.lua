local set = vim.opt
set.number = true             -- number column
set.splitbelow = true         -- split windows the way you'd expect
set.splitright = true         -- split windows the way you'd expect
set.scrolloff = 4             -- stop 4 lines before bottom and top
set.incsearch = true          -- start searching while typing
set.ignorecase = true         -- case sensitive only when you use an uppercase
set.smartcase = true          -- ^
set.expandtab = true          -- tab becomes spaces
set.tabstop = 4               -- num spaces in a tab
set.softtabstop = 4           -- ^
set.autoindent = true         -- autoindent code
set.shiftwidth = 4            -- autoindent num spaces
set.smartindent = true        -- use code to inform autoindent
set.clipboard = "unnamedplus" -- use tmux clipboard
set.background = "dark"
set.wrap = false
set.hlsearch = true
set.updatetime = 300 -- faster completion?
set.ttimeout = true
set.ttimeoutlen = 1
set.ttyfast = true
set.backspace = "2"
set.guicursor = "n:ver25-2,i:block-2,v:ver25-2" -- reversed for tmux + linux TTY
set.syntax = "on"
set.filetype = "on"
set.autowrite = true                                -- autosave when quitting / changing buffers
set.undofile = true                                 -- save undo history between sessions
set.termguicolors = false                           -- Linux TTY doesn't support
set.showmode = false                                -- remove --INSERT-- etc...
set.signcolumn = "yes"                              -- always show the lefthand column with lsp diagnostics etc..
set.cursorline = false                              -- highlights the line your cursor is currently on
set.laststatus = 0                                  -- status line is OFF
set.showtabline = 2
set.tabline = " %=--- %{expand('%:~:.')} --- %m%= " -- only show relative path and save status in center
set.rulerformat = " %=%l,%c%V  %P"                  -- don't show Top/Bottom, only col and line number
set.titlestring = "%t %m"
set.title = true
set.completeopt = "menu,menuone,noselect,noinsert"

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
    end
})

