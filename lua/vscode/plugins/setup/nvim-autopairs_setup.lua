local ok, autopair = pcall(require, 'nvim-autopairs')

if not ok then
	return
end

autopair.setup({
	check_ts = true,
})