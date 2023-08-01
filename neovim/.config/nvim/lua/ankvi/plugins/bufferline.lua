return {
    'akinsho/bufferline.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    version = "*",
    config = function()
        require("bufferline").setup()
        vim.keymap.set("n", "<A-,>", vim.cmd.bprevious)
        vim.keymap.set("n", "<A-.>", vim.cmd.bnext)
        vim.keymap.set("n", "<A-c>", vim.cmd.bd)
    end
}
