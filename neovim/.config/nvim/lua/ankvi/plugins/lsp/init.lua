return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
		{
			"williamboman/mason.nvim",
			build = function()
				pcall(vim.api.nvim_command, "MasonUpdate")
			end,
		},
		{ "williamboman/mason-lspconfig.nvim" }, -- Optional
		{ "lbrayner/vim-rzip" },
		{
			"Hoffs/omnisharp-extended-lsp.nvim",
		},
		{
			"b0o/schemastore.nvim",
		},
		{ "hrsh7th/cmp-nvim-lsp" }
	},
	config = function()
		local schemastore = require("schemastore")
		local servers = {
			arduino_language_server = {
				cmd = {
					"arduino-language-server",
					"-cli-config",
					"$HOME/.arduino15/arduino-cli.yaml",
					"-fqbn",
					"arduino:avr:micro",
				},
			},
			clangd = {},
			dockerls = {},
			tsserver = {},
			omnisharp = {
				cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
				-- enable_roslyn_analyzers = true,
				enable_import_completion = true,
				organize_imports_on_format = true,
				handlers = {
					["textDocument/definition"] = require("omnisharp_extended").handler,
				},
			},
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
			lua_ls = {
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if
						not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc")
					then
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
			pylsp = {},
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

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
			automatic_installation = true,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
				local opts = { buffer = ev.buf, remap = true }

				local telescope = require("telescope.builtin")
				local previewer_opts = {
					entry_maker = require("ankvi.plugins.telescope.customEntry").gen_from_quickfix(opts),
				}

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
				vim.keymap.set("n", "gr", function()
					telescope.lsp_references(previewer_opts)
				end, opts)

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
				vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "ød", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "æd", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("v", "<leader>ca", "<cmd>'<,'>lua vim.lsp.buf.code_action()<CR>", opts)
				vim.keymap.set("i", "<C-f>", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
				vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
			end,
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local common_setup_args = {
			capabilities = capabilities,
            on_attach = function(_, bufnr)
                require("ankvi.formatting").set_format_keymap()
            end
		}

		local lspconfig = require("lspconfig")
		for name, opts in pairs(servers) do
			lspconfig[name].setup(vim.tbl_extend("force", common_setup_args, opts))
		end
	end,
}
