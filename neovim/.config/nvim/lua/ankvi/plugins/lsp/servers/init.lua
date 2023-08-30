local M = {}

M.configs = {
	arduino_language_server = require("ankvi.plugins.lsp.servers.arduino").options,
	clangd = {},
	dockerls = {},
	tsserver = {},
	omnisharp = require("ankvi.plugins.lsp.servers.omnisharp").options,
	eslint = {},
	html = {},
	jsonls = require("ankvi.plugins.lsp.servers.json").options,
	lua_ls = require("ankvi.plugins.lsp.servers.lua").options,
	pylsp = {},
	vimls = {},
	yamlls = require("ankvi.plugins.lsp.servers.yaml").options,
}

M.exclude_install = {
    "omnisharp"
}

return M
