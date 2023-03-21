local status_ok, prettyfold = pcall(require, "pretty-fold")
if not status_ok then
	print("Error: pretty-fold")
	return
end

prettyfold.setup({
	-- fill_char = '•',
	fill_char = '━',
	-- Keep the indentation of the content of the fold string.
	keep_indentation = false,
	sections = {
		left = {
			'━ ', function() return string.rep('*', vim.v.foldlevel) end, ' ━┫', 'content', '┣'
			-- 'content',
		},
		right = {
			'┫ ', 'number_of_folded_lines', ': ', 'percentage', ' ┣━━',
			-- ' ', 'number_of_folded_lines', ': ', 'percentage', ' ',
			-- function(config) return config.fill_char:rep(1) end
		}
	},
	remove_fold_markers = false,
	-- Possible values:
	-- -- "delete" : Delete all comment signs from the fold string.
	-- "spaces" : Replace all comment signs with equal number of spaces.
	-- false	: Do nothing with comment signs.
	process_comment_signs = 'spaces',
	-- Comment signs additional to the value of `&commentstring` option.
	-- comment_signs = {},
	-- List of patterns that will be removed from content foldtext section.
	stop_words = {
		'@brief%s*', -- (for C++) Remove '@brief' and all spaces after.
	},
	add_close_pattern = true, -- true, 'last_line' or false
	matchup_patterns = {
		-- ╟─ Start of line ──╭───────╮── "do" ── End of line ─╢
		--                    ╰─ WSP ─╯
		{ '^%s*do$', 'end' }, -- `do ... end` blocks
		-- ╟─ Start of line ──╭───────╮── "if" ─╢
		--                    ╰─ WSP ─╯
		{ '^%s*if', 'end' },
		-- ╟─ Start of line ──╭───────╮── "for" ─╢
		--                    ╰─ WSP ─╯
		{ '^%s*for', 'end' },
		-- ╟─ "function" ──╭───────╮── "(" ─╢
		--                 ╰─ WSP ─╯
		{ 'function%s*%(', 'end' }, -- 'function(' or 'function ('
		{ '{', '}' },
		{ '%(', ')' }, -- % to escape lua pattern char
		{ '%[', ']' }, -- % to escape lua pattern char
	},
	ft_ignore = { 'neorg' },
})
