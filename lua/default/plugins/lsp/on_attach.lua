local util = require('personal.util')
---On attach lsp callback.
---Requires lsp-config, which-key, lsp_signature and telescope
---@param client table
---@param bufnr number
return function(client, bufnr)
	require('lsp_signature').on_attach({
		bind = true,
		handler_opts = {
			border = 'rounded',
		},
		floating_window = true,
		hint_prefix = 'hint: ',
		floating_window_above_cur_line = true,
		toggle_key = '<m-x>',
	}, bufnr)

	local lsp_mappings = require('default.plugins.lsp.mappings')
	util.register_mapping({
		K = {
			require('default.plugins.lsp.open_hover').open_hover,
			'(LSP) Symbol Definition / Documentation',
		},
		['<leader>wa'] = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', 'Add Folder to Workspace' },
		['<leader>wr'] = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', 'Remove Folder from Workspace' },
		['<leader>wl'] = {
			'<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
			'List Registered Folders in Workspace',
		},
		gi = { lsp_mappings.implementations, '(LSP) Implementations' },
		gs = { lsp_mappings.document_symbols, '(LSP) Document Symbols' },
		gS = { lsp_mappings.live_workspace_symbols, '(LSP) Live Workspace Symbols' },
		gO = { lsp_mappings.type_definitions, '(LSP) Type Definitions' },
		gnn = {
			'<cmd>lua vim.diagnostic.open_float(nil, {border = "single"})<CR>',
			'(LSP) Show Line Diagnostic',
		},
		gnN = { lsp_mappings.workspace_diagnostics, '(LSP) Show Workspace Diagnostics' },
		gnp = {
			'<cmd>lua vim.diagnostic.goto_prev({ float = false })<CR>',
			'(Diagnostics) Go to Previous Diagnostic',
		},
		gne = {
			'<cmd>lua vim.diagnostic.goto_next({ float = false })<CR>',
			'(Diagnostics) Go to Next Diagnostic',
		},
		ga = {
			'<cmd>lua vim.lsp.buf.code_action()<cr>',
			'(LSP) Code Actions',
		},
		gr = { lsp_mappings.references, '(LSP) Symbol References' },
		gR = { lsp_mappings.incoming_calls, '(LSP) Incoming Calls' },
		gd = { lsp_mappings.definitions, '(LSP) Go to Symbol Definition' },
		gD = {
			function()
				vim.cmd('vsplit')
				vim.schedule(vim.lsp.buf.definition)
			end,
			'(LSP) Go To Definitions (V-Split)',
		},
	}, { buffer = bufnr })
	vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { desc = 'Rename Symbol', buffer = bufnr })

	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_autocmd('CursorHold', {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.document_highlight()
			end,
			desc = 'Highlight document symbols',
		})
		vim.api.nvim_create_autocmd('CursorMoved', {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.clear_references()
			end,
			desc = 'Clear document symbols highlight on move',
		})
	end

	local ok, lsp_status = pcall(require, 'lsp-status')
	if ok then
		lsp_status.on_attach(client)
	end

	vim.cmd([[au CursorHold  <buffer> lua require('default.plugins.lsp.open_hover').open_diagnostic()]])
	vim.cmd([[au CursorMoved <buffer> lua require('default.plugins.lsp.open_hover').clean_diagnostic()]])
	vim.cmd([[au CursorMoved <buffer> lua require('default.plugins.lsp.open_hover').clean_hover()]])

	local signs = { Error = ' ', Warn = ' ', Hint = ' ', Information = ' ' }

	for type, icon in pairs(signs) do
		local hl = 'DiagnosticSign' .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
	end
end
