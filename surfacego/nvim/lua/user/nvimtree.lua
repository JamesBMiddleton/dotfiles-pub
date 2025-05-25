local nvim_tree = require "nvim-tree"

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
