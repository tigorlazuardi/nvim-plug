if not pcall(require, 'nvim-treesitter') then
	return
end

local ok, tabout = pcall(require, 'tabout')
if not ok then
	return
end

local setup = {
	tabkey = '', -- key to trigger tabout, set to an empty string to disable
	backwards_tabkey = '', -- ke
	act_as_tab = true, -- shift content if tab out is not possible
	act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
	enable_backwards = true, -- well ...
	completion = false, -- if the tabkey is used in a completion pum
	tabouts = {
		{ open = "'", close = "'" },
		{ open = '"', close = '"' },
		{ open = '`', close = '`' },
		{ open = '(', close = ')' },
		{ open = '[', close = ']' },
		{ open = '{', close = '}' },
		{ open = '<', close = '>' },
	},
	ignore_beginning = false, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
	exclude = {}, -- tabout will ignore these filetypes
}
tabout.setup(setup)

vim.keymap.set('i', '<tab>', '<Plug>(Tabout)', { desc = 'Tabout' })
vim.keymap.set('i', '<s-tab>', '<Plug>(TaboutBack)', { desc = 'Tabout Back' })
