return {
	"neovim/nvim-lspconfig",
	-- "VonHeikemen/lsp-zero.nvim",
	-- branch = "v2.x",
	-- "VonHeikemen/lsp-zero.nvim",
	-- branch = "v2.x",
	dependencies = {
		-- LSP Support
		-- { "neovim/nvim-lspconfig" }, -- Required
		{ "nvim-telescope/telescope.nvim" },
		{ -- Optional
			"williamboman/mason.nvim",
			build = function()
				pcall(vim.api.nvim_command, "MasonUpdate")
			end,
		},
		{ "williamboman/mason-lspconfig.nvim" }, -- Optional

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" }, -- Required
		{ "hrsh7th/cmp-nvim-lsp" }, -- Required
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{
			"L3MON4D3/LuaSnip",
			version = "2.*",
			build = "make install_jsregexp",
			dependencies = { "rafamadriz/friendly-snippets", "saadparwaiz1/cmp_luasnip" },
		}, -- Required
		{ "jose-elias-alvarez/typescript.nvim" },
		{ "lbrayner/vim-rzip" },
		-- { "edKotinsky/Arduino.nvim" }
	},
	config = function()
		-- local lsp = require("lsp-zero")

		-- lsp.preset({})

		-- local arduino = require("arduino")
		-- arduino.setup({
		--     default_fqbn = "arduino:avr:micro",
		--
		--     --Path to clangd (all paths must be full)
		--     clangd = require("mason-core.path").bin_prefix "clangd",
		--
		--     --Path to arduino-cli
		--     arduino = table.concat({ vim.fn.getenv("BIN_FOLDER"), "arduino-cli"}, "/"),
		--
		--     --Data directory of arduino-cli
		--     arduino_config_dir = "$HOME/.arduino15",
		-- })
		--
		local servers = {
			arduino_language_server = {
				-- on_new_config = arduino.on_new_config
				cmd = {
					"arduino-language-server",
					"-cli-config",
					"$HOME/.arduino15/arduino-cli.yaml",
					"-fqbn",
					"arduino:avr:micro",
				},
			},
			clangd = {},
			tsserver = {},
			omnisharp = {
				cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.loop.getpid()) },
			},
			eslint = {},
			-- csharp_ls,
			html = {},
			jsonls = {},
			lua_ls = {
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if
						not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc")
					then
						client.config.settings = vim.tbl_deep_extend("force", client.config.settings.Lua, {
							telemetry = { enable = false },
							runtime = {
								-- Tell the language server which version of Lua you're using
								-- (most likely LuaJIT in the case of Neovim)
								version = "LuaJIT",
								-- path = runtime_path,
							},
							diagnostics = {
								-- Get the language server to recognize the `vim` global
								globals = { "vim" },
							},
							workspace = {
								checkThirdParty = false,
								library = {
									-- Make the server aware of Neovim runtime files
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
			yamlls = {},
		}

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
			automatic_installation = true,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
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
				vim.keymap.set("i", "<C-f>", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
				vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set({ "n", "x" }, "<F3>", function()
					vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
				end, opts)
			end,
		})

		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
			preselect = "item",
			mapping = cmp.mapping.preset.insert({
				["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
				["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
				["<CR>"] = cmp.mapping.confirm({ selected = true }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "nvim_lsp_signature_help" },
			},
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})

		-- lsp.setup()

		require("luasnip.loaders.from_vscode").lazy_load()

		vim.diagnostic.config({
			virtual_text = true,
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		-- local on_attach = function(_, bufnr)
		--     vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		-- end
		local common_setup_args = {
			capabilities = capabilities,
			-- on_attach = on_attach,
		}

		local lspconfig = require("lspconfig")

		--       lspconfig.omnisharp.setup(vim.tbl_extend("force", common_setup_args, {
		-- 	cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.loop.getpid()) },
		-- }))
		--
		--       lspconfig.clangd.setup(vim.tbl_extend("force", common_setup_args, {
		--
		--       }))

		for name, opts in pairs(servers) do
			lspconfig[name].setup(vim.tbl_extend("force", common_setup_args, opts))
		end
		-- lspconfig.tsserver

		-- local typescript = require("typescript")
		-- typescript.setup({
		--     server = {
		--         on_attach = function(_, bufnr)
		--             local opts = { buffer = bufnr }
		--             vim.keymap.set("n", "<leader>ci", typescript.actions.organizeImports, opts)
		--             vim.keymap.set("n", "<leader>am", typescript.actions.addMissingImports, opts)
		--             vim.keymap.set("n", "<leader>ru", typescript.actions.removeUnused, opts)
		--         end
		--     }
		-- })
	end,
}
