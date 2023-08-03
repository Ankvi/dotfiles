return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	config = function()
		vim.keymap.set("n", "<leader>xx", function()
			require("trouble").open()
		end)
		vim.keymap.set("n", "<leader>xw", function()
			require("trouble").open("workspace_diagnostics")
		end)
		vim.keymap.set("n", "<leader>xd", function()
			require("trouble").open("document_diagnostics")
		end)
		vim.keymap.set("n", "<leader>xq", function()
			require("trouble").open("quickfix")
		end)
		vim.keymap.set("n", "<leader>xl", function()
			require("trouble").open("loclist")
		end)
	end,
}
