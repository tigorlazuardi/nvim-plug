local ok, go = pcall(require, 'go')

if not ok then
	return
end

go.setup({
	-- gopls_cmd = { install_root_dir .. '/go/gopls' },
	gopls_cmd = { vim.fn.expand('$HOME') .. '/go/bin/gopls' },
	gofmt = 'gofumpt',
	test_runner = 'richgo',
	run_in_floaterm = true,
	max_line_len = 150,
	textobjects = false, -- since this plugin is lazy loaded and only run when a go file is loaded, this will cause E13 read error and had to re-open the file or force save with w! on the opened file to ignore this error.
})

