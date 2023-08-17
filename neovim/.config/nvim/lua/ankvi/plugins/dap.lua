return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	config = function()
		local dap = require("dap")

		-- local masonBin = vim.fn.stdpath("data") .. "/mason/bin/"

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
                    local filePath = vim.fn.expand("%")
                    local pathParts = vim.split(filePath, "/")
                    local currentPath = vim.fn.getcwd()
                    for _, part in pairs(pathParts) do
                        currentPath = vim.fn.join({ currentPath, part }, "/")
                        local projectFilePath = vim.fn.glob(currentPath .. "/*.csproj")
                        if projectFilePath ~= "" then
                            print(currentPath, projectFilePath)
                            local projectFileName = vim.fn.trim(projectFilePath, currentPath, 1)
                            local projectName = vim.fn.trim(projectFileName, ".csproj", 2)
                            -- print(projectFileName, projectName)
                            local dllPath = vim.fn.glob(currentPath .. "/bin/**/" .. projectName .. ".dll")
                            -- print("Found dll file: " .. dllPath)
                            return dllPath
                        end
                    end
				end,
			},
		}

		require("neodev").setup({
			library = {
				plugins = {
					"nvim-dap-ui",
				},
				types = true,
			},
		})

		local dapui = require("dapui")

		local dapUiConfigEvent = "dapui_config"
		dap.listeners.after.event_initialized[dapUiConfigEvent] = function()
			dapui.open()
		end

		dap.listeners.after.event_terminated[dapUiConfigEvent] = function()
			dapui.close()
		end

		dap.listeners.after.event_exited[dapUiConfigEvent] = function()
			dapui.close()
		end

		local opts = {}
		vim.keymap.set("n", "<F5>", dap.continue, opts)
		vim.keymap.set("n", "<F10>", dap.step_over, opts)
		vim.keymap.set("n", "<F11>", dap.step_into, opts)
		vim.keymap.set("n", "<F12>", dap.step_out, opts)
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, opts)
	end,
}
