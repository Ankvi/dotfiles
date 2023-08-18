return {
	{ "tpope/vim-fugitive" },
	{ "sindrets/diffview.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup()
			vim.keymap.set("n", "<leader>gb", gitsigns.toggle_current_line_blame)
		end,
	},
}
