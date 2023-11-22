local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5

return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		local tree = require("nvim-tree")
		local api = require("nvim-tree.api")
		tree.setup({
			sort_by = "case_sensitive",
			view = {
				float = {
					enable = true,
					open_win_config = function()
						local screen_w = vim.opt.columns:get()
						local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
						local window_w = screen_w * WIDTH_RATIO
						local window_h = screen_h * HEIGHT_RATIO
						local window_w_int = math.floor(window_w)
						local window_h_int = math.floor(window_h)
						local center_x = (screen_w - window_w) / 2
						local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
						return {
							border = "rounded",
							relative = "editor",
							row = center_y,
							col = center_x,
							width = window_w_int,
							height = window_h_int,
						}
					end,
				},
				width = function()
					return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
				end,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				git_ignored = false,
			},
            on_attach = function(bufnr)
                local function options(description)
                    return {
                        desc = "nvim-tree: " .. description,
                        buffer = bufnr,
                        noremap = true,
                        silent = true,
                        nowait = true
                    }
                end

                -- setup default mapping
                api.config.mappings.default_on_attach(bufnr)

                -- custom mappings
                vim.keymap.set("n", "<ESC>", api.tree.close, options("Close"))
            end
		})

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
