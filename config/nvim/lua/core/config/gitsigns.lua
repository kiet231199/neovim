local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
	print("Error: gitsigns")
	return
end

gitsigns.setup({
	signs = {
		add          = {hl = 'GitSignsAdd'   , text = ' ', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
		change       = {hl = 'GitSignsChange', text = ' ', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
		delete       = {hl = 'GitSignsDelete', text = ' ', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
		topdelete    = {hl = 'GitSignsDelete', text = ' ', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
		changedelete = {hl = 'GitSignsChange', text = ' ', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
		untracked    = {hl = 'GitSignsUntracked', text = '▌ ', numhl='GitSignsUntrackedNr', linehl = 'GitSignsUntrackedLn'},
	},
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		interval = 1000,
		follow_files = true
	},
	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = '     <author>  <author_time:%Y-%m-%d>  <summary>',
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000, -- Disable if file is longer than this (in lines)
	preview_config = {
		-- Options passed to nvim_open_win
		border = 'rounded',
		style = 'minimal',
		relative = 'cursor',
		row = 0,
		col = 1
	},
	yadm = {
		enable = false
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map('n', '<space>hn', function()
		if vim.wo.diff then return ']c' end
			vim.schedule(function() gs.next_hunk() end)
			return '<Ignore>'
		end, {expr=true})

		map('n', '<space>hp', function()
			if vim.wo.diff then return '[c' end
			vim.schedule(function() gs.prev_hunk() end)
			return '<Ignore>'
		end, {expr=true})

		-- Actions
		map({'n', 'v'}, '<space>hs', ':Gitsigns stage_hunk<CR>')
		map({'n', 'v'}, '<space>hr', ':Gitsigns reset_hunk<CR>')
		map('n', '<space>hS', gs.stage_buffer)
		map('n', '<space>hu', gs.undo_stage_hunk)
		map('n', '<space>hR', gs.reset_buffer)
		map('n', '<space>hv', gs.preview_hunk)
		-- map('n', '<space>hb', function() gs.blame_line{full=true} end)
		map('n', '<space>hd', gs.diffthis)
		map('n', '<space>hD', function() gs.diffthis('~') end)
		map('n', '<space>td', gs.toggle_deleted)
		map('n', '<space>tb', gs.toggle_current_line_blame)

		-- Text object
		-- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
	end
})

vim.cmd[[set statusline+=%{get(b:,'gitsigns_status','')}]]
