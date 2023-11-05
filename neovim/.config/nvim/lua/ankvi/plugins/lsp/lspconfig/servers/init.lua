local M = {}

M.configs = {
	arduino_language_server = require("ankvi.plugins.lsp.lspconfig.servers.arduino").options,
    bashls = {},
	clangd = {},
    cssls = {},
	dockerls = {},
	eslint = {},
	html = {},
	jsonls = require("ankvi.plugins.lsp.lspconfig.servers.json").options,
	lua_ls = require("ankvi.plugins.lsp.lspconfig.servers.lua").options,
    omnisharp = require("ankvi.plugins.lsp.lspconfig.servers.omnisharp").options,
    pyright = require("ankvi.plugins.lsp.lspconfig.servers.pyright").options,
    tailwindcss = {},
	vimls = {},
	yamlls = require("ankvi.plugins.lsp.lspconfig.servers.yaml").options,
}

M.exclude_install = {
}

return M
