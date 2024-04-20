local gitsigns = require "gitsigns"

require('gitsigns').setup{
  on_attach = function(bufnr)

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- next git change
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.next_hunk()
      end
    end)

    -- previous git change
    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.prev_hunk()
      end
    end)

    -- open inline diff
    map('n', 'hc', function()
        gitsigns.preview_hunk_inline()
    end)

  end
}

