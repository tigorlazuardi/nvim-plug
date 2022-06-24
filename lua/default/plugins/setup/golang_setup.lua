-- setup callback to run once when a buffer of filetype go is loaded.
vim.api.nvim_create_autocmd('filetype', {
	pattern = { 'go', 'gosum', 'gomod' },
	callback = function()
		-- ensures that the plugin is only loaded after golang plugin is done loaded.
		vim.defer_fn(function()
			require('default.plugins.lazy_setup.golang_setup')
		end, 100)
	end,
	once = true,
	desc = 'Call golang setup configs (oneshot)',
})
