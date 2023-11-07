local M = {
    cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    -- enable_roslyn_analyzers = true,
    enable_import_completion = true,
    organize_imports_on_format = true,
    handlers = {
        ["textDocument/definition"] = require("omnisharp_extended").handler,
    },
}

return M
