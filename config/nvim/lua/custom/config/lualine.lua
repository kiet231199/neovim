local mode_map = {
	['n']    = ' Normal',
	['niI']  = ' Normal',
	['niR']  = ' Normal',
	['niV']  = ' Normal',
	['nt']   = ' Normal',
	['v']    = '󰉷 Visual',
	['vs']   = '󰉷 Visual',
	['V']    = '󰉷 Visual-L',
	['Vs']   = '󰉷 Visual-L',
	['s']    = '󰉷 Select',
	['S']    = '󰉷 Select-L',
	['i']    = ' Insert',
	['ic']   = ' Insert',
	['ix']   = ' Insert',
	['R']    = '󰛔 Replace',
	['Rc']   = '󰌨 Replace',
	['Rx']   = '󰌨 Replace',
	['Rv']   = '󰌨 Visual-Replace',
	['Rvc']  = '󰌨 Visual-Replace',
	['Rvx']  = '󰌨 Visual-Replace',
	['c']    = ' Command',
	['r']    = '󰌨 Replace',
	['t']    = ' Terminal',
}

local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	print("Error: lualine")
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = 'tokyonight',
		component_separators = { left = '', right = ''},
		section_separators = { left = '', right = ''},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = {
			function()
				return mode_map[vim.api.nvim_get_mode().mode] or "__"
			end
		},
		lualine_b = {
			{
				'branch',
				icons = {'', align='left', color={fg='blue'}},
				separator = { left = '', right = ''},
			},
			{
				'diff',
				colored = true, -- Displays a colored diff status if set to true
				diff_color = {
					-- Same color values as the general color option can be used here.
					added    = 'DiffAdd',    -- Changes the diff's added color
					modified = 'DiffChange', -- Changes the diff's modified color
					removed  = 'DiffDelete', -- Changes the diff's removed color you
				},
				symbols = {added = ' ', modified = '  ', removed = '  '}, -- Changes the symbols used by the diff.
				separator = { left = '', right = ''},
			},
			{
				'diagnostics',
				sources = { 'nvim_diagnostic', 'nvim_lsp', 'nvim_workspace_diagnostic' },
				sections = { 'error', 'warn', 'info', 'hint' },
				diagnostics_color = {
					error = 'DiagnosticError', -- Changes diagnostics' error color.
					warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
					info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
					hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
				},
				symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
				colored = true,           -- Displays diagnostics status in color if set to true.
				always_visible = false,
				separator = { left = '', right = ''},
			},
		},
		lualine_c = {
			{
				'filename',
				file_status = true,      -- Displays file status (readonly status, modified status)
				newfile_status = true,   -- Display new file status (new file means no write after created)
				path = 0,                -- 0: Just the filename
				shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
				symbols = {
					modified = ' ',      -- Text to show when the file is modified.
					readonly = ' ',      -- Text to show when the file is non-modifiable or readonly.
					unnamed = '[Unnamed]  ', -- Text to show for unnamed buffers.
					newfile = '[New]  ',     -- Text to show for new created file before first writting
				},
			},
		},
		lualine_x = {
			{
				function()
					local msg = 'none'
					local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
					local clients = vim.lsp.get_active_clients()
					if next(clients) == nil then
						return msg
					end
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							return client.name
						end
					end
					return msg
				end,
				icon = '  LSP:',
			},
			{
				'encoding'
			},
			{
				'fileformat',
				symbols = {
					unix = '', -- e712
					dos = '',  -- e70f
				}
			},
			{
				'filetype',
				icon_only = true,
			},
		},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			{
				'filename',
				file_status = true,      -- Displays file status (readonly status, modified status)
				path = 0,                -- 0: Just the filename
				shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
				symbols = {
					modified = '  ',      -- Text to show when the file is modified.
					readonly = '  ',      -- Text to show when the file is non-modifiable or readonly.
					unnamed = '[Unnamed]  ', -- Text to show for unnamed buffers.
					newfile = '[New]  ',     -- Text to show for new created file before first writting
				},
			},
		},
		lualine_x = {},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},
    tabline = {},
	extensions = {},
})
