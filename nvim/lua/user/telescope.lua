local telescope = require "telescope"
local actions = require "telescope.actions"

telescope.setup{
  defaults = {
    mappings = {
      n = {
        ["<esc>"] = telescope.close,
      }
    }
  },
  pickers = {
    find_files = {
        theme = "ivy",
        hidden = false,
        previewer = false,
        results_title = false,
        no_ignore = false, -- true to .gitignore (broken for some reason)
        layout_config = {
            height = 10
        },
    },
    buffers = {
        theme = "ivy",
        previewer = false,
        results_title = false,
        layout_config = {
            height = 10
        },
        initial_mode = "normal",
        sort_lastused = true,
        path_display = {"tail"}, -- show filename, only show path if two files of same name - potential performance hit!
        ignore_current_buffer = true,
    },
    live_grep = {
        theme = "ivy",
        previewer = true,
        results_title = false,
        no_ignore = false,
        layout_config = {
            height = 22
        },
    },
    git_status = {
        theme = "ivy",
        previewer = false,
        initial_mode = "normal",
        results_title = false,
        layout_config = {
            height = 10
        },
        git_icons = {
          added = "S", -- Staged
          changed = "M", -- Modified
          copied = "C",
          deleted = "D",
          renamed = "R",
          unmerged = "!",
          untracked = "U",
        }
    }
  },
  extensions = {
  }
}

vim.cmd([[autocmd User TelescopePreviewerLoaded setlocal wrap]])


--- KEYMAPS ---

local keymap = vim.keymap.set
local opts = {noremap = true, silent = true}

-- grep find text across working directory
keymap("n", "<leader>g", ":Telescope live_grep<CR>", opts)

-- open files in working directory
keymap("n", "<leader>o", ":Telescope find_files<CR>", opts)

-- view open buffers
keymap("n", "<leader>f", ":Telescope buffers<CR>", opts) -- mnemonic < ease of use

-- view git modified files
keymap("n", "<leader>c", ":Telescope git_status<CR>", opts) 

-- find files ignored by git
vim.api.nvim_create_user_command("FindIgnored", function()
    require "telescope.builtin".find_files{no_ignore=true, hidden=true}
end, {}) 


