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

local fn = vim.fn
local marginTopPercent = 0.15
local marginBotPercent = 0.2
local headerPadding = fn.max { 2, fn.floor(fn.winheight(0) * marginTopPercent) }
local footerPadding = fn.max { 2, fn.floor(fn.winheight(0) * marginTopPercent) }

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
		},
	},

	buttons = {
		type = "group",
		val = {
			-- button("n", "ﱐ  New File  ", "lua require'startup'.new_file()"),
			button("f", "  File Search  ", ":Telescope find_files prompt_prefix=🔍 <CR>"),
			button("p", "  Project Search  ", ":Telescope project prompt_prefix=🔍 <CR>"),
			button("w", "  Word Search  ", ":Telescope live_grep prompt_prefix=🔍 <CR>"),
			button("o", "  Old File  ", ":Telescope oldfiles prompt_prefix=🔍 <CR>"),
			button("b", "  Browser  ", ":Telescope file_browser prompt_prefix=🔍 <CR>"),
			button("c", "  Colorscheme  ", ":Telescope colorscheme prompt_prefix=🔍 <CR>"),
			button("m", "  Bookmarks  ", ":Telescope marks prompt_prefix=🔍 <CR>"),
			button("s", "  Settings", ":e ~/.config/nvim/lua/options.lua<CR>"),
			button("q", "  Quit Neovim", ":qa<CR>"),
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
		},
	},

	headerPaddingTop = { type = "padding", val = headerPadding },
	headerPaddingMid= { type = "padding", val = 2 },
	headerPaddingBottom = { type = "padidng", val = footerPadding },
}


alpha.setup {
	layout = {
		options.headerPaddingTop,
		options.header,
		options.headerPaddingMid,
		options.buttons,
		options.headerPaddingMid,
		options.footer,
		options.footerPaddingBottom,
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
