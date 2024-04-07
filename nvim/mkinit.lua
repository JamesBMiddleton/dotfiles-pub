-- lua/ and .lua are implied
vim.cmd('source ~/.config/nvim/.vimrc')
require "user.options" 
require "user.plugins"
require "user.keymaps"
require "user.cmp"
require "user.treesitter"
require "user.telescope"
require "user.mkvim" -- will run the init.lua inside mkvim dir

