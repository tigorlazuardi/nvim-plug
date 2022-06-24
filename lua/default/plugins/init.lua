------------- Start Plugs -------------
vim.cmd([[call plug#begin()]])
------ Plug plugins here ----------

-- base dependency used by many plugins
vim.cmd([[
	Plug 'nvim-lua/plenary.nvim'
	Plug 'MunifTanjim/nui.nvim'
]])

-- Treesitter based plugins
vim.cmd([[
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	Plug 'nvim-treesitter/nvim-treesitter-textobjects'
	Plug 'p00f/nvim-ts-rainbow'
	Plug 'lewis6991/spellsitter.nvim'
	" Plug 'romgrk/nvim-treesitter-context'
	Plug 'windwp/nvim-ts-autotag'
	Plug 'RRethy/nvim-treesitter-endwise'
	Plug 'nvim-treesitter/playground'

	Plug 'abecodes/tabout.nvim'

	Plug 'SmiteshP/nvim-gps'
	Plug 'mizlan/iswap.nvim'

	" Treesitter Comment
	Plug 'numToStr/Comment.nvim'
	Plug 'JoosepAlviste/nvim-ts-context-commentstring', { 'for': ['typescriptreact', 'javascriptreact'] }
]])

-- Catppuccin Theme
vim.cmd([[
	Plug 'catppuccin/nvim', {'as': 'catppuccin'}
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
]])

-- Neo Tree
vim.cmd([[
	Plug 'nvim-neo-tree/neo-tree.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 's1n7ax/nvim-window-picker'
]])

-- Bufferline
vim.cmd([[
	Plug 'akinsho/nvim-bufferline.lua'
	Plug 'kyazdani42/nvim-web-devicons'
]])

-- clipboard management
vim.cmd([[
	Plug 'gbprod/cutlass.nvim'
	Plug 'tversteeg/registers.nvim'
	Plug 'gbprod/substitute.nvim'
]])

-- search engines
vim.cmd([[
	Plug 'ibhagwan/fzf-lua'
	Plug 'kyazdani42/nvim-web-devicons'

	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
	Plug 'ahmedkhalf/project.nvim'
	Plug 'Shatur/neovim-session-manager'
	Plug 'LinArcX/telescope-env.nvim'
	Plug 'folke/trouble.nvim'
]])

if vim.fn.exepath('sk') == '' and vim.fn.exepath('fzf') == '' then
	-- don't plug fzf plugin if dependencies are available on os
	vim.cmd([[
		Plug 'junegunn/fzf', {'do': './install --bin'}
	]])
end

-- Textobjects
vim.cmd([[
	Plug 'kana/vim-textobj-user'
	Plug 'sgur/vim-textobj-parameter'
	Plug 'whatyouhide/vim-textobj-xmlattr'
	Plug 'Julian/vim-textobj-variable-segment'
	Plug 'kana/vim-textobj-line'
	Plug 'kana/vim-textobj-entire'
]])

-- Git
vim.cmd([[
	Plug 'lewis6991/gitsigns.nvim'
]])

-- golang integration
vim.cmd([[
	Plug 'ray-x/go.nvim', {'for': ['go', 'gosum', 'gomod']}
	Plug 'ray-x/guihua.lua', {'for': ['go', 'gosum', 'gomod']}
]])

-- godot integration
if vim.fn.exepath('godot') ~= '' then
	vim.cmd([[
		Plug 'habamax/vim-godot', {'for': ['gd', 'gdscript', 'gdscript3']}
	]])
end

local function get_userid()
	local handle = io.popen('id -u')
	if handle == nil then
		return ''
	end
	local result = handle:read('*all')
	handle:close()
	return result:gsub('\n', '')
end

-- nvim-notify works like shit when using elevated accounts on linux.
if get_userid() ~= '0' then
	vim.cmd([[
		Plug 'rcarriga/nvim-notify'
	]])
end

-- completion and snippet
vim.cmd([[
	Plug 'hrsh7th/nvim-cmp'
	Plug 'L3MON4D3/LuaSnip',
	Plug 'f3fora/cmp-spell',
	Plug 'hrsh7th/cmp-buffer',
	Plug 'hrsh7th/cmp-emoji',
	Plug 'ray-x/cmp-treesitter',
	Plug 'hrsh7th/cmp-nvim-lsp',
	Plug 'hrsh7th/cmp-path',
	Plug 'hrsh7th/cmp-nvim-lua',
	Plug 'lukas-reineke/cmp-rg',
	Plug 'hrsh7th/cmp-nvim-lsp-signature-help',
	" Plug 'onsails/lspkind-nvim',
	Plug 'rafamadriz/friendly-snippets',
	Plug 'saadparwaiz1/cmp_luasnip',
	Plug 'windwp/nvim-autopairs',
	" Plug 'mortepau/codicons.nvim',
	Plug 'hrsh7th/cmp-cmdline',
	Plug 'zbirenbaum/copilot-cmp'
	Plug 'zbirenbaum/copilot.lua'
]])

local copilot_cred_exist = (function()
	local util = require('personal.util')
	local loc = '$HOME/.config/github-copilot/hosts.json'
	if util.is_windows then
		loc = '$HOME/AppData/Local/github-copilot/hosts.json'
	end
	return loc
end)()

if not copilot_cred_exist then
	vim.cmd([[
		Plug 'github/copilot.vim'
	]])
end

---------------- LSP ---------------
vim.cmd([[
	Plug 'neovim/nvim-lspconfig'
	Plug 'ray-x/lsp_signature.nvim'
	Plug 'folke/lua-dev.nvim'
	Plug 'folke/lsp-colors.nvim'
	Plug 'nvim-lua/lsp_extensions.nvim'
	Plug 'b0o/schemastore.nvim'
	Plug 'kosayoda/nvim-lightbulb'
	Plug 'williamboman/nvim-lsp-installer'
	Plug 'j-hui/fidget.nvim'
	Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
	Plug 'b0o/schemastore.nvim'
	Plug 'simrat39/rust-tools.nvim'
]])

-------------- Null LS -----------------
vim.cmd([[
	Plug 'jose-elias-alvarez/null-ls.nvim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-lua/plenary.nvim'
]])

-- User interface
vim.cmd([[
	Plug 'stevearc/dressing.nvim'
]])

-- other plugins
vim.cmd([[
	" Dashboard
	Plug 'goolord/alpha-nvim'

	" Discord presence
	Plug 'andweeb/presence.nvim'

	" Filetype detection
	Plug 'nathom/filetype.nvim'

	" Auto window management
	Plug 'beauwilliams/focus.nvim'

	" Markdown
	Plug 'ellisonleao/glow.nvim', {'for': 'markdown'}
	Plug 'davidgranstrom/nvim-markdown-preview', {'for': 'markdown'}

	" Delete buffer without changing layout
	Plug 'famiu/bufdelete.nvim'

	" Move lines by Alt and hjkl button
	Plug 'booperlv/nvim-gomove',

	" Move with s key.
	Plug 'rlane/pounce.nvim'

	" Search and Replace
	Plug 'windwp/nvim-spectre'

	Plug 'aserowy/tmux.nvim'

	Plug 'akinsho/nvim-toggleterm.lua'

	Plug 'folke/todo-comments.nvim'
]])

-- scrollbars
vim.cmd([[
	Plug 'petertriho/nvim-scrollbar'
	Plug 'kevinhwang91/nvim-hlslens'
	Plug 'folke/tokyonight.nvim'
]])

vim.g.sandwich_no_default_key_mapping = 1
-- sandwich
vim.cmd([[
	" Replace pairs
	Plug 'machakann/vim-sandwich'
]])

vim.cmd([[call plug#end()]])
------------- End Plugs -------------

----- Call all setup configs -----
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
----- Call all setup configs -----

vim.keymap.set('n', '<leader>pi', '<cmd>PlugInstall<cr>', { desc = 'Install Plugins' })
vim.keymap.set('n', '<leader>pu', '<cmd>PlugUpdate<cr>', { desc = 'Update Plugins' })
vim.keymap.set('n', '<leader>pU', '<cmd>PlugUpgrade<cr>', { desc = 'Upgrade Plugins' })
vim.keymap.set('n', '<leader>pl', '<cmd>PlugClean<cr>', { desc = 'Clean Plugins' })
vim.keymap.set('n', '<leader>ps', '<cmd>PlugStatus<cr>', { desc = 'Fetch Plugins' })
