local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local function button(sc, txt, keybind)
	local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

	local opts = {
		position = "center",
		text = txt,
		shortcut = sc,
		cursor = 5,
		width = 30,
		align_shortcut = "right",
		hl = "String",
	}

	if keybind then
		opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
	end

	return {
		type = "button",
		val = txt,
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
			vim.api.nvim_feedkeys(key, "normal", false)
		end,
		opts = opts,
	}
end

local spacing = 3
local margin = function()
	-- 12 for header and footer, 10 for buttons, 2 * spacing for middle space
	local temp = vim.fn.floor((vim.fn.winheight(0) - 12 - 10 - 2 * spacing) / 2)
	while temp <= 0 do
		spacing = spacing - 1
		temp = vim.fn.floor((vim.fn.winheight(0) - 12 - 10 - 2 * spacing) / 2)
	end
	return temp
end

local options = {
	header = {
		type = "text",
		val = {
			" ██████╗   ████████╗        ████████╗ ███████╗    ███╗     ████████╗ ██╗   ██╗ ██████╗   ███████╗",
			" ██╔═══██╗ ╚════██╔╝        ██╔═════╝ ██╔════╝  ██═══██╗   ╚══██╔══╝ ██║   ██║ ██╔═══██╗ ██╔════╝",
			" ██████══╝   ╔██╔═╝  █████╗ ██████╗   █████╗   █████████╗     ██║    ██║   ██║ ██████══╝ █████╗  ",
			" ██╔══██╗  ╔██╔═╝    ╚════╝ ██╔═══╝   ██╔══╝   ██╔════██║     ██║    ██║   ██║ ██╔══██╗  ██╔══╝  ",
			" ██║   ██╗ ████████╗        ██║       ███████╗ ██║    ██║     ██║    ╚██████╔╝ ██║   ██╗ ███████╗",
			" ╚═╝   ╚═╝ ╚═══════╝        ╚═╝       ╚══════╝ ╚═╝    ╚═╝     ╚═╝     ╚═════╝  ╚═╝   ╚═╝ ╚══════╝",
		},
		opts = {
			position = "center",
			hl = "Statement",
			spacing = 0,
		},
	},

	buttons = {
		type = "group",
		val = {
			button("n", "ﱐ  New File  ", ":ene<CR>"),
			button("f", "󰈞  File Search  ", ":Telescope find_files prompt_prefix=🔍 <CR>"),
			button("p", "󱘶  Project Search  ", ":Telescope project prompt_prefix=🔍 <CR>"),
			button("w", "󱎸  Word Search  ", ":Telescope live_grep prompt_prefix=🔍 <CR>"),
			button("o", "󱘞  Old File  ", ":Telescope oldfiles prompt_prefix=🔍 <CR>"),
			button("b", "  Browser  ", ":Telescope file_browser prompt_prefix=🔍 <CR>"),
			button("c", "󱈇  Colorscheme  ", ":Telescope colorscheme prompt_prefix=🔍 <CR>"),
			button("m", "󱤇  Bookmarks  ", ":Telescope marks prompt_prefix=🔍 <CR>"),
			button("s", "  Settings", ":e ~/.config/nvim/lua/options.lua<CR>"),
			button("q", "  Quit Neovim", ":qa<CR>"),
		},
		opts = {
			spacing = 0,
		},
	},

	footer = {
		type = "text",
		val = {
			" ██╗   ██╗ ██╗ ███████╗ ████████╗   ███████╗  ██╗   ██╗    ███╗    ███╗   ███╗",
			" ██║ ██╔═╝ ██║ ██╔════╝ ╚══██╔══╝   ██║   ██╗ ██║   ██║  ██═══██╗  ████╗ ████║",
			" ████══╝   ██║ █████╗      ██║      ██████╔═╝ ████████║ █████████╗ ██╔████╔██║",
			" ██╔═██╗   ██║ ██╔══╝      ██║      ██╔═══╝   ██╔═══██║ ██╔════██║ ██║╚██╔╝██║",
			" ██║ ╚═██╗ ██║ ███████╗    ██║      ██║       ██║   ██║ ██║    ██║ ██║ ╚═╝ ██║",
			" ╚═╝   ╚═╝ ╚═╝ ╚══════╝    ╚═╝      ╚═╝       ╚═╝   ╚═╝ ╚═╝    ╚═╝ ╚═╝     ╚═╝",
		},
		opts = {
			position = "center",
			hl = "Statement",
			spacing = 0,
		},
	},

	topPad = { type = "padding", val = margin },
	midPad = { type = "padding", val = spacing },
	botPad = { type = "padding", val = margin },
}

alpha.setup {
	layout = {
		options.topPad,
		options.header,
		options.midPad,
		options.buttons,
		options.midPad,
		options.footer,
		options.botPad,
	},
	opts = {},
}

-- Disable statusline in dashboard
vim.api.nvim_create_autocmd("FileType", {
	pattern = "alpha",
	callback = function()
	-- store current statusline value and use that
	local old_laststatus = vim.opt.laststatus
	vim.api.nvim_create_autocmd("BufUnload", {
		buffer = 0,
		callback = function()
		vim.opt.laststatus = old_laststatus
		end,
	})
	vim.opt.laststatus = 0
	end,
})
