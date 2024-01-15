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

-- grep find text across working directory
keymap("n", "<leader>g", ":Telescope live_grep<CR>", opts)

-- open files in working directory
keymap("n", "<leader>o", ":Telescope find_files<CR>", opts)

-- view open buffers
keymap("n", "<leader>f", ":Telescope buffers<CR>", opts) -- mnemonic < ease of use

-- don't include newline when going to end of line in visual mode
keymap("v", "$", "$h", opts) -- mnemonic < ease of use

-- hacky way to prevent focusing on nvim-tree on buffer close...
vim.cmd([[cmap bd Bd]])
vim.api.nvim_create_user_command("Bd", function()
    local ok, result 
    if require "nvim-tree.view".is_visible() then
        local api = require "nvim-tree.api"
        api.tree.close()
        ok, result = pcall(vim.cmd, 'bd')
        api.tree.toggle(false, true)
    else
        ok, result = pcall(vim.cmd, 'bd')
    end
    if not ok then
        vim.cmd([[echo "E88: No write since last change for buffer (add ! to override)"]])
    end
end, {}) 

vim.cmd([[cmap bd! Bdforce]])
vim.api.nvim_create_user_command("Bdforce", function()
    if require "nvim-tree.view".is_visible() then
        local api = require "nvim-tree.api"
        api.tree.close()
        vim.cmd([[bd!]])
        api.tree.toggle(false, true)
    else
        vim.cmd([[bd!]])
    end
end, {}) 

-- toggle nvim-tree focus
keymap("n", "<leader>e", function()
    local api = require "nvim-tree.api"
    if vim.fn.expand("%") == "NvimTree_1" then
        api.tree.close()
        api.tree.toggle(false, true)
    else
        api.tree.open()
    end
end, opts)

-- toggle nvim-tree
keymap("n", "<leader>E", ":NvimTreeToggle<CR>", opts)

-- close all but current buffer
vim.api.nvim_create_user_command("Bda", function()
    local ok, result
    if require "nvim-tree.view".is_visible() then
        local api = require "nvim-tree.api"
        api.tree.close()
        ok, result = pcall(vim.cmd, '%bd|e#|bd#')
        api.tree.toggle(false, true)
    else
        ok, result = pcall(vim.cmd, '%bd|e#|bd#')
    end
    if not ok then
        vim.cmd([[echo "E88: No write since last change for buffer (add ! to override)"]])
    end
end, {}) 


-- search for highlighted text
vim.cmd([[vnoremap / y/\V<C-R>=escape(@",'/\')<CR><CR>]])
vim.cmd([[vnoremap ? y?\V<C-R>=escape(@",'/\')<CR><CR>]])

-- use { } to move between function definitions regardless of indentation
-- C++ constructors not captured - how to differentiate 'Car() {}' from 'if() {}'?
function get_pattern(direction)
    local pattern = "^\\s*$"
    if vim.bo.filetype == "c" or vim.bo.filetype == "cpp" then
        pattern = "\\(^\\s*\\(\\S\\+\\s\\+\\)\\+\\S\\+(.*)\\s*\\n*\\s*{\\)"
    elseif vim.bo.filetype == "python" then
        pattern = "\\(^\\s*def\\s*\\S\\+\\s*(.*)\\s*:\\)"
    elseif vim.bo.filetype == "rust" then
        pattern = "\\(^.*fn\\s*\\S\\+\\s*(.*)\\)"
    end
    local search = direction .. pattern
    vim.cmd(search)
    vim.cmd([[ execute "normal zt" ]]) -- this took way too long to work out...
end

keymap("n", "}", function() get_pattern("/") end, opts)
keymap("n", "{", function() get_pattern("?") end, opts)


-- move open buffer to right/left/upper/lower window
-- open a window if one doesn't exist
-- handle the nvim-tree edge case
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
    local tree_open = require "nvim-tree.view".is_visible()
    if tree_open then
        require "nvim-tree.api".tree.close()
    end
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
    if tree_open then
        require "nvim-tree.api".tree.toggle(false, true)
    end
end, opts)





