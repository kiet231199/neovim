local status_ok, edgy = pcall(require, "edgy")
if not status_ok then
	print("Error: edgy")
	return
end

edgy.setup({
	left = {
		{
			ft = "NvimTree",
			title = "Nvim-tree",
			size = { width = 50 },
		},
	},
	bottom = {
		{
			"Trouble",
			title = "Trouble",
			size = { height = vim.fn.winheight(0) * 0.3 }
		},
	},
	right = {
		{
			ft = "help",
			title = "Help",
			size = { width = vim.fn.winwidth(0) * 0.5 },
			-- only show help buffers
			filter = function(buf)
				return vim.bo[buf].buftype == "help"
			end,
		},
		{
			ft = "lspsagaoutline",
			title = "Outline",
			size = { width = 40 },
		},
	},
	top = {},
	options = {
		left = { size = 30 },
		bottom = { size = 10 },
		right = { size = 30 },
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
		winfixwidth = true,
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
		-- hide window
		["<c-q>"] = function(win)
			win:hide()
		end,
		-- close sidebar
		["Q"] = function(win)
			win.view.edgebar:close()
		end,
		-- next open window
		["]w"] = function(win)
			win:next({ visible = true, focus = true })
		end,
		-- previous open window
		["[w"] = function(win)
			win:prev({ visible = true, focus = true })
		end,
		-- next loaded window
		["]W"] = function(win)
			win:next({ pinned = false, focus = true })
		end,
		-- prev loaded window
		["[W"] = function(win)
			win:prev({ pinned = false, focus = true })
		end,
	},
	icons = {
		closed = " ",
		open = " ",
	},
	-- enable this on Neovim <= 0.10.0 to properly fold edgebar windows.
	-- Not needed on a nightly build >= June 5, 2023.
	fix_win_height = vim.fn.has("nvim-0.10.0") == 0,
})
