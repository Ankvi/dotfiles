return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"typescript",
			"tsx",
			"javascript",
			"csharp",
			"markdown",
			"python",
			"json",
			"yaml",
			"html",
		},
		highlight = { enable = true },
		indent = { enable = true },
		sync_install = false,
		auto_install = true,
		additional_vim_regex_highlighting = false
	}
}
