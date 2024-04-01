local mason = require("mason")
local lspconfig = require("lspconfig")

-- get Node dependency
local node_path = vim.fn.stdpath("data") .. "/mason/packages/node/"
local bin_path = vim.fn.stdpath("data") .. "/mason/bin"
local node_version = "node-v20.12.0-linux-x64"
local node_download = "https://nodejs.org/dist/v20.12.0/"..node_version..".tar.xz"
if vim.fn.empty(vim.fn.glob(node_path)) > 0 then
    print("Downloading "..node_version.." dependency...")
    vim.fn.system({ "mkdir", "-p", node_path })
    vim.fn.system({ "wget", "-P", node_path, node_download })
    vim.fn.system({ "tar", "-xf", node_path..node_version..".tar.xz", "-C", node_path})
    vim.fn.system({ "rm", node_path..node_version..".tar.xz" })
end

-- add Node dependency to $PATH
local current_path = vim.fn.getenv("PATH")
local new_path = node_path..node_version.."/bin:"..current_path
vim.fn.setenv("PATH", new_path)

mason.setup()

-- MasonInstall shellcheck@v0.10.0 clangd@17.0.3 pyright@1.1.356 bash-language-server@5.1.2 rust-analyzer@2024-04-01

local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
}

-- see .local/share/nvim/site/pack/packer/start/nvim-lspconfig/doc/server_configurations.md
lspconfig.pyright.setup(opts)
lspconfig.clangd.setup(opts)
lspconfig.rust_analyzer.setup(opts)
lspconfig.bashls.setup(opts) 


