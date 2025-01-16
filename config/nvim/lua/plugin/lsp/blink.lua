local blink_status, blink = pcall(require, "blink.cmp")
if not blink_status then
	print("Error: blink")
	return
end

local icons = {
	Text          = "󰉿",
	Method        = "",
	Function      = "󰊕",
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
	buffer_lines              = "[Buffer]",
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

        cmdline = {
            -- Disable default keymap
            preset = 'none',

            ['<Tab>']   = { 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
            ['<CR>']    = { 'accept', 'fallback' },

            ['<Up>']    = { 'select_prev', 'fallback' },
            ['<Down>']  = { 'select_next', 'fallback' },
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        },
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
            -- When true, will show the completion window after accepting an item
            show_on_accept_on_trigger_character = true,
            -- When true, will show the completion window after triggerring character when entering insert mode
            show_on_insert_on_trigger_character = true,
        },
        list = {
            max_items = 15,
            -- No item will be selected by default
            selection = {
                preselect = false,
                auto_insert = true,
            },
        },
        accept = {
            -- Create an undo point when accepting a completion item
            create_undo_point = true,
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
							local hl = require('blink.cmp.completion.windows.render.tailwind').get_hl(ctx) or 'BlinkCmpKind'
                            return hl .. ctx.kind
                        end,
                    },
                    kind = {
                        ellipsis = false,
                        width = { fill = true },
                        text = function(ctx) return ctx.kind end,
                        highlight = function(ctx)
							local hl = require('blink.cmp.completion.windows.render.tailwind').get_hl(ctx) or 'BlinkCmpKind'
                            return hl .. ctx.kind
                        end,
                    },
                    source_name = {
                        width = { max = 10 },
                        text = function(ctx)
                            local source_name = '[' .. ctx.source_name .. ']'
                            return kinds[ctx.source_name] or source_name
                        end,
                        highlight = 'BlinkCmpSource',
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
        ghost_text = {
            enabled = false,
        },
    },
    signature = {
        enabled = true,
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
        use_frecency = false,
        sorts = { 'score', 'sort_text' },
        prebuilt_binaries = {
        	ignore_version_mismatch = true,
            download = false,
        },
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'buffer_lines', 'ripgrep', 'doxygen' },
        -- normal:  snipptes -> doxygen -> lsp -> ripgrep -> buffer_lines -> buffer
        -- cmdline:
            -- search:  ripgrep -> buffer
            -- command: path --> history --> cmdline
        cmdline = function()
            local type = vim.fn.getcmdtype()
            -- Search forward and backward
            if type == '/' or type == '?' then return { 'ripgrep', 'buffer' } end
            -- Commands
            if type == ':' or type == '@' then return { 'path', 'cmdline', 'history' } end
            return {}
        end,
        providers = {
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
                score_offset = 800,
            },
            path = {
                name = 'Path',
                module = 'blink.cmp.sources.path',
                fallbacks = { 'cmdline', 'cmdline_history' },
                opts = {
                    trailing_slash = true,
                    label_trailing_slash = true,
                    get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
                    show_hidden_files_by_default = true,
                },
                score_offset = 900,
            },
            cmdline = {
                name = "Cmdline",
                module = 'blink.cmp.sources.cmdline',
                score_offset = 700,
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
                score_offset = 1000,
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
                max_items = 10,
                score_offset = 100,
            },
            buffer_lines = {
				name = "buffer-lines",
				module = "blink.compat.source",
				opts = {
					words = true,
					comments = true,
					line_numbers = false,
					line_number_separator = "",
					leading_whitespace = false,
					max_indents = 0,
					max_size = 100, -- in kB
				},
				max_items = 5,
                score_offset = 500,
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
					search_casing = "--ignore-case",
					fallback_to_regex_highlighting = true,
					-- Show debug information in `:messages`
					debug = false,
				},
                max_items = 15,
                score_offset = 600,
			},
			doxygen = {
				name = "doxygen",
				module = "blink.compat.source",
				max_items = 10,
                score_offset = 700,
			},
			history = {
				name = "cmdline_history",
				module = "blink.compat.source",
				max_items = 5,
                score_offset = 800,
			},
        },
    },
})

