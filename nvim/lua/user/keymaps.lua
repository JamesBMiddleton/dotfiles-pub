-- :help keymap

vim.g.mapleader = " "  -- space as leader key
vim.g.maplocalleader = " " -- space as local leader key?

local keymap = vim.keymap.set
local opts = {noremap = true, silent = true}

-- stop space moving cursor (idk why "" not "n")
keymap("", "<Space>", "<Nop>", opts)  

-- remove search highlighting (<cr> = carriage return)
-- keymap("n", "<Space><Space>", ":noh<cr>", opts)
keymap("n", "<Space><Space>", ":set invhls<CR>", opts)

-- close all but current buffer
vim.api.nvim_create_user_command("Bda", function()
    local ok, result
    ok, result = pcall(vim.cmd, '%bd|e#|bd#')
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


