return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {
        single_file_support = false,
        root_dir = require("lspconfig.util").root_pattern(".git")
    },
}
