local configs = require "nvim-treesitter.configs"

configs.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = false, disable = {"python"}},  -- doesn't work well with Python or C++
                                                       -- may be conflicting with nvim autoindent

}
