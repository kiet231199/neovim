local cmd = require('hydra.keymap-util').cmd
local Snacks = require("snacks")

local picker_hint = [[
^
          ███         _d_:   Diagnostic     _j_:   Jumps
       ████████         _n_: 󰎟  Notification   _m_:   Marks
    █████████       _t_: 󱦞  Buffer lists   _q_:   Qflist
    ███████████       _p_:   Projects       _u_:   Undo            ^
  ███████████       _r_:   Registers      _b_:   Git branches
  ███████           _c_:   Commands       _l_:   Git log
        █                 _h_:   Highlights     _L_:   Git log (line)
     █████             _i_:   Icons          _s_:   Git status
  󰓒   █        󰥺
      █              _<Esc>_:  Exit
^
]]

-- Hydra highlight group
vim.api.nvim_set_hl(0, "HydraPickerBorder", { fg = "#bb9af7", bg = "#1a1b26" })
vim.api.nvim_set_hl(0, "HydraPickerTitle",  { fg = "#1a1b26", bg = "#bb9af7" })

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

local hydra_picker = {
	name = 'Picker (Hydra ))',
	hint = picker_hint,
	mode = 'n',
	body = '<Leader>p',
	config = {
		color = 'blue',
		invoke_on_body = true,
		hint = {
			position = "middle",
			float_opts = {
				-- row, col, height, width, relative, and anchor should not be overridden
				style = "minimal",
				border = border("HydraPickerBorder"),
				title = { { "   Snacks Picker  ", "HydraPickerTitle" } },
				title_pos = "center",
			},
		},
	},
	heads = {
		{ 'd', function() Snacks.picker.diagnostics() end },
		{ 'n', function() Snacks.picker.notifications() end },
		{ 't', function() Snacks.picker.grep_buffers() end },
		{ 'p', function() Snacks.picker.projects() end },
		{ 'r', function() Snacks.picker.registers() end },
		{ 'c', function() Snacks.picker.commands() end },
		{ 'h', function() Snacks.picker.highlights() end },
		{ 'i', function() Snacks.picker.icons() end },
		{ 'j', function() Snacks.picker.jumps() end },
		{ 'm', function() Snacks.picker.marks() end },
		{ 'q', function() Snacks.picker.qflist() end },
		{ 'u', function() Snacks.picker.undo() end },
		{ 'b', function() Snacks.picker.git_branches() end },
		{ 'l', function() Snacks.picker.git_log() end },
		{ 'L', function() Snacks.picker.git_log_line() end },
		{ 's', function() Snacks.picker.git_status() end },
		{ '<Esc>', nil, { exit = true, nowait = true } },
	}
}

return hydra_picker

