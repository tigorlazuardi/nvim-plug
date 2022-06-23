vim.o.compatible = false -- disable compatibility with vi
vim.o.mouse = 'va' -- mouse to paste middleclick ('v'), and select via click ('a')
vim.o.cursorline = true -- show cursorline

vim.o.number = true
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'

vim.o.title = true
local titlestringer_group = vim.api.nvim_create_augroup('titlestringer', { clear = true })
vim.api.nvim_create_autocmd({ 'DirChanged', 'VimEnter' }, {
	pattern = '*',
	group = titlestringer_group,
	callback = function()
		vim.o.titlestring = 'nvim - ' .. vim.fn.getcwd()
	end,
	desc = 'Changes title on DirChanged or first enter vim',
})

local c = vim.api.nvim_command
c('set ignorecase') -- case insensitive search

require('default.core.visuals')
require('default.core.neovide')
require('default.core.window')
require('default.core.indentation')
