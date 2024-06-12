local status_ok, dropbar = pcall(require, "dropbar")
if not status_ok then
	print("Error: dropbar")
	return
end

local current_path = vim.fs.normalize(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':p'))

local kinds = {
	Array = '󰅪 ',
	Boolean = ' ',
	BreakStatement = '󰙧 ',
	Call = '󰃷 ',
	CaseStatement = '󱃙 ',
	Class = ' ',
	Color = '󰏘 ',
	Constant = '󰏿 ',
	Constructor = ' ',
	ContinueStatement = ' ',
	Copilot = ' ',
	Declaration = '󰙠 ',
	Delete = '󰩺 ',
	DoStatement = '󰑖 ',
	Enum = ' ',
	EnumMember = ' ',
	Event = ' ',
	Field = ' ',
	File = '󰈔 ',
	Folder = ' ',
	ForStatement = '󰑖 ',
	Function = '󰊕 ',
    H1Marker = '󰉫 ',
    H2Marker = '󰉬 ',
    H3Marker = '󰉭 ',
    H4Marker = '󰉮 ',
    H5Marker = '󰉯 ',
    H6Marker = '󰉰 ',
	Identifier = '󰀫 ',
	IfStatement = ' ',
	Interface = ' ',
	Keyword = ' ',
	List = '󰅪 ',
	Log = '󰦪 ',
	Lsp = ' ',
	Macro = '󰁌 ',
	MarkdownH1 = '󰉫 ',
	MarkdownH2 = '󰉬 ',
	MarkdownH3 = '󰉭 ',
	MarkdownH4 = '󰉮 ',
	MarkdownH5 = '󰉯 ',
	MarkdownH6 = '󰉰 ',
	Method = ' ',
	Module = '󰏗 ',
	Namespace = '󰅩 ',
	Null = '󰟢 ',
	Number = '󰎠 ',
	Object = ' ',
	Operator = '󰆕 ',
	Package = '󰆦 ',
    Pair = '󰅪 ',
	Property = ' ',
	Reference = '󰦾 ',
	Regex = ' ',
	Repeat = '󰑖 ',
	Scope = '󰅩 ',
	Snippet = ' ',
	Specifier = '󰦪 ',
	Statement = '󰅩 ',
	String = '󰉾 ',
	Struct = ' ',
	SwitchStatement = ' ',
	Text = '󰦪 ',
	Type = ' ',
	TypeParameter = '󰆩 ',
	Unit = ' ',
	Value = '󰎠 ',
	Variable = '󰀫 ',
	WhileStatement = '󰑖 ',
}

dropbar.setup({
    general = {
        enable = function(buf, win)
            return not vim.api.nvim_win_get_config(win).zindex
                and vim.bo[buf].buftype == ''
                and vim.api.nvim_buf_get_name(buf) ~= ''
                and not vim.wo[win].diff
        end,
        update_interval = 70,
    },
	icons = {
        enable = true,
		kinds = {
			use_devicons = true,
			symbols = kinds,
		},
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
		hover = true,
		padding = {
			left = 1,
			right = 1,
		},
		pick = {
			pivots = '123456789abcdefghijklmnopqrstuvwxyz',
		},
		truncate = true,
	},
	menu = {
		preview = true,
		quick_navigation = false,
		entry = {
			padding = {
				left = 1,
				right = 1,
			},
		},
		scrollbar = {
			enable = true,
			-- The background / gutter of the scrollbar
			-- When false, only the scrollbar thumb is shown.
			background = true
		},
		win_configs = {
			border = 'rounded',
			style = 'minimal',
			row = function(menu)
				return menu.prev_menu
					and menu.prev_menu.clicked_at
					and menu.prev_menu.clicked_at[1] - vim.fn.line('w0')
					or 1
			end,
			col = function(menu)
				return menu.prev_menu and menu.prev_menu._win_configs.width + 1 or 0
			end,
			relative = function(menu)
				return menu.prev_menu and 'win' or 'mouse'
			end,
			win = function(menu)
				return menu.prev_menu and menu.prev_menu.win
			end,
			height = function(menu)
				return math.max(
					1,
					math.min(
						#menu.entries,
						vim.go.pumheight ~= 0 and vim.go.pumheight
						or math.ceil(vim.go.lines / 4)
					)
				)
			end,
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

