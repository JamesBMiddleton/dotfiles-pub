local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gw", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts) -- ?
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[g", '<cmd>lua vim.diagnostic.goto_prev({ })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]g", '<cmd>lua vim.diagnostic.goto_next({ })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", '<cmd>lua vim.diagnostic.open_float({ })<CR>', opts)
end

vim.diagnostic.config({
    update_in_insert = true,
    float = {
        header = "",
        prefix = ""
    }
})

require("lspconfig").clangd.setup({
    on_attach = on_attach,
})

require("lspconfig").lua_ls.setup({
    on_attach = on_attach,
})
