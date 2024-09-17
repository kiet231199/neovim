local dap = require('dap')
local dapui = require('dapui')
local widgets = require('dap.ui.widgets')
local dappb = require('persistent-breakpoints')
local cmd = require('hydra.keymap-util').cmd

local dap_hint = [[
^
                                 ^
  _<Up>_ _<Down>_ _<Left>_ _<Right>_ _<Enter>_
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

local dap_hydra = {
	name = 'Debugger',
	hint = dap_hint,
	config = {
		desc = 'Debugger',
		color = 'blue',
		invoke_on_body = true,
		hint = {
			position = "middle-right",
			float_opts = {
				-- row, col, height, width, relative, and anchor should not be overridden
				style = "minimal",
				border = border("TelescopePromptBorder"),
				title = { { " Debug Console ", "TelescopePromptTitle" } },
				title_pos = "center",
			},
		},
	},
	mode = { 'n', 'x' },
	body = '<leader>d',
	heads = {
		{ '<Up>', cmd 'echo "Hello"' },
		{ '<Down>', cmd 'echo "Hello"' },
		{ '<Left>', cmd 'echo "Hello"' },
		{ '<Right>', cmd 'echo "Hello"' },
		{ '<Enter>', cmd 'echo "Hello"' },
	}
}

return dap_hydra

