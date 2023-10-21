local M = {}

M.options = {
    on_attach = function(_, bufnr)
        require("ankvi.formatting").set_format_keymap(true)
    end
}

return M
