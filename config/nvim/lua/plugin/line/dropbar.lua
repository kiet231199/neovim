local status_ok, dropbar = pcall(require, "dropbar")
if not status_ok then
	print("Error: dropbar")
	return
end

local current_path = vim.fs.normalize(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p'))

dropbar.setup({
	icons = {
        enable = true,
		ui = {
			bar = {
				separator = '  ',
				extends = '…',
			},
			menu = {
				separator = ' ',
				indicator = '',
			},
		}
	},
	bar = {
		pick = {
			pivots = '123456789abcdefghijklmnopqrstuvwxyz',
		},
	},
	menu = {
		preview = true,
		quick_navigation = false,
		scrollbar = {
			enable = true,
			-- The background / gutter of the scrollbar
			-- When false, only the scrollbar thumb is shown.
			background = true
		},
		win_configs = {
			border = 'rounded',
			width = function(menu)
				local min_width = vim.go.pumwidth ~= 0 and vim.go.pumwidth or 8
				if vim.tbl_isempty(menu.entries) then
					return min_width + 2
				end
				return math.max(
					min_width,
					math.max(unpack(vim.tbl_map(function(entry)
						return entry:displaywidth()
					end, menu.entries)))
				) + 2
			end,
		},
	},
	sources = {
		path = {
			relative_to = function(_)
				return vim.fn.finddir(vim.fn.fnamemodify(current_path, ":h"), vim.fn.getcwd())
			end,
		},
	}
})

