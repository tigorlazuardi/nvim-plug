local ok, cmp = pcall(require, 'cmp')

if not ok then
	return
end

local icons = {
	Text = '',
	Method = '',
	Function = '',
	Constructor = '⌘',
	Field = 'ﰠ',
	Variable = '',
	Class = 'ﴯ',
	Interface = '',
	Module = '',
	Property = 'ﰠ',
	Unit = '塞',
	Value = '',
	Enum = '',
	Keyword = '廓',
	Snippet = '',
	Color = '',
	File = '',
	Reference = '',
	Folder = '',
	EnumMember = '',
	Constant = '',
	Struct = 'פּ',
	Event = '',
	Operator = '',
	TypeParameter = '',
}

local compare = require('cmp.config.compare')
local sources = {
	{ name = 'copilot', priority = 8 },
	{ name = 'nvim_lua', priority = 8 },
	{ name = 'nvim_lsp', priority = 8, max_item_count = 20 },
	{ name = 'luasnip', priority = 7, max_item_count = 5, keyword_length = 1 },
	{ name = 'treesitter', priority = 7, max_item_count = 5, keyword_length = 3 },
	{ name = 'buffer', priority = 6, max_item_count = 3, keyword_length = 3 },
	{ name = 'path', priority = 6 },
	{ name = 'rg', priority = 5, max_item_count = 5, keyword_length = 3 },
	{ name = 'spell', priority = 4, max_item_count = 5, keyword_length = 3 },
	{ name = 'emoji', priority = 3, max_item_count = 5 },
}

if not vim.g.is_windows then
	sources = vim.list_extend(sources, { name = 'copilot', priority = 8 })
end

local persistent_kind_length = 0

local source_mapping = {
	buffer = 'Buffer',
	nvim_lsp = 'LSP',
	nvim_lua = 'API',
	path = 'Path',
	luasnip = 'Luasnip',
	rg = 'Rip Grep',
	spell = 'Spell',
	copilot = 'Copilot',
	emoji = 'Emoji',
	treesitter = 'Treesitter',
}
cmp.setup({
	experimental = {
		native_menu = false,
		ghost_text = false,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-u>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		['<C-y>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	-- formatting = {
	-- 	format = require('lspkind').cmp_format({
	-- 		mode = 'symbol_text',
	-- 		preset = 'codicons',
	-- 		menu = {
	-- 			buffer = '[Buffer]',
	-- 			nvim_lsp = '[LSP]',
	-- 			nvim_lua = '[API]',
	-- 			path = '[Path]',
	-- 			luasnip = '[Luasnip]',
	-- 			rg = '[Rip Grep]',
	-- 			spell = '[Spell]',
	-- 			copilot = '[Copilot]',
	-- 			emoji = '[Emoji]',
	-- 			treesitter = '[Treesitter]',
	-- 		},
	-- 	}),
	-- },
	formatting = {
		fields = { 'kind', 'abbr', 'menu' },
		format = function(entry, vim_item)
			local kind_length = vim_item.kind:len()
			if persistent_kind_length < kind_length then
				persistent_kind_length = kind_length
			end

			local appended_menu = vim_item.kind .. string.rep(' ', 1 + persistent_kind_length - kind_length)
			local source = source_mapping[entry.source.name] or entry.source.name
			vim_item.menu = appended_menu .. '[' .. source .. ']'
			vim_item.kind = icons[vim_item.kind] or icons['Text']

			return vim_item
		end,
	},
	sources = sources,
	preselect = cmp.PreselectMode.None,
	sorting = {
		priority_weight = 1.0,
		comparators = {
			compare.locality,
			compare.recently_used,
			compare.score,
			compare.offset,
			compare.order,
		},
	},
})
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'path' },
		{ name = 'cmdline' },
	},
})
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' },
	},
})

local npairs = require('nvim-autopairs')

npairs.setup({
	disable_filetype = { 'TelescopePrompt' },
	check_ts = true,
	map_cr = true,
})

local ls = require('luasnip')
local types = require('luasnip.util.types')
ls.config.set_config({
	history = true,
	update_events = 'TextChanged,TextChangedI',
	delete_check_events = 'TextChanged',
	enable_autosnippets = false,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { '<- Choice' } },
			},
		},
	},
})

local mappings = {
	['<c-j>'] = {
		function()
			ls.expand_or_jump()
		end,
		'(Snippet) Expand Snippet or Jump to Next Placeholder',
	},
	['<c-k>'] = {
		function()
			ls.jump(-1)
		end,
		'(Snippet) Jump to Previous Placeholder',
	},
	['<c-l>'] = {
		function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end,
		'(Snippet) Next Choice',
	},
	['<c-h>'] = {
		function()
			if ls.choice_active() then
				ls.change_choice(-1)
			end
		end,
		'(Snippet) Prev Choice',
	},
}

vim.keymap.set('n', '<leader>qs', function()
	local dir = [[$HOME/.config/nvim/lua/snippets/luasnip/]]
	local files = io.popen(string.format([[ls -a "%s"]], dir))
	local filenames = {}
	for filename in files:lines() do
		table.insert(filenames, filename)
	end
	for i, filename in ipairs(filenames) do
		if i ~= 1 and i ~= 2 then
			local str = string.format([[source "%s%s"]], dir, filename)
			vim.cmd(str)
		end
	end
	files:close()
	vim.notify('Snippet reloaded', 'info', { title = 'System' })
end, {})

for key, value in pairs(mappings) do
	vim.keymap.set({ 'i', 's' }, key, value[1], {
		desc = value[2],
		silent = true,
	})
end

require('default.snippets.luasnip')

-- reset spacing on [source] handling
local view = require('cmp.view')
if view.original_close == nil then
	view.original_close = view.close
end
view.close = function(self)
	persistent_kind_length = 0
	view.original_close(self)
end

if pcall(require, 'copilot') then
	vim.api.nvim_create_autocmd('InsertEnter', {
		pattern = '*',
		callback = function()
			vim.schedule(function()
				require('copilot').setup()
			end)
		end,
		once = true,
		desc = 'Load Copilot upon InsertEnter (once)',
	})
end
