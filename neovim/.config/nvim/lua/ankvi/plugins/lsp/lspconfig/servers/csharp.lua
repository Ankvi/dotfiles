local cse_exists, cs_extended = pcall(require, "csharpls_extended")

if not cse_exists then
    print("csharpls_extended doesn't exist")
    return nil
end

local lspc_exists, lspconfig_util = pcall(require, "lspconfig.util")
if not lspc_exists then
    print("lspconfig.util doesn't exist")
    return nil
end

return {
    root_dir = lspconfig_util.root_pattern("*.sln"),
	handlers = {
		["textDocument/definition"] = cs_extended.handler,
	},
}
