local cmd = require('hydra.keymap-util').cmd

local dap_hint = [[
^
      ██ ██     _<F1>_ :  Toggle UI          _<F2>_   : 󱔏 Toggle virtual text
   ███████████  _<F3>_ :  Open watches       _<F4>_   :  Open preview
      ███████     _<F5>_ :  Continue           _<F6>_   :  Stop
   █ ███████████ █  _<F7>_ : 󰼧 Next breakpoints   _<F8>_   : 󰒮 Prev breakpoints
    █████   _<F9>_ : ⭕Toggle breakpoint  _<F10>_  :  Step over
    █████████   _<F11>_:  Step into          _<F12>_  :  Step out
       ███      _<BS>_ :  Clear breakpoints  _<Enter>_:  Set conditional breakpoints  
                  _<Esc>_:  Exit               _<Space>_:  Run to cursor
^
]]

-- Hydra highlight group
vim.api.nvim_set_hl(0, "HydraDebuggerBorder", { fg = "#bb9af7", bg = "#1a1b26" })
vim.api.nvim_set_hl(0, "HydraDebuggerTitle",  { fg = "#1a1b26", bg = "#bb9af7" })

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

local watch_opts = { title = " Watches", width = 100, height = 15, position = "center", enter = true }
local dap_hydra = {
	name = 'Debugger (Hydra ))',
	hint = dap_hint,
	config = {
		color = 'pink',
		invoke_on_body = true,
		hint = {
			float_opts = {
				-- row, col, height, width, relative, and anchor should not be overridden
				style = "minimal",
				border = border("HydraDebuggerBorder"),
				title = { { " Debug Console ", "HydraDebuggerTitle" } },
				title_pos = "center",
			},
		},
	},
	mode = { 'n' },
	body = '<leader>d',
	heads = {
		{ '<F1>', function() require('dapui').toggle() end },
		{ '<F2>', cmd "DapVirtualTextToggle" },
		{ '<F3>', function() require("dapui").float_element("watches", watch_opts) end },
		{ '<F4>', function() require("dap.ui.widgets").hover() end },
		{ '<F5>', cmd 'DapContinue' },
		{ '<F6>', cmd 'DapTerminate' },
		{ '<F7>', function() require('goto-breakpoints').prev() end },
		{ '<F8>', function() require('goto-breakpoints').next() end },
		{ '<F9>', function() require('persistent-breakpoints.api').toggle_breakpoint() end },
		{ '<F10>', cmd 'DapStepOver' },
		{ '<F11>', cmd 'DapStepInto' },
		{ '<F12>', cmd 'DapStepOut' },
		{ '<Enter>', function() require('persistent-breakpoints.api').set_conditional_breakpoint(vim.fn.input(' CONDITION    ')) end },
		{ '<BS>', function() require('persistent-breakpoints.api').toggle_breakpoint() end },
		{ '<Space>', function() require("dap").run_to_cursor() end },
		{ '<Esc>', nil, { exit = true, nowait = true } },
	}
}

return dap_hydra

