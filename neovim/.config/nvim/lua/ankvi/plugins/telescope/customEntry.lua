local my_make_entry = {}

local devicons = require("nvim-web-devicons")
local entry_display = require("telescope.pickers.entry_display")
local utils = require("telescope.utils")
local make_entry = require("telescope.make_entry")

local get_filename_fn = function()
	local bufnr_name_cache = {}
	return function(bufnr)
		bufnr = vim.F.if_nil(bufnr, 0)
		local c = bufnr_name_cache[bufnr]
		if c then
			return c
		end

		local n = vim.api.nvim_buf_get_name(bufnr)
		bufnr_name_cache[bufnr] = n
		return n
	end
end

local filter = vim.tbl_filter
local map = vim.tbl_map

function my_make_entry.gen_from_quickfix(opts)
	opts = opts or {}
	local show_line = vim.F.if_nil(opts.show_line, true)

	local hidden = utils.is_path_hidden(opts)
	local items = {
		{ width = vim.F.if_nil(opts.fname_width, 50) },
		{ remaining = true },
	}
	if hidden then
		items[1] = { width = 8 }
	end
	if not show_line then
		table.remove(items, 1)
	end

	local displayer = entry_display.create({ separator = "▏", items = items })

	local make_display = function(entry)
		local input = {}
		if not hidden then
			table.insert(
				input,
				string.format("%s:%d:%d", utils.transform_path(opts, entry.filename), entry.lnum, entry.col)
			)
		else
			table.insert(input, string.format("%4d:%2d", entry.lnum, entry.col))
		end

		if show_line then
			local text = entry.text
			if opts.trim_text then
				text = text:gsub("^%s*(.-)%s*$", "%1")
			end
			text = text:gsub(".* | ", "")
			table.insert(input, text)
		end

		return displayer(input)
	end

	local get_filename = get_filename_fn()
	return function(entry)
		local filename = vim.F.if_nil(entry.filename, get_filename(entry.bufnr))

		return make_entry.set_default_entry_mt({
			value = entry,
			ordinal = (not hidden and filename or "") .. " " .. entry.text,
			display = make_display,

			bufnr = entry.bufnr,
			filename = filename,
			lnum = entry.lnum,
			col = entry.col,
			text = entry.text,
			start = entry.start,
			finish = entry.finish,
		}, opts)
	end
end

function my_make_entry.gen_from_buffer_like_leaderf(opts)
	opts = opts or {}
	local default_icons, _ = devicons.get_icon("file", "", { default = true })

	local bufnrs = filter(function(b)
		return 1 == vim.fn.buflisted(b)
	end, vim.api.nvim_list_bufs())

	local max_bufnr = math.max(unpack(bufnrs))
	local bufnr_width = #tostring(max_bufnr)

	local max_bufname = math.max(unpack(map(function(bufnr)
		return vim.fn.strdisplaywidth(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:t"))
	end, bufnrs)))

	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = bufnr_width },
			{ width = 4 },
			{ width = vim.fn.strwidth(default_icons) },
			{ width = max_bufname },
			{ remaining = true },
		},
	})

	local make_display = function(entry)
		return displayer({
			{ entry.bufnr, "TelescopeResultsNumber" },
			{ entry.indicator, "TelescopeResultsComment" },
			{ entry.devicons, entry.devicons_highlight },
			entry.file_name,
			{ entry.dir_name, "Comment" },
		})
	end

	return function(entry)
		print(entry)
		local bufname = entry.info.name ~= "" and entry.info.name or "[No Name]"
		local hidden = entry.info.hidden == 1 and "h" or "a"
		local readonly = vim.api.nvim_buf_get_option(entry.bufnr, "readonly") and "=" or " "
		local changed = entry.info.changed == 1 and "+" or " "
		local indicator = entry.flag .. hidden .. readonly .. changed

		local dir_name = vim.fn.fnamemodify(bufname, ":p:h")
		local file_name = vim.fn.fnamemodify(bufname, ":p:t")

		local icons, highlight = devicons.get_icon(bufname, string.match(bufname, "%a+$"), { default = true })

		return {
			valid = true,

			value = bufname,
			ordinal = entry.bufnr .. " : " .. file_name,
			display = make_display,

			bufnr = entry.bufnr,

			lnum = entry.info.lnum ~= 0 and entry.info.lnum or 1,
			indicator = indicator,
			devicons = icons,
			devicons_highlight = highlight,

			file_name = file_name,
			dir_name = dir_name,
		}
	end
end

return my_make_entry
