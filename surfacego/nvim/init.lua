-- lua/ and .lua are implied
vim.cmd("source ".. vim.fn.stdpath('config') .. "/.vimrc")
require "user.options" 
require "user.plugins"
require "user.keymaps"
require "user.gitsigns"
require "user.telescope"
require "user.nvim-tree"
require "user.lsp"

