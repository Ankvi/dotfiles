local M = {}

M.options = {
	cmd = {
		"arduino-language-server",
		"-cli-config",
		"$HOME/.arduino15/arduino-cli.yaml",
		"-fqbn",
		"arduino:avr:micro",
	},
}

return M
