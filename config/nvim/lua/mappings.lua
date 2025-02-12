-- n, v, mappings.luamapnames

local silent = { silent = true, noremap = true }
local remap = { silent = true, remap = true }

local mappings = {}

mappings.general = {
	i = {
		["<C-a>"]     = { "<ESC>^i", "beginning of line" },
		["<C-e>"]     = { "<End>", "end of line" },

		["<A-h>"]     = { "<Left>", "move left" },
		["<A-l>"]     = { "<Right>", "move right" },
		["<A-j>"]     = { "<Down>", "move down" },
		["<A-k>"]     = { "<Up>", "move up" },
	},

	n = {
		["<esc>"]     = { ":noh <CR>", "clear highlight search" },
		["<C-a>"]     = { "ggVG", "select all" },
		["<C-s>"]     = { ':w<CR>:lua require("notify")("Save successfull 勒", "info",{title = "Save file "})<CR>:noh<CR>', opts = silent },
		["<C-e>"]     = { "10<C-e>" };
		["<C-y>"]     = { "10<C-y>" };

		["<F4>"]      = { ":lua ToggleLSP()<CR>", "toggle_lsp",            opts = silent },
		["<F12>v"]    = { ":lua ToggleCopyMode()<CR>", "toggle interface", opts = silent },
		["<F12>n"]    = { ":set norelativenumber!<CR>", "toggle relative number" },
		["<F12>c"]    = { ":set list!<CR>", "toggle viewing special character" },
		["<F12>s"]    = { ":lua ToggleGlobalStatusLine()<CR>", "toggle global status line" },

		['<A-.>']     = { ":bnext<CR>", "next buffer" },
		['<A-,>']     = { ":bprevious <CR>", "previous buffer" },
		['<A-c>']     = { ":bdelete<CR>", "delete buffer" },

		["sh"]        = { ":split <CR><C-w>w", "split pane horizontally" },
		["sv"]        = { ":vsplit <CR><C-w>w", "split pane vertically" },

		["dv"]        = { ":diffsplit <CR>", "diffview file" },

		["<A-Up>"]    = { ":resize -2 <CR>", "Resize up" },
		["<A-Down>"]  = { ":resize +2 <CR>", "Resize down" },
		["<A-Left>"]  = { ":vertical resize -2 <CR>", "Resize left" },
		["<A-Right>"] = { ":vertical resize +2 <CR>", "Resize right" },
	},

	t = {
		['<C-t>'] = { "<C-\\><C-n>", "exit terminal mode" },
	},

	v = {
		["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',   opts = { expr = true } },
		["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },

		["<"] = { "<gv", "tab blockcode backward", opts = { noremap = true, silent = true } },
		[">"] = { ">gv", "tab blockcode forward",  opts = { noremap = true, silent = true } },
	},
	x = {
		-- Don't copy the replaced text after pasting in visual mode
		["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
	},
}

mappings.jabs = {
	plugin = true,
	n = {
		["<tab>"] = { ":JABSOpen<CR>", "Open list of buffer", opts = silent },
	}
}

mappings.dropbar = {
	plugin = true,
	n = {
		["<leader>w"] = { function() require("dropbar.api").pick() end, "pick winbar element", opts = silent },
	}
}

mappings.lspconfig = {
	plugin = true,
	x = {
		["gF"] = { ":lua require('lsp-range-format').format() <CR>", "format range", opts = silent },
	},
}

mappings.lspsaga = {
	plugin = true,
	n = {
		["gf"]   = { ":Lspsaga finder def+ref<CR>", "finder"   , opts = silent },
		["gi"]   = { ":Lspsaga finder imp<CR>"    , "implement", opts = silent },
		["gr"]   = { ":Lspsaga rename<CR>"        , "rename"   , opts = silent },
		["K"]    = { ":Lspsaga hover_doc<CR>"     , "hover doc", opts = silent },
		["<F6>"] = { ":Lspsaga outline<CR>"       , "outline"  , opts = silent },
		-- Use <C-t> to jump back
		["gpd"] = { ":Lspsaga peek_definition<CR>", "float definition", opts = silent },
		-- Diagnsotic jump can use `<c-o>` to jump back
		["gk"] = { function() require("lspsaga.diagnostic"):goto_prev() end, "diagnostic jump prev", opts = silent },
		["gj"] = { function() require("lspsaga.diagnostic"):goto_next() end, "diagnostic jump next", opts = silent },
		-- Only jump to error
		["gek"] = { function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, "error jump prev", opts = silent },
		["gej"] = { function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end, "error jump next", opts = silent },
	}
}

mappings.lsplines = {
	plugin = true,
	x = {
		["<F3>"] = { ":lua require('lsp_lines').toggle() <CR>", "Toggle LSP diagnostic", opts = silent },
	},
}

mappings.flash = {
	plugin = true,
	n = {
		['f'] = { function() require("flash").jump() end, "Jump to word / string", opts = silent },
		['t'] = { function() require("flash").treesitter() end, "Select to treesitter object", opts = silent },
	},
	x = {
		['f'] = { function() require("flash").jump() end, "Jump to word / string", opts = silent },
		['t'] = { function() require("flash").treesitter() end, "Select to treesitter object", opts = silent },
	},
	o = {
		['f'] = { function() require("flash").jump() end, "Jump to word / string", opts = silent },
		['t'] = { function() require("flash").treesitter() end, "Select to treesitter object", opts = silent },
	},
}

mappings.snacks_explorer = {
    plugin = true,
    n = {
        ["<F5>"] = { function() require("snacks").explorer() end, "Open file explorer", opts = silent },
    }
}

mappings.snacks_scratch = {
    plugin = true,
    n = {
        ["<leader>sc"] = { function() require("snacks").scratch() end, "Toggle Scratch Buffer" },
    }
}

mappings.snacks_picker = {
    plugin = true,
    n = {
        ["<leader>/"] = { function() Snacks.picker.lines() end, "Buffer Lines" },
        ["<leader>:"] = { function() Snacks.picker.command_history() end, "Command History" },
        -- find
        ["<leader>fw"] = { function() Snacks.picker.grep() end, "Grep" },
        ["<leader>fc"] = { function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, "Find Config File" },
        ["<leader>ff"] = { function() Snacks.picker.files() end, "Find Files" },
        ["<leader>fr"] = { function() Snacks.picker.recent() end, "Recent" },
        -- search
        ["<leader>fR"] = { function() Snacks.picker.registers() end, "Registers" },
        ["<leader>fa"] = { function() Snacks.picker.autocmds() end, "Autocmds" },
        ["<leader>fd"] = { function() Snacks.picker.diagnostics() end, "Diagnostics" },
        ["<leader>fh"] = { function() Snacks.picker.help() end, "Help Pages" },
        ["<leader>fk"] = { function() Snacks.picker.keymaps() end, "Keymaps" },
        ["<leader>fm"] = { function() Snacks.picker.man() end, "Man Pages" },
        ["<leader>fp"] = { function() Snacks.picker.projects() end, "Projects" },
        ["<leader>ft"] = { function() Snacks.picker.todo_comments() end, "Todo" },
    },
}

local watch_opts = { title = " Watches", width = 100, height = 15, position = "center", enter = true }
mappings.dap = {
    plugin = true,
    n = {
        ["<F13>"] = { function() require("dapui").toggle() end, "Toggle UI", opts = silent },                                                                                        -- <S-F1>
        ["<F14>"] = { ":DapVirtualTextToggle", "Toggle virtual text", opts = silent },                                                                                               -- <S-F2>
        ["<F15>"] = { function() require("dapui").float_element("watches", watch_opts) end, "Open Watches", opts = silent },                                                         -- <S-F3>
        ["<F16>"] = { function() require("dap.ui.widgets").hover() end, "Open preview", opts = silent },                                                                             -- <S-F4>
        ["<F17>"] = { ":DapContinue<CR>", "Start or continue debugger", opts = silent },                                                                                             -- <S-F5>
        ["<F18>"] = { ":DapTerminate<CR>", "Start or continue debugger", opts = silent },                                                                                            -- <S-F6>
        ["<F19>"] = { function() require('goto-breakpoints').next() end, "Goto next breakpoint", opts = silent, },                                                                   -- <S-F7>
        ["<F20>"] = { function() require('goto-breakpoints').prev() end, "Goto prev breakpoint", opts = silent, },                                                                   -- <S-F8>
        ["<F21>"] = { function() require('persistent-breakpoints.api').toggle_breakpoint() end, "Add breakpoint at line", opts = silent, },                                          -- <S-F9>
        ["<F22>"] = { ":DapStepOver<CR>", "Step Over", opts = silent },                                                                                                              -- <S-F10>
        ["<F23>"] = { ":DapStepInto<CR>", "Step Into (next line)", opts = silent },                                                                                                  -- <S-F11>
        ["<F24>"] = { ":DapStepOut<CR>", "Step Out", opts = silent },                                                                                                                -- <S-F12>
        ["<F57>"] = { function() require('persistent-breakpoints.api').set_conditional_breakpoint(vim.fn.input(' CONDITION    ')) end, "Condition breakpoint", opts = silent, }, -- <A-F9>
        ["<F33>"] = { function() require('persistent-breakpoints.api').clear_all_breakpoints() end, "Clear all breakpoints", opts = silent, },                                       -- <C-F9>
        ["<2-LeftMouse>"] = { function()
                require('persistent-breakpoints.api').toggle_breakpoint()
            end,
            "Add breakpoint at line by double click",
            opts = silent,
        },
    }
}

mappings.ezreplace = {
    plugin = true,
    n = {
        ["<leader>ra"] = { ":EasyReplaceWord<CR>", "Easy replace word", opts = silent },
        ["<leader>rc"] = { ":EasyReplaceCword<CR>", "Easy replace current word", opts = silent },
    },
    v = {
        ["<leader>ra"] = { ":EasyReplaceWordInVisual<CR>", "Easy replace word", opts = silent },
        ["<leader>rc"] = { ":EasyReplaceCwordInVisual<CR>", "Easy replace current word", opts = silent },
    },
}

mappings.align = {
	plugin = true,
	v = {
		["<leader>ac"] = { function() require("align").align_to_char({ length = 1 }) end, "Align to 1 char", opts = silent },
		["<leader>as"] = { function() require("align").align_to_string({ preview = true, regex = true }) end, "Align to string", opts = silent },
	},
}

mappings.move = {
	plugin = true,
	n = {
		["<A-j>"] = { ":MoveLine(1)<CR>"   , "move block down" , opts = silent },
		["<A-k>"] = { ":MoveLine(-1)<CR>"  , "move block up"   , opts = silent },
		["<A-h>"] = { ":MoveHChar(-1)<CR>" , "move block left" , opts = silent },
		["<A-l>"] = { ":MoveHChar(1)<CR>"  , "move block right", opts = silent },
	},
	v = {
 		["<A-j>"] = { ":MoveBlock(1)<CR>"  , "move block down" , opts = silent },
		["<A-k>"] = { ":MoveBlock(-1)<CR>" , "move block up"   , opts = silent },
		["<A-h>"] = { ":MoveHBlock(-1)<CR>", "move block left" , opts = silent },
		["<A-l>"] = { ":MoveHBlock(1)<CR>" , "move block right", opts = silent },
	},
}

mappings.toggler = {
    plugin = true,
    n = {
        ["<leader>i"] = { function() require("nvim-toggler").toggle() end, "Invert text", opts = silent },
    },
}

mappings.multiplecursors = {
	plugin = true,
	n = {
		["<C-j>"] = { ":MultipleCursorsAddDown<CR>", "Add multiple cursor down", opts = silent },
		["<C-LeftMouse>"] = { ":MultipleCursorsMouseAddDelete<CR>", "Add multiple cursor" , opts = silent },
	}
}

mappings.hlslens = {
	plugin = true,
	n = {
		["n"] = { "<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>", "Search next word", opts = remap },
		["N"] = { "<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require('hlslens').start()<CR>", "Search prev word", opts = remap },
		["*"] = { "*<cmd>lua require('hlslens').start()<CR>", "Search next word under cursor", opts = remap },
		["#"] = { "#<cmd>lua require('hlslens').start()<CR>", "Search next word under cursor", opts = remap },
	},
}

mappings.windows = {
	plugin = true,
	n = {
		["<C-w>z"] = { ":WindowsMaximize<CR>:WindowsDisableAutowidth<CR>"            , "Expand current window"             , opts = silent },
		["<C-w>_"] = { ":WindowsMaximizeVertically<CR>:WindowsDisableAutowidth<CR>"  , "Expand current window vertically"  , opts = silent },
		["<C-w>|"] = { ":WindowsMaximizeHorizontally<CR>:WindowsDisableAutowidth<CR>", "Expand current window horizontally", opts = silent },
		["<C-w>="] = { ":WindowsEqualize<CR>:WindowsDisableAutowidth<CR>"            , "Equalize multiple windows"         , opts = silent },
	},
}

mappings.terminal = {
	plugin = true,
	n = {
		['<F8>'] = { "<C-\\><C-n>:TermToggle <CR>", "toggle float terminal", opts = silent },
	},
	t = {
		['<F8>'] = { "<C-\\><C-n>:TermToggle <CR>", "toggle float terminal", opts = silent },
	},
}

mappings.screenkey = {
	plugin = true,
	n = {
		["<F7>"]   = { ":Screenkey<CR>", "Toggle key detector", opts = silent },
	}
}

mappings.session = {
	plugin = true,
	n = {
		["<leader>sl"] = { ":SessionManager load_last_session<CR>"   , "Load last session"   , opts = silent },
		["<leader>ss"] = { ":SessionManager save_current_session<CR>", "Save current session", opts = silent },
		["<leader>sd"] = { ":SessionManager delete_session<CR>"      , "Delete session"      , opts = silent },
	}
}

mappings.tmux = {
    plugin = true,
    n = {
        ["<C-b>h"] = { ":<C-U>TmuxNavigateLeft<CR>" , "Tmux navigate to left pane" , opts = silent },
        ["<C-b>j"] = { ":<C-U>TmuxNavigateDown<CR>" , "Tmux navigate to down pane" , opts = silent },
        ["<C-b>k"] = { ":<C-U>TmuxNavigateUp<CR>"   , "Tmux navigate to up pane"   , opts = silent },
        ["<C-b>l"] = { ":<C-U>TmuxNavigateRight<CR>", "Tmux navigate to right pane", opts = silent },
    }
}

mappings.menu = {
    plugin = true,
    n = {
        ["<Space>"] = { function()
            local normal = require("plugin.ui.menu").normal
            require("menu").open(normal, { border = "rounded" })
        end, opts = silent },
        ["<RightMouse>"] = { function()
            local normal = require("plugin.ui.menu").normal
            require("menu").open(normal, { border = "rounded" })
        end, opts = silent },
    },
    x = {
        ["<Space>"] = { function()
            local visual = require("plugin.ui.menu").visual
            require("menu").open(visual, { border = "rounded" })
        end, opts = silent },
        ["<RightMouse>"] = { function()
            local visual = require("plugin.ui.menu").visual
            require("menu").open(visual, { border = "rounded" })
        end, opts = silent },
    },
}

mappings.lazydo = {
    plugin = true,
    n = {
        ["<F2>"] = { ":LazyDoToggle<CR>", "Open tasks manager", opts = silent },
    },
}

return mappings
