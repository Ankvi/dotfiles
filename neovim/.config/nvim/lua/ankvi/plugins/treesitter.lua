return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "lua",
                "vim",
                "vimdoc",
                "typescript",
                "tsx",
                "javascript",
                "c_sharp",
                "markdown",
                "python",
                "json",
                "jsonc",
                "yaml",
                "html",
                "dockerfile",
                "ini",
                "make"
            },
            highlight = { enable = true },
            indent = { enable = true },
            sync_install = false,
            auto_install = true,
            additional_vim_regex_highlighting = false,
            ignore_install = {},
            modules = {}
        })
    end
}
