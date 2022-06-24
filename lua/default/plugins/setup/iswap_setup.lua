local ok, iswap = pcall(require, 'iswap')
if not ok then
	return
end

iswap.setup({})
vim.keymap.set('n', '<c-s>', '<cmd>ISwapWith<cr>', { desc = 'Swap Nodes' })
