return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"arduino",
				"c",
				"cpp",
				"lua",
				"vim",
				"vimdoc",
				"c_sharp",
				"markdown",
				"python",
				"dockerfile",
				"ini",
				"make",
				"yaml",
				"json",
				"jsonc",
				"html",
				"typescript",
				"tsx",
				"javascript",
				"css",
			},
			highlight = { enable = true },
			indent = { enable = true },
			sync_install = false,
			auto_install = true,
			additional_vim_regex_highlighting = false,
			ignore_install = {},
			modules = {},
		})
	end,
}
