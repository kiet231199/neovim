local cmd = require('hydra.keymap-util').cmd

local tele_hint = [[
^
          ███        _w_: 󱎸 Word grep           _h_: 󰈊 Highlights  ^
       ████████        _f_: 󰥨 File browser        _m_: 󰮦 Manual
    █████████      _p_:  Projects            _k_:  Keymaps
    ███████████      _g_: 󰊢 Git commits         _n_:  Noice
  ███████████      _b_:  Dap breakpoints
  ███████          _d_: 󰨮 Diagnostics
        █                _c_: 󱘟 Clipboard
     █████            _t_:  Todo list
  󰓒   █        󰥺
      █              _<Tab>_: 󱦞 List buffers    _<Esc>_:  Exit
^
]]

local function border(hl_name)
    return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
    }
end

local hydra_telescope = {
	name = 'Telescope',
	hint = tele_hint,
	mode = 'n',
	body = '<Leader>f',
	config = {
		color = 'blue',
		invoke_on_body = true,
		hint = {
			position = "middle",
			float_opts = {
				-- row, col, height, width, relative, and anchor should not be overridden
				style = "minimal",
				border = border("TelescopePreviewBorder"),
				title = { { "  Telescope  ", "TelescopePreviewTitle" } },
				title_pos = "center",
			},
		},
	},
	heads = {
		{ 'w',     cmd 'Telescope live_grep' },
		{ 'f',     cmd 'Telescope find_files' },
		{ 'p',     cmd 'Telescope project',  },
		{ 'g',     cmd 'Telescope git_commits',  },
		{ 'b',     cmd 'Telescope dap list_breakpoints',  },
		{ 'd',     cmd 'Telescope diagnostics',  },
		{ 'c',     cmd 'Telescope neoclip unnamed extra=star,plus,a,b',  },
		{ 't',     cmd 'TodoTelescope',  },
		{ 'h',     cmd 'Telescope highlights', },
		{ 'm',     cmd 'Telescope help_tags', },
		{ 'k',     cmd 'Telescope keymaps', },
		{ 'n',     cmd 'Telescope noice', },
		{ '<Tab>', cmd 'Telescope buffers', },
		{ '<Esc>', nil, { exit = true, nowait = true } },
	}
}

return hydra_telescope
