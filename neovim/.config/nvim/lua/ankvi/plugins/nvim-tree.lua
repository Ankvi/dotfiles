return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		local tree = require("nvim-tree")
		tree.setup({
			sort_by = "case_sensitive",
			view = {
				width = 30,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				git_ignored = false,
			},
		})

        local api = require("nvim-tree.api")
        local nvimTreeFocusOrToggle = function()
            local currentBuf = vim.api.nvim_get_current_buf()
            local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
            if currentBufFt == "NvimTree" then
                api.tree.toggle()
            else
                api.tree.focus()
                api.tree.find_file({ open = true, buf = currentBuf })
            end
        end

        vim.keymap.set("n", "<leader>pt", nvimTreeFocusOrToggle)
	end,
}
