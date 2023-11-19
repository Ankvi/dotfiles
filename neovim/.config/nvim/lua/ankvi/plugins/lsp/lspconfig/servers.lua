local get_server_configs = function()
	local lspconfig_util = require("lspconfig.util")
	local schemastore = require("schemastore")

	local configs = {
		arduino_language_server = {
			cmd = {
				"arduino-language-server",
				"-cli-config",
				"$HOME/.arduino15/arduino-cli.yaml",
				"-fqbn",
				"arduino:avr:micro",
			},
		},
		bashls = {},
        biome = {},
		clangd = {},
		csharp_ls = {
			root_dir = lspconfig_util.root_pattern("*.sln"),
			handlers = {
				["textDocument/definition"] = require("csharpls_extended").handler,
			},
		},
		cssls = {},
		dockerls = {},
		eslint = {},
		html = {},
		jsonls = {

			settings = {
				json = {
					schemas = schemastore.json.schemas(),
					validate = {
						enable = true,
					},
				},
			},
		},
		lemminx = {},
		lua_ls = {
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
		},
		-- omnisharp = {
		-- 	cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
		-- 	-- enable_roslyn_analyzers = true,
		-- 	enable_import_completion = true,
		-- 	organize_imports_on_format = true,
		-- 	handlers = {
		-- 		["textDocument/definition"] = require("omnisharp_extended").handler,
		-- 	},
		-- },
		pyright = {
			settings = {
				python = {
					analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = "openFilesOnly",
						extraPaths = {
							"/home/andreas/.vscode/extensions/joedevivo.vscode-circuitpython-0.1.20-linux-x64/boards/0x239A/0x80F4",
							"/home/andreas/.vscode/extensions/joedevivo.vscode-circuitpython-0.1.20-linux-x64/stubs",
							"/home/andreas/.config/Code/User/globalStorage/joedevivo.vscode-circuitpython/bundle/20230926/adafruit-circuitpython-bundle-py-20230926/lib",
						},
					},
				},
			},
		},
		tailwindcss = {},
		vimls = {},
		yamlls = {
			settings = {
				yaml = {
					schemaStore = {
						enable = false,
						url = "",
					},
					schemas = schemastore.yaml.schemas(),
				},
			},
		},
	}

	return configs
end

return {
	get_server_configs = get_server_configs,
    exclude_install = {
        "omnisharp"
    }
}
