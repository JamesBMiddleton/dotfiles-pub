vim.opt.wrap = true
vim.opt.colorcolumn = ""
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.background = 'light'
vim.opt.number = false




-- refresh the file every 4 seconds if cursor isn't moving, to keep in
-- sync with mobile
vim.cmd([[set autoread | au CursorHold * checktime | call feedkeys("lh")]])

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


-- auto-save 
vim.api.nvim_create_autocmd({"TextChanged", 
                            "TextChangedI", 
                            "TextChangedT"},
                            {command = "silent wa"})

local keymap = vim.keymap.set
local opts = {noremap = true, silent = true}


-- unique note creation
keymap("n", "<C-n>", function()
    name = vim.fn.input("filename: ")
    if name == "" then
        name = "daily"
    end
    local date = vim.fn.system("date +'%Y%m%d%H%M'")
    file = name .. " " .. date:sub(0,-2) .. ".md"
    vim.cmd("silent !touch " .. "'" .. file .. "'")
    template = '***\\ntags:\\nstatus: \\#atomic\\n***\\n'
    vim.cmd("silent !printf " .. "'" .. template .. "' >> " .. "'" .. file .. "'") 
    vim.cmd("e " .. file)

end, opts)

keymap("n", "j", "gj", opts) -- visual line navigation
keymap("n", "k", "gk", opts)


keymap("i", "[[", function() 
    -- vim.cmd([[ let g:cmp_toggle = v:true ]])
    local pos = vim.api.nvim_win_get_cursor(0)
    local line = vim.api.nvim_get_current_line()
    local nline = line:sub(0, pos[2]) .. '[[./' .. line:sub(pos[2] + 1)
    vim.api.nvim_set_current_line(nline)
    pos[2] = pos[2]+4
    vim.api.nvim_win_set_cursor(0, pos)
end, opts)

keymap("i", "]]", function() 
    -- vim.cmd([[ let g:cmp_toggle = v:false ]])
    local pos = vim.api.nvim_win_get_cursor(0)
    local line = vim.api.nvim_get_current_line()
    local nline = line:sub(0, pos[2]) .. ']]' .. line:sub(pos[2] + 1)
    vim.api.nvim_set_current_line(nline)
    pos[2] = pos[2]+2
    ok, result = pcall(vim.cmd, [[s/\[\[\.\//[[/]])
    vim.api.nvim_win_set_cursor(0, pos)
end, opts)

