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
	Method = '󰆧 ',
	Module = '󰏗 ',
	Namespace = '󰅩 ',
	Null = '󰢤 ',
	Number = '󰎠 ',
	Object = '󰅩 ',
	Operator = '󰆕 ',
	Package = '󰆦 ',
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
	enable = function(buf, win)
		return not vim.api.nvim_win_get_config(win).zindex
			and vim.bo[buf].buftype == 'alpha'
			and vim.api.nvim_buf_get_name(buf) ~= ''
			and not vim.wo[win].diff
	end,
	icons = {
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
		entry = {
			padding = {
				left = 0,
				right = 1,
			},
		},
		keymaps = {
			['<LeftMouse>'] = function()
				local api = require('dropbar.api')
				local menu = api.get_current_dropbar_menu()
				if not menu then
					return
				end
				local mouse = vim.fn.getmousepos()
				if mouse.winid ~= menu.win then
					local parent_menu = api.get_dropbar_menu(mouse.winid)
					if parent_menu and parent_menu.sub_menu then
						parent_menu.sub_menu:close()
					end
					if vim.api.nvim_win_is_valid(mouse.winid) then
						vim.api.nvim_set_current_win(mouse.winid)
					end
					return
				end
				menu:click_at({ mouse.line, mouse.column }, nil, 1, 'l')
			end,
			['<CR>'] = function()
				local menu = require('dropbar.api').get_current_dropbar_menu()
				if not menu then
					return
				end
				local cursor = vim.api.nvim_win_get_cursor(menu.win)
				local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
				if component then
					menu:click_on(component, nil, 1, 'l')
				end
			end,
			['q'] = function()
				local menu = require('dropbar.api').get_current_dropbar_menu()
				if not menu then
					return
				end
				local cursor = vim.api.nvim_win_get_cursor(menu.win)
				local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
				if component then
					menu:close()
				end
			end,
			['<MouseMove>'] = function()
				local menu = require('dropbar.api').get_current_dropbar_menu()
				if not menu then
					return
				end
				local mouse = vim.fn.getmousepos()
				if mouse.winid ~= menu.win then
					return
				end
				menu:update_hover_hl({ mouse.line, mouse.column - 1 })
			end,
		},
		win_configs = {
			border = 'rounded',
			style = 'minimal',
			row = function(menu)
				return menu.parent_menu
					and menu.parent_menu.clicked_at
					and menu.parent_menu.clicked_at[1] - vim.fn.line('w0')
					or 1
			end,
			col = function(menu)
				return menu.parent_menu and menu.parent_menu._win_configs.width + 1 or 0
			end,
			relative = function(menu)
				return menu.parent_menu and 'win' or 'mouse'
			end,
			win = function(menu)
				return menu.parent_menu and menu.parent_menu.win
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
			---@type string|fun(buf: integer): string
			relative_to = function(_)
				return vim.fn.finddir(vim.fn.fnamemodify(current_path, ":h"), vim.fn.getcwd())
			end,
			filter = function(_)
				return true
			end,
		},
	}
})

