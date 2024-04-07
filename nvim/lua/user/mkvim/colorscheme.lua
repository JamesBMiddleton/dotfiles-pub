vim.cmd "colorscheme iceberg"

-- use ':Inspect' to find highlight group of text under cursor
-- use ':Telescope highlights' to browser highlight groups
local hl = vim.api.nvim_set_hl
hl(0, '@text.strong.markdown_inline', { fg = "#000000", bg = 'NONE', bold = true }) -- bold
hl(0, '@punctuation.special.markdown', { fg = "#375a9f", bg = 'NONE', bold = false }) -- ***, - etc...
hl(0, '@text.reference.markdown_inline', { fg = "#375a9f", bg = 'NONE', bold = true }) -- link text
hl(0, '@nospell.markdown_inline', { fg = "#375a9f", bg = 'NONE', bold = false}) -- [[link]] 
hl(0,'Special', { fg = "#33374c", bg = 'NONE', bold = false}) -- stuff between two *** *** 
hl(0,'Underlined', { underline = false }) -- stuff between two *** *** ?
hl(0,'String', { fg = "#4c6286", bg = 'NONE', bold = false }) -- inline code
hl(0, '@text.title.markdown', { fg = "#000000", bg = 'NONE', bold = true }) -- # titles
hl(0, '@text.literal.block.markdown', { fg = "#4c6286", bg = 'NONE', bold = false }) -- # code block
hl(0, 'SignColumn', { fg = "#e8e9ec", bg = '#e8e9ec', bold = false }) -- # code block
-- link body?
