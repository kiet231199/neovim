local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	print("Error: cmp")
	return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	print("Error: luasnip")
	return
end

local snippetDir = vim.g.dot_path .. "/snippets"
require("luasnip.loaders.from_vscode").lazy_load { paths = snippetDir }

luasnip.config.set_config({ history = true, updateevents = "TextChanged, TextChangedI" })

vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
        then
            require("luasnip").unlink_current()
        end
    end,
})

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

local cmp_window = require("cmp.utils.window")
cmp_window.info_ = cmp_window.info
cmp_window.info_ = function(self)
    local info = self:info_()
    info.scrollable = false
    return info
end

local kind_icons = {
	Text          = "󰦨",
	Method        = "",
	Function      = "󰊕",
	Constructor   = "",
	Field         = "",
	Variable      = "󰀫",
	Class         = "",
	Interface     = "",
	Module        = "",
	Property      = "",
	Unit          = "",
	Value         = "󰎠",
	Enum          = "",
	Keyword       = "",
	Snippet       = "",
	Color         = "󰏘",
	File          = "󰈔",
	Reference     = "",
	Folder        = "󰉋",
	EnumMember    = "",
	Constant      = "󰏿",
	Struct        = "",
	Event         = "",
	Operator      = "󰆕",
	TypeParameter = "󰆩",
}

local kinds = {
	nvim_lsp                  = "[LSP]",
	nvim_lsp_document_symbols = "[Doc]",
	luasnip                   = "[Snippet]",
	vsnip                     = "[Snippet]",
	buffer                    = "[Buffer]",
	luasnip_choice            = "[Snippet]",
	buffer_lines              = "[Buffer]",
	cmdline                   = "[Cmd]",
	cmdline_history           = "[History]",
	path                      = "[Path]",
	rg                        = "[RG]",
	env                       = "[Env]",
	doxygen                   = "[Doxygen]",
}

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	enabled = function()
		return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
			or require("cmp_dap").is_dap_buffer()
	end,
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
		["<C-j>"] = require("cmp").mapping(function(fallback)
			if luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		["<C-k>"] = require("cmp").mapping(function(fallback)
			if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { 'i', 's' }),
		["<C-Space>"] = require("cmp").mapping(require("cmp").mapping.complete(), { "i", "c" }),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = require("cmp").mapping.confirm({ select = false }),
		["<Tab>"] = require("cmp").mapping(function(fallback)
			if require("cmp").visible() then
                require("cmp").select_next_item({ behavior = require("cmp").SelectBehavior.Select })
			elseif luasnip.expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
			elseif has_words_before() then
				require("cmp").complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = require("cmp").mapping(function(fallback)
			if require("cmp").visible() then
                require("cmp").select_prev_item({ behavior = require("cmp").SelectBehavior.Select })
			elseif luasnip.jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	formatting = {
		fields = { "abbr" ,"kind", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.menu = (kinds)[entry.source.name]
			vim_item.dup = ({	-- Remove duplicate in source
				buffer          = 1,
				path            = 1,
				nvim_lsp        = 0,
				vsnip           = 0,
				luasnip         = 1,
				cmdline_history = 0,
				rg              = 1,
			})[entry.source.name] or 0
			local maxwidth = 40
			vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
			return vim_item
		end,
		expandable_indicator = true,
	},
	sources = {
		{ name = "luasnip", option = { show_autosnippets = true }, priority = 10 },
		{ name = "luasnip_choice"         , priority = 9 },
		{ name = "nvim_lsp"               , priority = 8 },
		{ name = "nvim_lsp_signature_help", priority = 7 },
		{ name = "buffer"                 , priority = 5 },
		{ name = "doxygen"                , priority = 4 },
		{ name = "path"                   , priority = 3 },
		{ name = "env"                    , priority = 2 },
		{ name = "rg"                     , priority = 1 },
	},
	confirm_opts = {
		behavior = require("cmp").ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		completion = {
			max_width = 40,
			max_height = 25,
			border = border("LspSagaHoverBorder"),
			winhighlight = "Normal:CmpPmenu,Search:None",
		},
		documentation = {
			border = border("CmpDocumentationBorder"),
		},
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
	sorting = {
		priority_weight = 2,
        comparators = {
            require("cmp").config.compare.kind,
            require("cmp").config.compare.recently_used,
            require("cmp").config.compare.sort_text,
            require("cmp").config.compare.order,
            require("cmp").config.compare.length,
            require("cmp-under-comparator").under,
            require("cmp").config.compare.offset,
            require("cmp").config.compare.exact,
            require("cmp").config.compare.score,
        },
    },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
require("cmp").setup.cmdline({ '/', '?' }, {
	mapping = require("cmp").mapping.preset.cmdline(),
	sources = require("cmp").config.sources({
		{ name = 'nvim_lsp_document_symbols', priority = 4 },
		{
			name = 'buffer',
			option = { keyword_pattern = [[\k\+]] },
			priority = 2,
		},
		{
			name = 'buffer-lines',
			option = {
				words = true,
				comments = true,
			},
			priority = 1,
		},
	})
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
require("cmp").setup.cmdline(':', {
	mapping = require("cmp").mapping.preset.cmdline(),
	sources = require("cmp").config.sources({
        {
            name = 'cmdline',
            priority = 3,
            option = {
                ignore_cmds = { 'vsplit', 'split' },
            },
        },
		{ name = 'path', priority = 2 },
		{
			name = 'cmdline_history',
			priority = 1,
			max_item_count = 3,
		},
	})
})

require("cmp").setup.filetype({ "dap-repl", "dapui_watches" }, {
	sources = {
		{ name = "dap" },
	},
})

require('cmp_luasnip_choice').setup({ auto_open = true });
