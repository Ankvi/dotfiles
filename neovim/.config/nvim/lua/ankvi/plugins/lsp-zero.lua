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

		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{
			"L3MON4D3/LuaSnip",
			version = "2.*",
			build = "make install_jsregexp",
			dependencies = { "rafamadriz/friendly-snippets", "saadparwaiz1/cmp_luasnip" },
		},
		{ "jose-elias-alvarez/typescript.nvim" },
		{ "lbrayner/vim-rzip" },
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			opts = {},
		},
		{
			"Hoffs/omnisharp-extended-lsp.nvim",
		},
	},
	config = function()
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
					vim.lsp.buf.format({
						async = false,
						timeout_ms = 10000,
						filter = function(client)
							return client.name == "null-ls"
						end,
					})
				end, opts)
			end,
		})

		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			preselect = "item",
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<Tab>"] = cmp.mapping.confirm({ selected = true }),
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

		require("luasnip.loaders.from_vscode").lazy_load()

		vim.diagnostic.config({
			virtual_text = true,
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local common_setup_args = {
			capabilities = capabilities,
		}

		local lspconfig = require("lspconfig")
		for name, opts in pairs(servers) do
			lspconfig[name].setup(vim.tbl_extend("force", common_setup_args, opts))
		end
	end,
}
