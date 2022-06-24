local capabilities = require('default.plugins.lsp.capabilities')
local on_attach = require('default.plugins.lsp.on_attach')

local opts = {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		on_attach(client, bufnr)
	end,
	commands = {
		Format = {
			function()
				vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line('$'), 0 })
			end,
		},
	},
	settings = {
		json = {
			schemas = require('schemastore').json.schemas(),
		},
		yaml = {
			schemas = require('schemastore').json.schemas(),
		},
	},
}

require('lspconfig').yamlls.setup(opts)
require('lspconfig').jsonls.setup(opts)
