local util = require('personal.util')

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	float = { border = 'single' },
})

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Information = ' ' }

for type, icon in pairs(signs) do
	local hl = 'DiagnosticSign' .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = 'single',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = 'single',
})

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{ update_in_insert = false }
)

require('nvim-lsp-installer').setup({
	automatic_installation = {
		exclude = util.is_windows and { 'yamlls', 'jsonls', 'tsserver', 'taplo' } or { 'taplo' },
	},
})

util.register_mapping({
	['<leader>li'] = { '<cmd>LspInfo<cr>', 'Lsp Info' },
	['<leader>lr'] = { '<cmd>LspRestart<cr>', 'Lsp Restart' },
	['<leader>lS'] = {
		function()
			for _, client in pairs(vim.lsp.get_active_clients()) do
				client.stop()
			end
		end,
		'LSP Stop',
	},
	['<leader>ls'] = { '<cmd>LspStart<cr>', 'LSP Start' },
})

require('lsp_extensions').inlay_hints({
	highlight = 'Comment',
	prefix = ' > ',
	aligned = false,
	only_current_line = false,
	enabled = { 'ChainingHint' },
})
require('fidget').setup({})
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
	pattern = '*',
	callback = function()
		require('nvim-lightbulb').update_lightbulb()
	end,
	desc = 'Update lsp lightbulb',
})

require('default.plugins.lsp.servers')
