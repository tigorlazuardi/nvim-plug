if pcall(require, 'fzf-lua') then
	return require('default.plugins.lsp.mappings.fzf')
end

if pcall(require, 'telescope') then
	return require('default.plugins.lsp.mappings.telescope')
end

return require('default.plugins.lsp.mappings.stub')
