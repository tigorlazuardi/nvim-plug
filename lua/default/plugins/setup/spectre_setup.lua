local ok, spectre = pcall(require, 'spectre')
if not ok then
	return
end
local util = require('personal.util')

spectre.setup({})

util.register_mapping({
	['<leader>fr'] = { [[<cmd>lua require('spectre').open()<cr>]], 'Open Find and Replace' },
	['<leader>fw'] = {
		[[<cmd>lua require('spectre').open_visual({select_word = true})<cr>]],
		'Open Find and Replace <cword>',
	},
	['<leader>fs'] = { [[<cmd>lua require('spectre').open_file_search()<cr>]], 'Open File Search' },
})
