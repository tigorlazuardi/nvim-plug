local ok, scrollbar = pcall(require, 'scrollbar')
if not ok then
	return
end

vim.keymap.set(
	'n',
	'n',
	[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
	{ desc = 'Next Search Item' }
)
vim.keymap.set(
	'n',
	'N',
	[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
	{ desc = 'Previous Search Item' }
)
vim.keymap.set(
	'n',
	'*',
	[[*<Cmd>lua require('hlslens').start()<CR>]],
	{ desc = 'Search downward word under cursor (strict)' }
)
vim.keymap.set('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], { desc = 'Search downward word under cursor' })
vim.keymap.set(
	'n',
	'#',
	[[#<Cmd>lua require('hlslens').start()<CR>]],
	{ desc = 'Search upward word under cursor (strict)' }
)
vim.keymap.set('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], { desc = 'Search upward word under cursor' })
vim.keymap.set('n', '<leader>L', ':nohlsearch<cr>', { desc = 'remove highlight' })

require('hlslens').setup({
	calm_down = true,
})

local colors = require('tokyonight.colors').setup()
scrollbar.setup({
	handle = {
		color = colors.bg_highlight,
	},
	marks = {
		Search = { color = colors.orange },
		Error = { color = colors.error },
		Warn = { color = colors.warning },
		Info = { color = colors.info },
		Hint = { color = colors.hint },
		Misc = { color = colors.purple },
	},
})
require('scrollbar.handlers.search').setup()
