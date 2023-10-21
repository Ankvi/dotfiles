local M = {}

M.configs = {
	arduino_language_server = require("ankvi.plugins.lsp.lspconfig.servers.arduino").options,
    bashls = {},
	clangd = {},
	dockerls = {},
	-- tsserver = require("ankvi.plugins.lsp.lspconfig.servers.tsserver").options,
	omnisharp = require("ankvi.plugins.lsp.lspconfig.servers.omnisharp").options,
	eslint = {},
	html = {},
	jsonls = require("ankvi.plugins.lsp.lspconfig.servers.json").options,
	lua_ls = require("ankvi.plugins.lsp.lspconfig.servers.lua").options,
	-- p.lsp.lspconfig = {},
    pyright = require("ankvi.plugins.lsp.lspconfig.servers.pyright").options,
	vimls = {},
	yamlls = require("ankvi.plugins.lsp.lspconfig.servers.yaml").options,
}

M.exclude_install = {
    "omnisharp"
}

return M
