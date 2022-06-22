local ok, cutlass = pcall(require, 'cutlass')
if not ok then
	return
end

cutlass.setup({
	cut_key = 'x',
})
