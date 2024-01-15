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
        previewer = false,
        results_title = false,
        -- no_ignore = false, -- true for .gitignore (broken for some reason)
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
    }
  },
  extensions = {
  }
}

vim.cmd([[autocmd User TelescopePreviewerLoaded setlocal wrap]])
