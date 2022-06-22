vim.cmd([[
	call plug#begin()

	" Tressitter
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	" Themes
	Plug 'catppuccin/nvim', {'as': 'catppuccin'}

	call plug#end()
]])

local util = require('personal.util')

local plugins_path = util.join_paths(vim.fn.stdpath('config'), 'lua', 'default', 'plugins', 'setup')

local list_cmd = 'ls ' .. plugins_path
if util.is_windows then
	list_cmd = 'dir /b ' .. plugins_path
end

local file_iterator = io.popen(list_cmd)
assert(file_iterator, 'failed to list files')

for file in file_iterator:lines() do
	if file:sub(-3) == 'lua' then
		file = file:sub(1, -5)
		require('default.plugins.setup.' .. file)
	end
end

file_iterator:close()
