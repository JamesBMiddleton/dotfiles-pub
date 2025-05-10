local fn = vim.fn

-- Automatically install packer if isn't already
-- stdpath = the default place nvim plugins store their data; ".local/share/nvim"
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim", install_path })
    fn.system({ "git", "-C", install_path, "checkout", "ea0cc3c59f67c440c5ff0bbe4fb9420f4350b9a3" })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

return require("packer").startup(function(use)
    -- packer will manage itself
    use { "wbthomason/packer.nvim" }

    -- lua functions required by some plugins
    use { "nvim-lua/plenary.nvim" }

    -- git integration
    use { "lewis6991/gitsigns.nvim" }

    -- fuzzy buffer, file, text finder
    use { "nvim-telescope/telescope.nvim" }

    -- directory tree
    use { "kyazdani42/nvim-tree.lua" }

    -- easier lsp language server setup
    use { "neovim/nvim-lspconfig" }
end)
