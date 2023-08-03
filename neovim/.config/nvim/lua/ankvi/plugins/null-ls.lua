return {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        local diagnostics = null_ls.builtins.diagnostics
        local formatting = null_ls.builtins.formatting

        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        null_ls.setup({
            sources = {
                diagnostics.markdownlint,
                formatting.markdownlint,
                formatting.stylua,
                diagnostics.actionlint,
                diagnostics.pylint,
                formatting.black,
                formatting.isort,

                diagnostics.shellcheck,

                formatting.csharpier,
                --formatting.eslint,
                -- diagnostics.eslint.with({
                --     condition = function(utils)
                --         return not utils.root_has_file('.pnp.cjs')
                --     end
                -- }),
                -- diagnostics.eslint.with({
                --     command = 'yarn',
                --     args = { 'eslint', '-f', 'json', '--stdin', '--stdin-filename', '$FILENAME' },
                --     condition = function(utils)
                --         return utils.root_has_file('.pnp.cjs')
                --     end
                -- }),
                diagnostics.eslint_d,
                formatting.prettierd,
                formatting.stylelint,
                formatting.yamlfmt
            },
            -- you can reuse a shared lspconfig on_attach callback here
            on_attach = function(current_client, bufnr)
                if current_client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                            -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                            -- vim.lsp.buf.format({ async = false, timeout_ms = 10000 })

                            vim.lsp.buf.format({
                                async = false,
                                timeout_ms = 10000,
                                filter = function(client)
                                    return client.name == "null-ls"
                                end
                            })
                        end,
                    })
                end
            end,
        })
    end,
    dependencies = {
        "nvim-lua/plenary.nvim"
    }
}
