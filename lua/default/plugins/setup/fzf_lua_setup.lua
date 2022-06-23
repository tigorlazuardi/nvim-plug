local ok, fzf_lua = pcall(require, 'fzf-lua')

fzf_lua.setup({
	fzf_bin = vim.fn.exepath('sk') ~= '' and 'sk' or 'fzf',
	winopts = {
		preview = {
			default = vim.fn.exepath('bat') ~= '' and 'bat' or 'builtin',
		},
	},
})
vim.keymap.set('n', '<c-y>', function()
	fzf_lua.lgrep_curbuf()
end, { desc = 'Live Grep (Current Buffer)' })

require('default.mappings.pickers')
