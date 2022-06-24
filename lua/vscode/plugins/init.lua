vim.cmd([[
	call plug#begin()
	" Do not install plenary plugins. It broke integration with VSCode.

	" Register Handlers
	" maps default delete operations to blackhole.
	Plug 'gbprod/cutlass.nvim'
	Plug 'gbprod/substitute.nvim'
	" Do not install Yanky, it vendors plenary.

	" Text Objects
	Plug 'kana/vim-textobj-user'
	Plug 'sgur/vim-textobj-parameter'
	Plug 'whatyouhide/vim-textobj-xmlattr'
	Plug 'Julian/vim-textobj-variable-segment'
	Plug 'kana/vim-textobj-line'
	Plug 'kana/vim-textobj-entire'

	call plug#end()
]])

local util = require('personal.util')

local plugins_path = util.join_paths(vim.fn.stdpath('config'), 'lua', 'vscode', 'plugins', 'setup')

local list_cmd = 'ls ' .. plugins_path
if util.is_windows then
	list_cmd = 'dir /b ' .. plugins_path
end

local file_iterator = io.popen(list_cmd)
assert(file_iterator, 'failed to list files')

for file in file_iterator:lines() do
	if file:sub(-3) == 'lua' then
		file = file:sub(1, -5)
		require('vscode.plugins.setup.' .. file)
	end
end

file_iterator:close()
