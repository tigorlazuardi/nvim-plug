local ok, focus = pcall(require, 'focus')

if not ok then
	return
end

focus.setup({
	signcolumn = false, -- disable sign column only on main window
	cursorline = false, -- disabling this enable cursorlines on all window
	excluded_filetypes = {
		'calltree',
		'dapui_scopes',
		'dapui_breakpoints',
		'dapui_stacks',
		'dapui_watches',
		'dap-repl',
		'CHADTree',
		'symboltree',
		'filetree',
	},
	compatible_filetrees = { 'NvimTree' },
})
