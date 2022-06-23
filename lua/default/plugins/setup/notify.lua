local ok_notify, notify = pcall(require, 'notify')

if not ok_notify then
	return
end

vim.notify = notify

local ok_telescope, telescope = pcall(require, 'telescope')
if not ok_telescope then
	return
end

telescope.load_extension('notify')
