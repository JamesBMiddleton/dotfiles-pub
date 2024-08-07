vim.cmd "colorscheme darkplus"

vim.cmd "hi statusline guibg=#252525 guifg=#FFFFFF"
vim.cmd "hi tablinefill guibg=#252525 guifg=#FFFFFF"

vim.api.nvim_set_hl(0, 'NormalFloat', {bg='#404040'}) -- LSP float menus
vim.api.nvim_set_hl(0, 'Pmenu', {bg='#404040'}) -- cmp autocompletion
vim.api.nvim_set_hl(0, 'PmenuSel', {bg='#606060'}) -- cmp autocompletion

-- use ':Inspect' to find highlight group of text under cursor
-- use ':Telescope highlights' to view all highlight groups
