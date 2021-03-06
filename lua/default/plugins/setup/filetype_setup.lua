local ok, filetype = pcall(require, 'filetype')

if not ok then
	return
end

-- config opts: https://github.com/nathom/filetype.nvim#customization
filetype.setup({
	overrides = {
		extensions = {
			mdpp = 'markdown',
		},
		literal = {
			['tsconfig.json'] = 'jsonc',
			['jsconfig.json'] = 'jsonc',
			['mods.txt'] = 'javascript', -- rpgmaker mods.txt
			['.rtorrent.rc'] = 'config',
			['smb.conf'] = 'samba',
		},
		complex = {
			['%.vscode/launch%.json'] = 'jsonc',
			['nginx/.*%.conf'] = 'nginx',
			['openvpn/.*%.conf'] = 'config',
			['.*%.env'] = 'sh', -- dotenv files
		},
	},
})
