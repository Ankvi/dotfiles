return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                markdown = { "prettierd" },
                javascript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
                css = { "prettierd" },
                html = { "prettierd" },
                json = { "prettierd" },
                yaml = { "prettierd" },
                lua = { "stylua" },
                python = { "isort", "black" }
            }
        })

        vim.keymap.set({ "n", "v" }, "<F3>", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 2000
            })
        end)
    end
}
