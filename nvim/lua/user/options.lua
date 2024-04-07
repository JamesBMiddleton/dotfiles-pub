-- :help options

local set = vim.opt

set.hlsearch = false
set.syntax = on;
set.autowrite = true -- autosave when quitting / changing buffers
set.undofile = true -- save undo history between sessions
set.termguicolors = true -- use the terminal's color palette rather than nvim's
set.showmode = false -- remove --INSERT-- etc...
set.signcolumn = "yes" -- always show the lefthand column with lsp diagnostics etc..
set.cursorline = true -- highlights the line your cursor is currently on
-- set.statusline = "--- %t --- %m"
set.laststatus = 0 -- status line is OFF
set.showtabline = 2 
set.tabline = " %=--- %{expand('%:~:.')} --- %m%= " -- only show relative path and save status in center  
set.rulerformat =" %=%l,%c%V  %P" -- don't show Top/Bottom, only col and line number
set.colorcolumn = "74"
set.titlestring = "%t %m"
set.title = true
