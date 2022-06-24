local util = {}

-- selene: allow(undefined_global)
if jit ~= nil then
	util.is_windows = jit.os == 'Windows'
else
	util.is_windows = package.config:sub(1, 1) == '\\'
end

util.get_separator = function()
	if util.is_windows then
		return '\\'
	end
	return '/'
end

util.join_paths = function(...)
	local separator = util.get_separator()
	return table.concat({ ... }, separator)
end

local default_map_opts = {
	mode = { 'n' },
	silent = true,
}

util.register_mapping = function(maps, opts)
	opts = opts or {}
	local map_args = vim.tbl_extend('keep', opts, default_map_opts)
	map_args.mode = nil
	for key, value in pairs(maps) do
		if value[2] then
			local s_opts = vim.tbl_extend('force', map_args, { desc = value[2] })
			vim.keymap.set(opts.mode or 'n', key, value[1], s_opts)
		else
			vim.keymap.set(opts.mode or 'n', key, value[1], map_args)
		end
	end
end

return util
