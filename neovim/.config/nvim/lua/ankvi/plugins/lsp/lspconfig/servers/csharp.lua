-- local loaded, cs_extended = pcall(require, "csharpls_extended")
--
-- if not loaded then
--     print("csharpls_extended doesn't exist")
--     return nil
-- end

return {
    root_dir = require("lspconfig.util").root_pattern("*.sln"),
	handlers = {
		["textDocument/definition"] = require("csharpls_extended").handler,
	},
}
