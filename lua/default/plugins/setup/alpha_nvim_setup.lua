local ok, alpha = pcall(require, 'alpha')

if not ok then
	return
end

local dashboard = require('alpha.themes.dashboard')
dashboard.section.header.val = {
	[[           .o ,K ,O  '          ]],
	[[         MxKMMMMMMMNMW.o,       ]],
	[[      lMWMM0o:XMMX:o0MMMdlo     ]],
	[[    oMMMX,    cMMl    ,KMMd;'   ]],
	[[  .0KMMMk.    kMMO.   .xMMMM.   ]],
	[[  ,kMMXMMMMONMKxx0MWOMMMMXMMMx  ]],
	[[  cMMx  .lMM0      OMMl.  dMMx; ]],
	[[ :XMM:    NM.       MW    ;MM:  ]],
	[[  :MMx  .lMMO      OMMl.  dMMk; ]],
	[[  ;kMMXMMMMOWM0xx0MWOMMMMXMMMd  ]],
	[[  .KKMMMk.   .kMMO.   .xMMMM.   ]],
	[[    oMMMX,    cMMl    'KMMd;,   ]],
	[[      lMMMM0l:KMMX:lOMMMxlo     ]],
	[[         MkKMMMMMMMNMW.d,       ]],
	[[           .o ;K ;O  '          ]],
}
dashboard.section.buttons.val = {
	dashboard.button('e', '  New Empty Buffer', ':ene <BAR> startinsert <CR>'),
	dashboard.button('f', '  Find File', ':Telescope find_files<cr>'),
	dashboard.button('g', '  Find Word', ':Telescope live_grep<cr>'),
	dashboard.button('c', '  Change Directory', ':lua require("personal.telescope.cd")()<cr>'),
	dashboard.button('o', '  Recently Opened Files', ':Telescope oldfiles<cr>'),
	dashboard.button('p', '  Recent Projects', ':Telescope projects<cr>'),
	dashboard.button('s', '  Load Session', ':SessionManager load_session<cr>'),
	dashboard.button('S', '  Load Last Session', ':SessionManager load_last_session<cr>'),
	dashboard.button('d', '  Load Dir Session', ':SessionManager load_current_dir_session<cr>'),
	dashboard.button('q', '  Quit NVIM', ':qa<CR>'),
}
if vim.fn.executable('fortune') == 1 then
	local handle = io.popen('fortune')
	assert(handle, 'failed to execute fortune')
	local fortune = handle:read('*a')
	handle:close()
	dashboard.section.footer.val = fortune
end
dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
