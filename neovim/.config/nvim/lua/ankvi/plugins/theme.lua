return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        vim.cmd.colorscheme("catppuccin")
    end,
}
-- return {
--     "folke/tokyonight.nvim",
--     lazy = false,
--     priority = 1000,
--     opts = {},
--     config = function()
--         vim.cmd.colorscheme("tokyonight-night")
--     end
-- }
--
-- return {
--     "rose-pine/neovim",
-- name = "rose-pine",
--	config = function()
--   vim.cmd.colorscheme("rose-pine")
--	end
-- }
