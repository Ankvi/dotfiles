local ok, schemastore = pcall(require, "schemastore")

if not ok then
    print("Plugin 'schemastore' could not be found")
    return nil
end

local M = {
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
