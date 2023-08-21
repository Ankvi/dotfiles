local M = {}

M.configure_configurations = function()
    local dap = require("dap")
		dap.adapters.coreclr = {
			type = "executable",
			command = "netcoredbg",
			args = { "--interpreter=vscode" },
		}

		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "launch - netcoredbg",
				request = "launch",
				program = function()
					local currentPath = vim.fn.getcwd()

                    -- Remove CWD from current buffer path
					local relativeFilePath = vim.fn.substitute(vim.fn.expand("%"), currentPath .. "/", "", "")

                    -- Iterate through project folders towards current buffer and look for a .csproj file
					for _, part in ipairs(vim.split(relativeFilePath, "/")) do
						currentPath = vim.fn.join({ currentPath, part }, "/")
						local projectFilePath = vim.fn.glob(currentPath .. "/*.csproj")
						if string.len(projectFilePath) ~= 0 then
							local projectName = vim.fn.fnamemodify(projectFilePath, ":t:r")

                            -- List .NET build outputs for current project
							local dlls = vim.fn.glob(currentPath .. "/bin/Debug/*/" .. projectName .. ".dll")
							local options = vim.fn.split(dlls, "\n", false)

                            -- Build input function prompt text
							local inputOptions = "Choose DLL:\n"
							for i, dll in ipairs(options) do
								inputOptions = inputOptions .. "[" .. i .. "]: " .. dll .. "\n"
							end

							local index = vim.fn.input(inputOptions)
                            return options[tonumber(index)]
						end
					end

                    -- Default to CWD and let user enter DLL file path 
					return vim.fn.input("Path to DLL: ", vim.fn.getcwd(), "file")
				end,
			},
		}
end

M.setup = function()
    M.configure_configurations()
end

return M
