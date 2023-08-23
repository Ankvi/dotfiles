local M = {}

local format_null_ls = function()
	vim.lsp.buf.format({
		async = false,
		timeout_ms = 10000,
		filter = function(client)
			return client.name == "null-ls"
		end,
	})
end

local format = function()
	vim.lsp.buf.format({
		async = false,
		timeout_ms = 10000,
	})
end

M.set_format_keymap = function(use_null_ls)
	vim.keymap.set({ "n", "i", "x" }, "<F3>", function()
		if use_null_ls then
			format_null_ls()
		else
            format()
		end
	end)
end

return M
