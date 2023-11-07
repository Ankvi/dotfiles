local M = {}

M.configs = {
	arduino_language_server = require("ankvi.plugins.lsp.lspconfig.servers.arduino"),
    bashls = {},
	clangd = {},
    csharp_ls = require("ankvi.plugins.lsp.lspconfig.servers.csharp"),
    cssls = {},
	dockerls = {},
	eslint = {},
	html = {},
	jsonls = require("ankvi.plugins.lsp.lspconfig.servers.json"),
    lemminx = {},
	lua_ls = require("ankvi.plugins.lsp.lspconfig.servers.lua"),
    -- omnisharp = require("ankvi.plugins.lsp.lspconfig.servers.omnisharp"),
    pyright = require("ankvi.plugins.lsp.lspconfig.servers.pyright"),
    tailwindcss = {},
	vimls = {},
	yamlls = require("ankvi.plugins.lsp.lspconfig.servers.yaml"),
}

M.exclude_install = {
}

return M
