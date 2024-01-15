local fn = vim.fn

-- Automatically install packer if isn't already
-- stdpath = the default place nvim plugins store their data; ".local/share/nvim"
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- clone the repos of these plugins into the "start" folder of the packer folder.
-- by 'put' I mean literally clone the repo there. this means they'll start when nvim is opened.
return require("packer").startup(function(use)
    use "wbthomason/packer.nvim" -- have packer manage itself
    use "nvim-lua/plenary.nvim" -- lua functions required by some plugins

	use "LunarVim/darkplus.nvim" -- bg = #1e1e1e
    use "cocopon/iceberg.vim" -- bg = #e8e9ec

    use "hrsh7th/nvim-cmp" -- The completion plugin
	use "hrsh7th/cmp-buffer" -- cmp support for buffer completions - do I need it?
	use "hrsh7th/cmp-path" -- cmp support for path completions - do I need it?
	use "hrsh7th/cmp-nvim-lsp" -- to do with nvim-cmp's integration with builtin LSP support
	-- use "hrsh7th/cmp-nvim-lua" -- cmp support for neovim lua API completions -- don't need it??
    
    use "saadparwaiz1/cmp_luasnip" -- cmp required support for snippet completions -- Yuck!
    use "L3MON4D3/LuaSnip" -- a snippet engine -- Yuck!

    use "williamboman/mason.nvim" -- package manager for LSP servers, linters and formatters
    use "williamboman/mason-lspconfig.nvim" -- bridge between mason and lspconfig
    use "neovim/nvim-lspconfig" -- default config for LSP magic 

	use {"nvim-treesitter/nvim-treesitter", run = "TSUpdate"} -- syntax highlighting

	use "lewis6991/gitsigns.nvim" -- git integration

	use "nvim-telescope/telescope.nvim" -- fuzzy buffer, file, text finder

	use "kyazdani42/nvim-tree.lua" -- directory tree

	use "numToStr/Comment.nvim" -- comment support

    -- MKVIM --

    use "jakewvincent/mkdnflow.nvim" -- markdown link support
    -- install without yarn or npm
    use({ "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end,})
    
    --
end)
