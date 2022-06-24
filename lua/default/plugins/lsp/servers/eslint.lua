require('lspconfig').eslint.setup({
	on_attach = function(_client, buffer)
		vim.cmd([[
			au BufWritePre <buffer> silent! EslintFixAll
		]])

		vim.keymap.set('n', '<leader>ge', '<cmd>EslintFixAll<cr>', { desc = 'ESLint Fix All', buffer = buffer })
	end,
})
