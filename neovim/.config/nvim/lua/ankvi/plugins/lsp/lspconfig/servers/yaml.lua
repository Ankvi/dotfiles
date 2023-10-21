local M = {}

local schemastore = require("schemastore")

M.options = {
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = schemastore.yaml.schemas(),
		},
	},
}

return M
