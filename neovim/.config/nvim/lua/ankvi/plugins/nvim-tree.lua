return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        local tree = require("nvim-tree")
        tree.setup({
            sort_by = "case_sensitive",
            view = {
                width = 30
            },
            renderer = {
                group_empty = true
            },
            filters = {
                git_ignored = false
            }
        })

        vim.keymap.set("n", "<leader>pt", "<CMD>NvimTreeFocus<CR>")
    end
}
