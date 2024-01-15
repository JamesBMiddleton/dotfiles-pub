local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason.setup()

mason_lspconfig.setup
{
    ensure_installed = { "clangd", "pyright", "rust_analyzer"},
}

local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
}

lspconfig.pyright.setup(opts)
lspconfig.clangd.setup(opts)
lspconfig.rust_analyzer.setup(opts)

