local fn = vim.fn

-- Automatically install packer if isn't already
-- stdpath = the default place nvim plugins store their data; ".local/share/nvim"
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "--depth", "1", 
                "https://github.com/wbthomason/packer.nvim", install_path})
    fn.system({ "git", "-C", install_path, "checkout", "ea0cc3c59f67c440c5ff0bbe4fb9420f4350b9a3" })
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- clone the repos of these plugins into the "start" folder of the packer folder.
-- by 'put' I mean literally clone the repo there. this means they'll start when nvim is opened.
return require("packer").startup(function(use)

    -- default config for LSP magic 
    use "neovim/nvim-lspconfig" 

    -- package manager
    use {"wbthomason/packer.nvim", commit="ea0cc3c59f67c440c5ff0bbe4fb9420f4350b9a3"}

    -- lua functions required by some plugins
    use {"nvim-lua/plenary.nvim", commit="8aad4396840be7fc42896e3011751b7609ca4119"}

    -- bg = #1e1e1e
	use {"JamesBMiddleton/darkplus.nvim"} 

    -- The completion plugin
    use {"hrsh7th/nvim-cmp", commit="97dc716fc914c46577a4f254035ebef1aa72558a"}

    -- cmp support for buffer completions 
	use {"hrsh7th/cmp-buffer", commit="3022dbc9166796b644a841a02de8dd1cc1d311fa"}

    -- cmp support for path completions 
	use {"hrsh7th/cmp-path", commit="91ff86cd9c29299a64f968ebb45846c485725f23"}

    -- to do with nvim-cmp's integration with builtin LSP support
	use {"hrsh7th/cmp-nvim-lsp", commit="5af77f54de1b16c34b23cba810150689a3a90312"}
    
    -- cmp required support for snippet completions -- Yuck!
    use {"saadparwaiz1/cmp_luasnip", commit="05a9ab28b53f71d1aece421ef32fee2cb857a843"}

    -- a snippet engine -- Yuck!
    use {"L3MON4D3/LuaSnip", commit="a7a4b4682c4b3e2ba82b82a4e6e5f5a0e79dec32"}

    -- package manager for LSP servers, linters and formatters
    use {"williamboman/mason.nvim", commit="751b1fcbf3d3b783fcf8d48865264a9bcd8f9b10"}

    -- bridge between mason and lspconfig
    use {"williamboman/mason-lspconfig.nvim", commit="2ba17cecfde8b8c7c7c287909a1e4de895223df6"}

    -- syntax highlighting
	use {"nvim-treesitter/nvim-treesitter", run = "TSUpdate", commit="f84887230af1f7581e29ccd5d93f59d98058d565"} 

    -- git integration
	use {"lewis6991/gitsigns.nvim", commit="3e6e91b09f0468c32d3b96dcacf4b947f037ce25"}

    -- fuzzy buffer, file, text finder
	use {"nvim-telescope/telescope.nvim", commit="c2b8311dfacd08b3056b8f0249025d633a4e71a8"} 

    -- directory tree
	use {"kyazdani42/nvim-tree.lua", commit="e508bdc4184c33c6d9705c503cf7f0e029601788"} 

    -- comment support
	use {"numToStr/Comment.nvim", commit="0236521ea582747b58869cb72f70ccfa967d2e89"} 

    ------------ MKVIM --------------
    
    -- bg = #e8e9ec
    use {"cocopon/iceberg.vim", commit="e01ac08c2202e7544531f4d806f6893539da6471"}  

    -- markdown link support
    use "jakewvincent/mkdnflow.nvim, commit="ea0cc3c59f67c440c5ff0bbe4fb9420f4350b9a3"}

    -- web browser based previewing (install without yarn or npm)
    use({ "iamcco/markdown-preview.nvim", commit="iamcco/markdown-preview.nvim"}
        run = function() vim.fn["mkdp#util#install"]() end,})
    
end)
