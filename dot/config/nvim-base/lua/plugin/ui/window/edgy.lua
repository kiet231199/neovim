local status_ok, edgy = pcall(require, "edgy")
if not status_ok then
	print("Error: edgy")
	return
end

edgy.setup({
	left = {
		{
			title = "Neo-Tree",
			ft = "neo-tree",
			filter = function(buf)
				return vim.b[buf].neo_tree_source == "filesystem"
			end,
			size = { height = 0.5 },
		},
		{
			title = "Neo-Tree Git",
			ft = "neo-tree",
			filter = function(buf)
				return vim.b[buf].neo_tree_source == "git_status"
			end,
			pinned = true,
			open = "Neotree position=right git_status",
		},
		{
			title = "Neo-Tree Doccuments Symbols",
			ft = "neo-tree",
			filter = function(buf)
				return vim.b[buf].neo_tree_source == "document_symbols"
			end,
			pinned = true,
			open = "Neotree position=top document_symbols",
		},
		"neo-tree",
	},
	bottom = {
		{
			title = "Trouble",
			ft = "Trouble",
			size = { height = 0.3 }
		},
	},
	right = {
		{
			title = "Help",
			ft = "help",
			size = { width = 0.5 },
			-- only show help buffers
			filter = function(buf)
				return vim.bo[buf].buftype == "help"
			end,
		},
		{
			title = "Outline",
			ft = "lspsagaoutline",
		},
	},
	top = {},
	options = {
		left = { size = 50 },
		bottom = { size = 15 },
		right = { size = 40 },
		top = { size = 10 },
	},
	-- edgebar animations
	animate = {
		enabled = true,
		fps = 60, -- frames per second
		cps = 120, -- cells per second
		on_begin = function()
			vim.g.minianimate_disable = false
		end,
		on_end = function()
			vim.g.minianimate_disable = false
		end,
		-- Spinner for pinned views that are loading.
		-- if you have noice.nvim installed, you can use any spinner from it, like:
		-- spinner = require("noice.util.spinners").spinners.circleFull,
		spinner = {
			frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
			interval = 80,
		},
	},
	-- enable this to exit Neovim when only edgy windows are left
	exit_when_last = true,
	-- global window options for edgebar windows
	wo = {
		-- Setting to `true`, will add an edgy winbar.
		-- Setting to `false`, won't set any winbar.
		-- Setting to a string, will set the winbar to that string.
		winbar = true,
		winfixwidth = false,
		winfixheight = false,
		winhighlight = "WinBar:EdgyWinBar,Normal:EdgyNormal",
		spell = false,
		signcolumn = "no",
	},
	-- buffer-local keymaps to be added to edgebar buffers.
	-- Existing buffer-local keymaps will never be overridden.
	-- Set to false to disable a builtin.
	keys = {
		-- close window
		["q"] = function(win)
			win:close()
		end,
		-- close sidebar
		["Q"]         = function(win)
			win.view.edgebar:close()
		end,
		-- decrease width
		["<c-right>"] = function(win)
			win:resize("width", 2)
		end,
		-- decrease width
		["<c-left>"] = function(win)
			win:resize("width", -2)
		end,
		-- increase height
		["<c-up>"] = function(win)
			win:resize("height", 2)
		end,
		-- decrease height
		["<c-down"] = function(win)
			win:resize("height", -2)
		end,
		-- reset all custom sizing
		["<c-space>"] = function(win)
			win.view.edgebar:equalize()
		end,
		-- Disable default mappings
		["<c-q>"]     = false,
		["]w"]        = false,
		["[w"]        = false,
		["]W"]        = false,
		["[W"]        = false,
		["<c-w>>"]    = false,
		["<c-w><lt>"] = false,
		["<c-w>+"]    = false,
		["<c-w>-"]    = false,
		["<c-w>="]    = false,
	},
	icons = {
		closed = " ",
		open = " ",
	},
})
