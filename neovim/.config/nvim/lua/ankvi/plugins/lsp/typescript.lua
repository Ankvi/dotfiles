return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {},
    config = function()
        local util = require("lspconfig.util")
        local ts = require("typescript-tools")
        ts.setup({
            util.root_pattern(".git", "tsconfig.json")
        })
    end
}
