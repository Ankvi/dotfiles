local schemastore = require("schemastore")

local M = {
    settings = {
        json = {
            schemas = schemastore.json.schemas(),
            validate = {
                enable = true,
            },
        },
    },
}

return M
