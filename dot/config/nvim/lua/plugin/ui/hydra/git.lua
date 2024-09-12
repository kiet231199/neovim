local gitsigns = require('gitsigns')

local git_hint = [[
^
       ██████████         _J_:   Next hunk
     ██ ████ ██       _K_:   Prev hunk
   ██            ██     _h_:   Show edited line
  ███              ███    _H_:   Show deleted line  ^
  ████              ████    _d_:   Open diff current file
  ████              ████    _D_: 󰕚  Open diff view
  ████            ████    _b_: 󰚼  Blame current line
  █████    ███████    _B_:   Show full commit
   ██        ██████     _g_: 󰋚  Show blame history
     ███      ████       _G_: 󱁊  Show git graph
       ██████████         _q_:   Exit
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

local hydra_git = {
	name = 'Git',
	hint = git_hint,
	config = {
		color = 'blue',
		invoke_on_body = true,
		hint = {
			float_opts = {
				-- row, col, height, width, relative, and anchor should not be overridden
				style = "minimal",
				border = border("TelescopePromptBorder"),
				title = { { "  Git  ", "TelescopePromptTitle" } },
				title_pos = "center",
			},
		},
	},
	mode = { 'n', 'x' },
	body = '<leader>g',
	heads = {
		{ 'J',
			function()
				if vim.wo.diff then return ']c' end
				vim.schedule(function() gitsigns.next_hunk() end)
				return '<Ignore>'
			end,
		},
		{ 'K',
			function()
				if vim.wo.diff then return '[c' end
				vim.schedule(function() gitsigns.prev_hunk() end)
				return '<Ignore>'
			end,
		},
		{'h', ':Gitsigns toggle_numhl<CR>:Gitsigns toggle_linehl<CR>', },
		{'H', gitsigns.toggle_deleted, { nowait = true }, },
		{'d', gitsigns.diffthis },
		{'D', ':DiffviewOpen' },
		{'b', gitsigns.toggle_current_line_blame, },
		{'B', function() gitsigns.blame_line { full = true } end, },
		{'g', ':BlameToggle window<CR>' },
		{'G', function() require('gitgraph').draw({}, { all = true, max_count = 200 }) end, },
		{'q', nil, { exit = true, nowait = true } },
	}
}

return hydra_git
