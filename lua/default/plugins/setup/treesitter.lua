local ok, configs = pcall(require, 'nvim-treesitter.configs')
if not ok then
	return
end

configs.setup({
	ensure_installed = 'all',
	highlight = {
		enable = true,
	}
})
