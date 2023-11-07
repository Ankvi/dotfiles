return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
		{ "lbrayner/vim-rzip" },
		{
			"Hoffs/omnisharp-extended-lsp.nvim",
		},
		{
			"Decodetalkers/csharpls-extended-lsp.nvim",
		},
		{
			"b0o/schemastore.nvim",
		},
		{ "hrsh7th/cmp-nvim-lsp" },
	},
	config = function()
		local servers = require("ankvi.plugins.lsp.lspconfig.servers")

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
		}

		local lspconfig = require("lspconfig")
		for name, opts in pairs(servers.configs) do
			lspconfig[name].setup(vim.tbl_extend("force", common_setup_args, opts))
		end
	end,
}
