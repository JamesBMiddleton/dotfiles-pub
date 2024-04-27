local gitsigns = require "gitsigns"

require('gitsigns').setup{
  on_attach = function(bufnr)
  end
}

--- KEYMAPS ---
local keymap = vim.keymap.set
local opts = {noremap = true, silent = true}

-- next git change
keymap('n', ']c', function()
  if vim.wo.diff then
    vim.cmd.normal({']c', bang = true})
  else
    gitsigns.next_hunk()
  end
end, opts)

-- previous git change
keymap('n', '[c', function()
  if vim.wo.diff then
    vim.cmd.normal({'[c', bang = true})
  else
    gitsigns.prev_hunk()
    vim.cmd([[ execute "normal zt" ]]) 
  end
end, opts)

-- open inline diff
keymap('n', 'hc', function()
    gitsigns.preview_hunk_inline()
    vim.cmd([[ execute "normal zt" ]]) 
end, opts)

