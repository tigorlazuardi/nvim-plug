if pcall(require, 'pounce') then
	vim.keymap.set('n', 's', '<cmd>Pounce<cr>', { desc = 'Pounce' })
	vim.keymap.set('o', 'gs', '<cmd>Pounce<cr>', { desc = 'Pounce' })
end
