local telescope = require "telescope"
local actions = require "telescope.actions"

telescope.setup{
  defaults = {
    mappings = {
      n = {
        ["<esc>"] = telescope.close,
        ["<C-k>"] = actions.cycle_history_next,
        ["<C-j>"] = actions.cycle_history_prev,
      },
      i = {
        ["<C-k>"] = actions.cycle_history_next,
        ["<C-j>"] = actions.cycle_history_prev,
      },
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

-- view open buffers
keymap("n", "<leader>f", ":Telescope buffers<CR>", opts) -- mnemonic < ease of use

-- view git modified files
keymap("n", "<leader>c", ":Telescope git_status<CR>", opts) 

-- toggle whether finders should look in ignored / hidden files
vim.g.telescope_ignore_toggle = false
vim.api.nvim_create_user_command("ToggleIgnore", function()
    if vim.g.telescope_ignore_toggle == true then
        print("Ignores are now excluded")
    else
        print("Ignores are now included")
    end
    vim.g.telescope_ignore_toggle = not vim.g.telescope_ignore_toggle
end, {}) 

-- grep find text across working directory
keymap("n", "<leader>g", function()
    local fwd_args = {}
    if vim.g.telescope_ignore_toggle == true then
        fwd_args = {"-uuu"}
    end
    require "telescope.builtin".live_grep{
        additional_args = fwd_args
    }
end, opts)

-- open files in working directory
keymap("n", "<leader>o", function()
    require "telescope.builtin".find_files{
        no_ignore=vim.g.telescope_ignore_toggle,
        hidden=vim.g.telescope_ignore_toggle
    }
end, opts)

-- live_grep the provided glob input
vim.api.nvim_create_user_command("Find", function(args)
    local fwd_args = {}
    if vim.g.telescope_ignore_toggle == true then
        fwd_args = {"-uuu"}
    end

    glob = args['args']
    if glob == "" then
        glob = "**/*"
    end
    require "telescope.builtin".live_grep{
        glob_pattern=glob,
        additional_args=fwd_args
    }
end, { nargs='*' })


-- 
-- fix git_status added ./.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/make_entry.lua:1342
--
--   if x == "M" then
--      status_x = git_abbrev["A"]
--   end
--
