local ok, bufdelete = pcall(require, 'bufdelete')
if not ok then
	return
end

vim.keymap.set('n', '<leader>bD', function()
	bufdelete.bufdelete(0, true)
end, { desc = 'Delete current buffer (forced)' })
vim.keymap.set('n', '<leader>bd', function()
	bufdelete.bufdelete(0, false)
end, { desc = 'Delete current buffer' })
