local M = {}

M.setup = function()
	local config = {
		virtual_text = false,
		update_in_insert = true,
		underline = true,
		float = {
			focusable = false,
			-- style = "minimal",
			-- border = "rounded",
			-- source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config) -- apply the options above
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	-- g-something for LSP stuff, change to leader if used often.
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts) 
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gk", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[g", '<cmd>lua vim.diagnostic.goto_prev({ })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float({ })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]g", '<cmd>lua vim.diagnostic.goto_next({ })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts) -- ?
  	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gm', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gy', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts) -- ?
  	vim.api.nvim_buf_set_keymap(bufnr, "n", "gw", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts) -- ?
end

M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
cmp_nvim_lsp = require "cmp_nvim_lsp"
M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M

