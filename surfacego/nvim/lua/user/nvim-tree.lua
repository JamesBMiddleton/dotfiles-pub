local nvim_tree = require "nvim-tree"

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

nvim_tree.setup {
    on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set('n', '}', api.tree.change_root_to_node, opts('CD'))
        vim.keymap.set('n', '{', api.tree.change_root_to_parent, opts('Up'))
    end,
    update_focused_file = {
        enable = true,
        update_cwd = false
    },
    renderer = {
        root_folder_label = false,
        add_trailing = true,
        icons = {
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = true,
            },
            glyphs = {
                git = {
                    unstaged = "M", -- Modified
                    staged = "S",
                    unmerged = "!",
                    renamed = "R",
                    untracked = "U",
                    deleted = "D",
                    ignored = "~",
                },
            },
        },
    },
    view = {
        width = 25,
    },
    git = {
        ignore = false
    }
}

-- open nvim-tree if nvim opened in directory, used to be a simple option...
-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup
local function open_nvim_tree(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    if not directory then
        return
    end
    vim.cmd.cd(data.file)
    require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

--- KEYMAPS ---

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

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


-- OVERRIDE: close all but current buffer
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

-- OVERRIDE: handle nvim-tree edge-case when window splitting
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
