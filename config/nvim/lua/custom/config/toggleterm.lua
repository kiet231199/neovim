local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	print("Error: toggleterm")
	return
end

toggleterm.setup({
	-- size can be a number or function which is passed the current terminal
	size = function(term)
		if term.direction == "horizontal" then
			return 20
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.5
		end
	end,
	open_mapping = [[<F8>]],
	-- on_create = fun(t: Terminal), -- function to run when the terminal is first created
	-- on_open = fun(t: Terminal), -- function to run when the terminal opens
    -- on_close = fun(t: Terminal), -- function to run when the terminal closes
	hide_numbers = false, -- hide the number column in toggleterm buffers
	shade_filetypes = {},
	autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
	highlights = {
		Normal = {
			link = 'Normal'
			-- guibg = "<VALUE-HERE>",
		},
		NormalFloat = {
			link = 'Normal'
		},
		FloatBorder = {
			link = 'FloatBorder'
			-- guifg = "<VALUE-HERE>",
			-- guibg = "<VALUE-HERE>",
		},
	},
	shade_terminals = false, -- this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
	-- shading_factor = '<number>', -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
	persist_size = true,
	persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
	direction = 'float',
	close_on_exit = true, -- close the terminal window when the process exits
	shell = vim.o.shell, -- change the default shell
	auto_scroll = true, -- automatically scroll to the bottom on terminal output
	-- This field is only relevant if direction is set to 'float'
	float_opts = {
		border = 'rounded',
		width = math.floor(0.8 * vim.fn.winwidth(0)),
		height = math.floor(0.8 * vim.fn.winheight(0)),
		winblend = 3,
	},
	winbar = {
		enabled = true,
		name_formatter = function(term) --  term: Terminal
			return term.name
		end
	},
})

-- Htop
local htop = require("toggleterm.terminal").Terminal:new({
    cmd = 'htop',
	direction = 'float',
	close_on_exit = true,
	float_opts = {
		border = 'rounded',
		width = math.floor(0.7 * vim.fn.winwidth(0)),
		height = math.floor(0.5 * vim.fn.winheight(0)),
	},
	winbar = {
		enabled = true
	}
})
vim.api.nvim_create_user_command("Htop", function()
	if htop:is_focused() == true then
		htop:close()
	else
		htop:open()
	end
end, { nargs = "?" })

-- Lazygit
local lazygit = require("terminal").terminal:new({
    cmd = 'lazygit',
	direction = 'float',
	close_on_exit = true,
	float_opts = {
		border = 'rounded',
		width = math.floor(0.9 * vim.fn.winwidth(0)),
		height = math.floor(0.9 * vim.fn.winheight(0)),
	},
	winbar = {
		enabled = true
	}
})
vim.env["GIT_EDITOR"] = "nvr -cc close -cc split --remote-wait +'set bufhidden=wipe'"
vim.api.nvim_create_user_command("Lazygit", function(args)
    lazygit.cwd = args.args and vim.fn.expand(args.args)
	if lazygit:is_focused() == true then
		lazygit:close()
	else
		lazygit:open()
	end
end, { nargs = "?" })

