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

-- Hydra highlight group
vim.api.nvim_set_hl(0, "HydraGitBorder", { fg = "#e0af68", bg = "#1a1b26" })
vim.api.nvim_set_hl(0, "HydraGitTitle",  { fg = "#1a1b26", bg = "#e0af68" })

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
	name = 'Git (Hydra ))',
	hint = git_hint,
	config = {
		color = 'pink',
		invoke_on_body = true,
		hint = {
			float_opts = {
				-- row, col, height, width, relative, and anchor should not be overridden
				style = "minimal",
				border = border("HydraGitBorder"),
				title = { { "    Hydra Git  ", "HydraGitTitle" } },
				title_pos = "center",
			},
		},
	},
	mode = { 'n', 'x' },
	body = '<leader>g',
	heads = {
		{
			'J',
			function()
				if vim.wo.diff then return ']c' end
				vim.schedule(function() gitsigns.nav_hunk("next") end)
				return '<Ignore>'
			end,
		},
		{
			'K',
			function()
				if vim.wo.diff then return '[c' end
				vim.schedule(function() gitsigns.nav_hunk("prev") end)
				return '<Ignore>'
			end,
		},
		{'h', ':Gitsigns toggle_numhl<CR>:Gitsigns toggle_linehl<CR>' },
		{'H', gitsigns.toggle_deleted, { nowait = true }, },
		{'d', gitsigns.diffthis, { exit = true } },
		{'D', ':DiffviewOpen<CR>', { exit = true } },
		{'b', gitsigns.toggle_current_line_blame, },
		{'B', function() gitsigns.blame_line { full = true } end, },
		{'g', ':BlameToggle window<CR>', { exit = true } },
		{'G', function() require('gitgraph').draw({}, { all = true, max_count = 200, exit = true }) end, },
		{'q', nil, { exit = true, nowait = true } },
	}
}

return hydra_git
