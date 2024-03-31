-- lua/ and .lua are implied
vim.cmd("source ".. vim.fn.stdpath('config') .. "/.vimrc")
require "user.options" 
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.lsp" -- will run the init.lua inside lsp dir
require "user.treesitter"
require "user.gitsigns"
require "user.telescope"
require "user.nvim-tree"
require "user.comment"
require "user.keymaps"

