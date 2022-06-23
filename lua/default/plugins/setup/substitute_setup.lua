local ok, substitute = pcall(require, 'substitute')

if not ok then
	return
end

substitute.setup()

vim.keymap.set('n', '<leader>s', [[<cmd>lua require('substitute').operator()<cr>]], { desc = 'Substitute (Motion)' })
vim.keymap.set('n', '<leader>ss', [[<cmd>lua require('substitute').line()<cr>]], { desc = 'Substitute Line' })
vim.keymap.set('n', '<leader>S', [[<cmd>lua require('substitute').eol()<cr>]], { desc = 'Substitute to End of Line' })

vim.keymap.set('x', '<leader>s', [[<cmd>lua require('substitute').visual()<cr>]], { desc = 'Substitute (Visual)' })
