local blink_status, blink = pcall(require, "blink.cmp")
if not blink_status then
	print("Error: blink")
	return
end

local icons = {
	Text          = "󰉿",
	Method        = "",
	Function      = '󰊕',
	Constructor   = "",
	Field         = "",
	Variable      = "󰆦",
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
    Boolean       = " ",
    Array         = "󰅪 ",
}

local kinds = {
	nvim_lsp                  = "[Lsp]",
	nvim_lsp_document_symbols = "[Document]",
	buffer                    = "[Buffer]",
	cmdline                   = "[Cmdline]",
	cmdline_history           = "[History]",
	path                      = "[Path]",
	ripgrep                   = "[Ripgrep]",
	doxygen                   = "[Doxygen]",
}

blink.setup({
    enabled = function()
        return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
    end,
    appearance = {
        use_nvim_cmp_as_default = false,
    },
    keymap = {
        -- Disable default keymap
        preset = 'none',

        ['<Tab>']   = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<CR>']    = { 'accept', 'fallback' },

        ['<Up>']    = { 'select_prev', 'fallback' },
        ['<Down>']  = { 'select_next', 'fallback' },
        ['<Left>']  = { 'snippet_forward', 'fallback' },
        ['<Right>'] = { 'snippet_backward', 'fallback' },

        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },

        ['<C-u>'] = { function(cmp) cmp.scroll_documentation_up(4) end, 'fallback' },
        ['<C-d>'] = { function(cmp) cmp.scroll_documentation_down(4) end, 'fallback' },
    },
    completion = {
        -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
        keyword = { range = 'full' },
        trigger = {
            -- When true, will prefetch the completion items when entering insert mode
            prefetch_on_insert = false,
            -- When false, will not show the completion window automatically when in a snippet
            show_in_snippet = false,
            -- When true, will show the completion window after typing any of alphanumerics, `-` or `_`
            show_on_keyword = true,
        },
        list = {
            -- No item will be selected by default
            selection = {
                -- No auto select the first item
                preselect = false,
                auto_insert = true,
            },
        },
        accept = {
            -- Create an undo point when accepting a completion item
            create_undo_point = false,
            auto_brackets = { enabled = true },
        },
        menu = {
            enabled = true,
            min_width = 15,
            max_height = 25,
            border = 'rounded',
            winblend = 0,
            winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
            -- Keep the cursor X lines away from the top/bottom of the window
            scrolloff = 2,
            scrollbar = true,
            auto_show = true,
            -- Which directions to show the window,
            -- falling back to the next direction when there's not enough space
            direction_priority = { 's', 'n' },
            -- Screen coordinates of the command line
            cmdline_position = function()
                if vim.g.ui_cmdline_pos ~= nil then
                    local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
                    return { pos[1] - 1, pos[2] }
                end
                local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
                return { vim.o.lines - height, 0 }
            end,
            draw = {
                -- Aligns the keyword you've typed to a component in the menu
                align_to = 'label', -- or 'none' to disable, or 'cursor' to align to the cursor
                -- Left and right padding, optionally { left, right } for different padding on each side
                padding = 1,
                -- Gap between columns
                gap = 1,
                treesitter = { 'lsp' },
                -- Components to render, grouped by column
                columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind', gap = 2 }, { 'source_name' } },
                components = {
                    label = {
                        width = { fill = true, max = 40 },
                        text = function(ctx)
                            local highlights_info = require("colorful-menu").blink_highlights(ctx)
                            if highlights_info ~= nil then
                                -- Or you want to add more item to label
                                return highlights_info.label
                            else
                                return ctx.label .. ctx.label_detail
                            end
                        end,
                        highlight = function(ctx)
                            -- label and label details
                            local highlights = {
                                { 0, #ctx.label, group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or 'BlinkCmpLabel' },
                            }
                            local highlights_info = require("colorful-menu").blink_highlights(ctx)
                            if highlights_info ~= nil then
                                highlights = highlights_info.highlights
                            else
                                if ctx.label_detail then
                                    table.insert(highlights, { #ctx.label, #ctx.label + #ctx.label_detail, group = 'BlinkCmpLabelDetail' })
                                end
                            end
                            -- characters matched on the label by the fuzzy matcher
                            for _, idx in ipairs(ctx.label_matched_indices) do
                                table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
                            end
                            return highlights
                        end,
                    },
                    label_description = {
                        width = { max = 10 },
                        text = function(ctx) return ctx.label_description end,
                        highlight = 'BlinkCmpLabelDescription',
                    },
                    kind_icon = {
                        width = { fill = true },
                        ellipsis = true,
                        text = function(ctx) return icons[ctx.kind] .. ctx.icon_gap end,
                        highlight = function(ctx)
                            return ctx.kind_hl
                        end,
                    },
                    kind = {
                        ellipsis = false,
                        width = { fill = true },
                        text = function(ctx) return ctx.kind end,
                        highlight = function(ctx)
                            return ctx.kind_hl
                        end,
                    },
                    source_name = {
                        width = { max = 10 },
                        text = function(ctx)
                            local source_name = '[' .. ctx.source_name .. ']'
                            return kinds[ctx.source_name] or source_name
                        end,
                        highlight = 'BlinkCmpLabelDescription',
                    },
                },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
            update_delay_ms = 50,
            treesitter_highlighting = true,
            window = {
                min_width = 40,
                max_width = 80,
                max_height = 20,
                border = 'rounded',
                winblend = 0,
                winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
                scrollbar = false,
                -- Which directions to show the documentation window, for each of the possible menu window directions, falling back to the next direction when there's not enough space
                direction_priority = {
                    menu_north = { 'e', 'w', 'n', 's' },
                    menu_south = { 'e', 'w', 's', 'n' },
                },
            },
        },
    },
    signature = {
        enabled = true,
        trigger = {
            enabled = true,
            show_on_keyword = false,
        },
        window = {
            min_width = 40,
            max_width = 100,
            max_height = 10,
            border = 'rounded',
            winblend = 0,
            winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
            scrollbar = true,
            treesitter_highlighting = true,
        },
    },
    fuzzy = {
    	implementation = "prefer_rust_with_warning",
        use_frecency = false,
        use_proximity = false,
        sorts = { 'score', 'exact' , 'sort_text' },
        prebuilt_binaries = {
        	ignore_version_mismatch = true,
            download = false,
        },
    },
    sources = {
        -- normal:  snipptes -> doxygen -> lsp -> ripgrep -> buffer
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'ripgrep', 'doxygen' },
        providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				-- make lazydev completions top priority (see `:h blink.cmp`)
				score_offset = 1100,
			},
            lsp = {
                name = 'LSP',
                module = 'blink.cmp.sources.lsp',
                enabled = true,
                async = true,
                -- Filter text items from the LSP provider, since we have the buffer provider for that
                transform_items = function(_, items)
                    for _, item in ipairs(items) do
                        if item.kind == require('blink.cmp.types').CompletionItemKind.Snippet then
                            item.score_offset = item.score_offset - 3
                        end
                    end
                    return vim.tbl_filter(
                        function(item) return item.kind ~= require('blink.cmp.types').CompletionItemKind.Text end,
                        items
                    )
                end,
                score_offset = 1000,
            },
            path = {
                name = 'Path',
                module = 'blink.cmp.sources.path',
                opts = {
                    trailing_slash = false,
                    label_trailing_slash = true,
                    get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
                    show_hidden_files_by_default = true,
                },
                should_show_items = true,
                score_offset = 900,
            },
            cmdline = {
                name = "Cmdline",
                module = 'blink.cmp.sources.cmdline',
                score_offset = 800,
            },
            snippets = {
                name = 'Snippets',
                module = 'blink.cmp.sources.snippets',
                opts = {
                    friendly_snippets = true,
                    search_paths = { vim.fn.stdpath('config') .. '/snippets' },
                    global_snippets = { 'all' },
                    extended_filetypes = {},
                    ignored_filetypes = {},
                    get_filetype = function()
                        return vim.bo.filetype
                    end,
                    -- Set to '+' to use the system clipboard, or '"' to use the unnamed register
                    clipboard_register = nil,
                },
                score_offset = 800,
            },
            buffer = {
                name = 'Buffer',
                module = 'blink.cmp.sources.buffer',
                opts = {
                    -- default to all visible buffers
                    get_bufnrs = function()
                        return vim
                            .iter(vim.api.nvim_list_wins())
                            :map(function(win) return vim.api.nvim_win_get_buf(win) end)
                            :filter(function(buf) return vim.bo[buf].buftype ~= 'nofile' end)
                            :totable()
                    end,
                },
                max_items = 15,
                score_offset = 700,
            },
			ripgrep = {
				name = "Ripgrep",
				module = "blink-ripgrep",
				opts = {
					-- the minimum length of the current word to start searching
					prefix_min_len = 1,
					-- The number of lines to show around each match in the preview (documentation) window. For example, 5 means to show 5 lines
					-- before, then the match, and another 5 lines after the match.
					context_size = 5,
					max_filesize = "10M",
					-- "--case-sensitive" or "--smart-case".
					search_casing = "--case-sensitive",
					fallback_to_regex_highlighting = true,
					-- Show debug information in `:messages`
					debug = false,
				},
                max_items = 15,
                score_offset = 700,
			},
			doxygen = {
				name = "doxygen",
				module = "blink.compat.source",
				max_items = 10,
                score_offset = 600,
			},
			history = {
				name = "cmdline_history",
				module = "blink.compat.source",
				max_items = 5,
                score_offset = 500,
			},
        },
    },
	cmdline = {
		enabled = true,
	    keymap = {
            -- Disable default keymap
            preset = 'none',

            ['<Tab>']   = { 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
			['<CR>']    = { 'accept_and_enter', 'fallback' },

            ['<Up>']    = { 'select_prev', 'fallback' },
            ['<Down>']  = { 'select_next', 'fallback' },
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        },
		-- search:  ripgrep -> buffer
		-- command: path --> cmdline -> history
		sources = function()
            local type = vim.fn.getcmdtype()
            -- Search forward and backward
            if type == '/' or type == '?' then return { 'ripgrep', 'buffer' } end
            -- Commands
            if type == ':' or type == '@' then return { 'path', 'cmdline', 'history' } end
            return {}
        end,
        completion = {
            list = {
                selection = {
                    preselect = false,
                    auto_insert = true,
                }
            },
            menu = { auto_show = true },
            draw = nil,
        },
    },
})

