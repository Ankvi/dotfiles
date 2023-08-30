local M = {}

M.options = {
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			client.config.settings = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				telemetry = { enable = false },
				runtime = {
					version = "LuaJIT",
					-- path = runtime_path,
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					checkThirdParty = false,
					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.stdpath("config") .. "/lua",
					},
				},
				completion = {
					callSnippet = "Replace",
				},
			})

			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end
		return true
	end,
}

return M
