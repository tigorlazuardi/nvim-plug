local M = {}

M.nremap = function(key, vscode_command)
	vim.keymap.set(
		'n',
		key,
		[[<cmd>call VSCodeCall(']] .. vscode_command .. [[')<cr>]],
		{ desc = 'VSCode Call ' .. vscode_command }
	)
end

return M
