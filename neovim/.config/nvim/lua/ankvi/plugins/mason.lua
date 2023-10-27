return {
	"williamboman/mason.nvim",

	dependencies = {
		{ "williamboman/mason-lspconfig.nvim" },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
	},

	build = function()
		pcall(vim.api.nvim_command, "MasonUpdate")
	end,

	config = function()
		local servers = require("ankvi.plugins.lsp.lspconfig.servers")

		require("mason").setup()
		require("mason-lspconfig").setup({
			automatic_installation = {
				exclude = servers.exclude_install,
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				-- LINTERS --
				"actionlint",
				"cpplint",
				"markdownlint",
				"pylint",
				"shellcheck",

				-- FORMATTERS --
				"black",
				"clang-format",
				"prettierd",
				"stylua",
			},
		})
	end,
}
