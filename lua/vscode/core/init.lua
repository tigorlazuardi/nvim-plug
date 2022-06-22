require('vscode.core.clipboard')
require('vscode.core.backup')

-- ignore case sensitivity for search.
vim.cmd([[set ignorecase]])

-- set the default tabstop to 4.
vim.cmd('set autoindent noexpandtab tabstop=4 shiftwidth=4 softtabstop=-1')

-- disable background buffer for vscode-neovim
-- vim.cmd('set nohidden')

-- disable annoying shada
vim.cmd([[set shada="NONE"]])
