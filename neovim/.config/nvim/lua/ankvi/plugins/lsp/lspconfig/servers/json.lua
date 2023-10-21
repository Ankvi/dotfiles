local M = {}

local schemastore = require("schemastore")

M.options = {
	settings = {
		json = {
			schemas = schemastore.json.schemas(),
			validate = {
				enable = true,
			},
		},
	},
}

return M
