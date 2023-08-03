return {
    "folke/zen-mode.nvim",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        require("zen-mode").setup()
        vim.keymap.set("n", "<leader>zen", "<CMD>ZenMode<CR>", { silent = true })
    end
}
