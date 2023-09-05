return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, {})
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>pb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", {})

		telescope.setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_cursor(),
				},
				file_browser = {
					-- theme = "dropdown",
                    hijack_netrw = true,
					hidden = {
						file_browser = true,
						folder_browser = true,
					},
				},
			},
		})
		telescope.load_extension("ui-select")
		telescope.load_extension("file_browser")
	end,
}
