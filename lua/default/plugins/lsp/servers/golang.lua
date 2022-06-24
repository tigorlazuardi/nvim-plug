local capabilities = require('default.plugins.lsp.capabilities')
local on_attach = require('default.plugins.lsp.on_attach')
local util = require('personal.util')
local opts = {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = true
		on_attach(client, bufnr)
		vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
			callback = function()
				local codeaction = require('go.lsp').codeaction
				codeaction('', 'source.organizeImports', 3000)
				vim.lsp.buf.format({ name = 'gopls' })
			end,
			buffer = bufnr,
		})

		util.register_mapping({
			['<leader>gf'] = { '<cmd>GoImport<cr>', 'Organize Imports' },
			['<leader>gdf'] = {
				function()
					vim.notify('debug current test function is not migrated yet', 'warn', { title = 'config' })
				end,
				'Debug current test function',
			},
			['<leader>ga'] = { '<cmd>GoAddTag<cr>', 'Generate Tag for Struct' },
			['<leader>gc'] = { '<cmd>GoCmt<cr>', 'Generate comment for function or struct' },
			['<leader>gtf'] = { '<cmd>GoTestFunc<cr>', 'Test Current Function' },
			['<leader>gtF'] = { '<cmd>GoTestFile<cr>', 'Test Current File' },
			['<leader>gtp'] = { '<cmd>GoTestPackage<cr>', 'Test Current Package' },
			['<leader>gi'] = { '<cmd>GoImpl<cr>', 'Generate stub Implementation for Type from an interface' },
			['<leader>gc'] = {
				function()
					require('nvim-goc').ClearCoverage()
				end,
				'Clear Coverage',
			},
			['<leader>gr'] = {
				function()
					require('nvim-goc').Coverage()
				end,
				'Coverage',
			},
			['<leader>gR'] = {
				function()
					require('nvim-goc').CoverageFunc()
				end,
				'Coverage Func',
			},
			['<leader>ga'] = { '<cmd>GoAddTest<cr>', 'Generate test for function' },
			['<leader>gA'] = { '<cmd>GoAddAllTest<cr>', 'Generate test for functions in file' },
		}, { buffer = bufnr })
		local wk = require('which-key')
	end,
	settings = {
		gopls = {
			-- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
			analyses = { unusedparams = true, unreachable = false },
			codelenses = {
				generate = true, -- show the `go generate` lens.
				gc_details = true, -- Show a code lens toggling the display of gc's choices.
			},
			usePlaceholders = false,
			completeUnimported = true,
			staticcheck = false, -- in favor of golangci lint
			matcher = 'Fuzzy',
			diagnosticsDelay = '500ms',
			symbolMatcher = 'FastFuzzy',
			gofumpt = false, -- depending on your projects, you may want this on.
		},
	},
}

require('lspconfig').gopls.setup(opts)
require('lspconfig').golangci_lint_ls.setup({})
