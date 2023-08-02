return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" }, -- Required
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
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "L3MON4D3/LuaSnip" }, -- Required
		{ "jose-elias-alvarez/typescript.nvim" },
		{ "lbrayner/vim-rzip" },
	},
	config = function()
		local lsp = require("lsp-zero")

		lsp.preset({})

		lsp.ensure_installed({
			"tsserver",
			-- "omnisharp",
			"eslint",
			-- "csharp_ls",
			"html",
			"jsonls",
			"lua_ls",
			"pylsp",
			"vimls",
			"yamlls",
		})

		lsp.skip_server_setup({ "omnisharp" })

		lsp.nvim_lua_ls({
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		lsp.on_attach(function(client, bufnr)
			local opts = { buffer = bufnr, remap = true }

			local telescope = require("telescope.builtin")
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
			vim.keymap.set("n", "gr", telescope.lsp_references, opts)

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
		end)

		lsp.setup()

		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local cmp_mappings = lsp.defaults.cmp_mappings({
			["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
			["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
			["<Tab>"] = cmp.mapping.confirm({ selected = true }),
			["<C-Space>"] = cmp.mapping.complete(),
		})

		--        cmp_mappings["<Tab>"] = nil
		cmp_mappings["<S-Tab>"] = nil

		cmp.setup({
			preselect = "item",
			mapping = cmp_mappings,
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "nvim_lsp_signature_help" },
			},
		})

		vim.diagnostic.config({
			virtual_text = true,
		})

		local lspconfig = require("lspconfig")
		lspconfig.omnisharp.setup({
			capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
			on_attach = function(_, bufnr)
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
			end,
			cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.loop.getpid()) },
		})
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
