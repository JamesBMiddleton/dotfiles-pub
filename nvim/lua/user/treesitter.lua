local configs = require "nvim-treesitter.configs"

configs.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    textobjects = {
        move = {
            enable = true,
            set_jumps = true, -- Set jumps in the jumplist
            goto_next_start = {
                ["}"] = "@function.outer",
            },
            goto_previous_start = {
                ["{"] = "@function.outer",
            },
        },
    },
    indent = { enable = false, disable = {"python"}},  -- doesn't work well with Python or C++
                                                       -- may be conflicting with nvim autoindent
}
