-- setup callback to run once when a buffer of filetype go is loaded.
vim.api.nvim_create_autocmd('filetype', {
	pattern = { 'go', 'gosum', 'gomod' },
	callback = function()
		require('default.plugins.lazy_setup.golang_setup')
	end,
	once = true,
	desc = 'Call golang setup configs (oneshot)',
})
