local cmp = require "cmp"
local luasnip = require "luasnip"

cmp.setup {
  enabled = function()
    return vim.g.cmp_toggle
  end,
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm(),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback() -- "use tab normally"
      end
    end, {
      "i", -- insert mode 
      "s", -- select mode
    }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, {
      "i", 
      "s",
    }),
  },
  sources = {
    { name = "nvim_lsp" },
  },
}

cmp.setup.filetype({ 'markdown', 'md'}, {
  enabled = function()
    return vim.g.cmp_toggle
  end,
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm(),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback() -- "use tab normally"
      end
    end, {
      "i", -- insert mode 
      "s", -- select mode
    }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, {
      "i", 
      "s",
    }),
  },
  sources = {
    { name = "path" },
  },
})

vim.g.cmp_toggle = true
