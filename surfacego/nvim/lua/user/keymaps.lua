vim.g.mapleader = " "      -- space as leader key
vim.g.maplocalleader = " " -- space as local leader key?

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- stop space moving cursor
keymap("", "<Space>", "<Nop>", opts)

-- remove search highlighting (<cr> = carriage return)
keymap("n", "<Space><Space>", ":set invhls<CR>", opts)

-- lsp or ctags go-to-definition
keymap("n", "gd", "<C-]>zt", opts)

-- smart tab navigate down completion list
keymap("i", "<Tab>", "v:lua.smart_tab()", { expr = true, noremap = true })
function _G.smart_tab()
    if vim.fn.pumvisible() == 1 then return "<C-N>" else return "\t" end
end

-- smart tab navigate up completion list
keymap("i", "<S-Tab>", "v:lua.smart_shift_tab()", { expr = true, noremap = true })
function _G.smart_shift_tab()
    if vim.fn.pumvisible() == 1 then return "<C-P>" else return "\t" end
end

-- smart tab show completions if available
vim.api.nvim_create_autocmd("InsertCharPre", {
    pattern = "*.c, *.lua",
    callback = function()
        if vim.fn.pumvisible() == 0 and vim.fn.getline("."):sub(vim.fn.col(".") - 1):match("%w") then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-X><C-O>", true, false, true), "n")
        end
    end
})

-- better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- stay in visual mode when indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- don't include newline when going to end of line in visual mode
keymap("v", "$", "$h", opts)

-- don't yank text over paste selection in visual mode
keymap("v", "p", "P", opts)

-- fast scroll, don't add to jumplist (Ctrl+I/O) in normal mode
vim.cmd([[nnoremap <silent> J :<C-u>execute "keepjumps normal! 10<C-v><C-e>M"<CR>]])
vim.cmd([[nnoremap <silent> K :<C-u>execute "keepjumps normal! 10<C-v><C-y>M"<CR>]])
keymap("v", "J", "10<C-e>M", opts)
keymap("v", "K", "10<C-y>M", opts)
keymap("n", "<C-e>", "J", opts)
keymap("v", "<C-e>", "J", opts)

-- close all but current buffer
vim.api.nvim_create_user_command("Bda", function()
    local ok, result = pcall(vim.cmd, '%bd|e#|bd#')
    if not ok then
        vim.cmd([[echo "E88: No write since last change for buffer (add ! to override)"]])
    end
end, {})

-- move open buffer to right/left/upper/lower window
-- open a window if one doesn't exist
vim.cmd([[map <C-w><C-w> <Nop>]])
keymap("n", "<C-w><C-l>", function()
    curr = vim.api.nvim_get_current_win()
    vim.cmd([[wincmd l]])
    new = vim.api.nvim_get_current_win()
    if curr == new then
        vim.cmd([[vsplit | wincmd h | b# | wincmd l ]])
    else
        vim.cmd([[wincmd h]])
        name = vim.api.nvim_buf_get_name(0)
        vim.cmd([[b# | wincmd l]])
        vim.cmd([[b ]] .. name)
    end
end, opts)

keymap("n", "<C-w><C-j>", function()
    curr = vim.api.nvim_get_current_win()
    vim.cmd([[wincmd j]])
    new = vim.api.nvim_get_current_win()
    if curr == new then
        vim.cmd([[split | wincmd k | b# | wincmd j ]])
    else
        vim.cmd([[wincmd k]])
        name = vim.api.nvim_buf_get_name(0)
        vim.cmd([[b# | wincmd j]])
        vim.cmd([[b ]] .. name)
    end
end, opts)

keymap("n", "<C-w><C-k>", function()
    curr = vim.api.nvim_get_current_win()
    vim.cmd([[wincmd k]])
    new = vim.api.nvim_get_current_win()
    if curr == new then
        vim.cmd([[split | wincmd j | b# | wincmd k ]])
    else
        vim.cmd([[wincmd j]])
        name = vim.api.nvim_buf_get_name(0)
        vim.cmd([[b# | wincmd k]])
        vim.cmd([[b ]] .. name)
    end
end, opts)

keymap("n", "<C-w><C-h>", function()
    local curr = vim.api.nvim_get_current_win()
    vim.cmd([[wincmd h]])
    local new = vim.api.nvim_get_current_win()
    local name = vim.api.nvim_buf_get_name(0)
    if curr == new then
        vim.cmd([[vsplit | b# | wincmd h ]])
    else
        vim.cmd([[wincmd l]])
        name = vim.api.nvim_buf_get_name(0)
        vim.cmd([[b# | wincmd h]])
        vim.cmd([[b ]] .. name)
    end
end, opts)
