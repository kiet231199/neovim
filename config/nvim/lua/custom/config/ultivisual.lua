local status_ok, ultivisual = pcall(require, "nvim-ultivisual")
if not status_ok then
	print("Error: ultivisual")
	return
end

ultivisual.setup({
	-- You can switch the ultimate visual features.
	features = {
		indent = true,
		brackets = true,
		paste = false,
	},

	-- The keymap settings for features here.
	-- key; mapped key
	-- modes; included mode (include Visual mode for ultimate features!)
	keymaps = {
		make_indent = {
			key = '<TAB>',
			modes = { 'v', 'n' }, -- 'v'; visual, 'n'; normal, 'i'; insert
		},

		delete_indent = {
			key = '<S-TAB>',
			modes = { 'v', 'n' }, -- 'v'; visual, 'n'; normal, 'i'; insert
		},

		brackets = {
			-- Only for 'v'; visual mode.
			-- You can config the brackets' shape whatever you want.
			{ key = '(', shapes = { '(', ')' } },
			{ key = '{', shapes = { '{', '}' } },
			{ key = '[', shapes = { '[', ']' } },
		},
	},

	-- The option settings for features here.
	options = {
		brackets = {
			-- Ignore the first line's indent when included while making brackets.
			ignore_indent = true,
		},
	},
})
