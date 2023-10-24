-- n, v, i, t = mode names

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

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

	n  = {
		["<esc>"]     = { ":noh <CR>", "clear highlight search" },
		["<C-a>"]     = { "ggVG", "select all" },
		["<C-s>"]     = { ':w<CR>:lua require("notify")("Save successfull 勒", "info",{title = "Save file "})<CR>:noh<CR>', opts = { silent = true } },

		["<F4>"]      = { ":lua ToggleLSP()<CR>", "toggle_lsp",            opts = { silent = true } },
		["<F11>"]     = { ":lua ToggleCopyMode()<CR>", "toggle interface", opts = { silent = true } },
		["<F12>n"]    = { ":set norelativenumber!<CR>", "toggle relative number" },
		["<F12>c"]    = { ":set list!<CR>", "toggle viewing special character" },
		["<F12>s"]    = { ":lua ToggleGlobalStatusLine()<CR>", "toggle global status line" },

		['<A-.>']     = { ":bnext<CR>", "next buffer" },
		['<A-,>']     = { ":bprevious <CR>", "previous buffer" },
		['<A-c>']     = { ":bdelete<CR>", "delete buffer" },

		["sh"]        = { ":split <CR><C-w>w", "split pane horizontally" },
		["sv"]        = { ":vsplit <CR><C-w>w", "split pane vertically" },

		["dv"]        = { ":diffsplit", "diffview file" },

		["ss"]        = { ":w<CR>:source %<CR>", "save and source file" },

		["<A-Up>"]    = { ":resize -2 <CR>", "Resize up" },
		["<A-Down>"]  = { ":resize +2 <CR>", "Resize down" },
		["<A-Left>"]  = { ":vertical resize -2 <CR>", "Resize left" },
		["<A-Right>"] = { ":vertical resize +2 <CR>", "Resize right" },

		["<"]         = { "V<gv<ESC>", "tab blockcode backward", opts = { noremap = true, silent = true } },
		[">"]         = { "V>gv<ESC>", "tab blockcode forward" , opts = { noremap = true, silent = true } },
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

mappings.gitsigns = {
	plugin = true,
	n = {
		["<F2>"] = { ":Gitsigns toggle_numhl<CR>:Gitsigns toggle_linehl<CR>", "toggle highlight line" },
		["<F9>"] = { ":Gitsigns toggle_current_line_blame <CR>", "toggle blame line" },
	},
	i = {
		["<F2>"] = { ":Gitsigns toggle_numhl<CR>:Gitsigns toggle_linehl<CR>", "toggle highlight line" },
		["<F9>"] = { ":Gitsigns toggle_current_line_blame <CR>", "toggle blame line" },
	},
}

mappings.telescope = {
	plugin = true,
	n = {
		["<space>ff"]     = { ":Telescope find_files <CR>"                         , "find files" },
		["<space>fw"]     = { ":Telescope live_grep <CR>"                          , "live grep" },
		["<space>f<TAB>"] = { ":Telescope buffers <CR>"                            , "find buffers" },
		["<space>fh"]     = { ":Telescope help_tags <CR>"                          , "help page" },
		["<space>fo"]     = { ":Telescope oldfiles <CR>"                           , "find oldfiles" },
		["<space>fk"]     = { ":Telescope keymaps <CR>"                            , "find keymaps" },
		["<space>fd"]     = { ":Telescope diagnostics <CR>"                        , "find diagnostics" },
		["<space>fr"]     = { ":Telescope registers <CR>"                          , "find registers" },
		["<space>fb"]     = { ":Telescope file_browser <CR>"                       , "file_browser" },
		["<space>fg"]     = { ":Telescope git_commits <CR>"                        , "git commits" },
		["<space>fp"]     = { ":Telescope project <CR>"                            , "find project" },
		["<space>fc"]     = { ":Telescope neoclip unnamed extra=star,plus,a,b <CR>", "find clipboard" },
		["<space>fn"]     = { ":Telescope noice <CR>"                              , "find messages" },
	},
}

mappings.lspconfig = {
	plugin = true,
	x = {
		["<space>f"] = { ":lua require('lsp-range-format').format() <CR>", "format range", opts = { silent = true } },
	},
}

mappings.himywords = {
	plugin = true,
	n = {
		['<space>m'] = { ":HiMyWordsToggle<CR>", "highlight word on cursor" },
		['<space>M'] = { ":HiMyWordsClear<CR>", "clear all highlight" },
	},
}

mappings.terminal = {
	plugin = true,
	n = {
		['<F8>'] = { "<C-\\><C-n>:TermToggle <CR>", "toggle float terminal" },
	},
	t = {
		['<F8>'] = { "<C-\\><C-n>:TermToggle <CR>", "toggle float terminal" },
	},
}

mappings.move = {
	plugin = true,
	n = {
		["<A-j>"] = { ":MoveLine(1)<CR>"   , "move block down" },
		["<A-k>"] = { ":MoveLine(-1)<CR>"  , "move block up" },
		["<A-h>"] = { ":MoveHChar(-1)<CR>" , "move block left" },
		["<A-l>"] = { ":MoveHChar(1)<CR>"  , "move block right" },
	},
	v = {
 		["<A-j>"] = { ":MoveBlock(1)<CR>"  , "move block down" },
		["<A-k>"] = { ":MoveBlock(-1)<CR>" , "move block up" },
		["<A-h>"] = { ":MoveHBlock(-1)<CR>", "move block left" },
		["<A-l>"] = { ":MoveHBlock(1)<CR>" , "move block right" },
	},
}

mappings.searchbox = {
	plugin = true,
	n = {
		["<A-f>"]   = { ":SearchBoxIncSearch title=Search<CR>"                                                             , "search" },
		["<A-S-f>"] = { ":SearchBoxIncSearch title=Search -- <C-r>=expand('<cword>') <CR><CR>"                             , "search" },
		["<A-r>"]   = { ":SearchBoxReplace title=Replace confirm=menu<CR>"                                                 , "search" },
		["<A-S-r>"] = { ":SearchBoxReplace title=Replace confirm=menu -- <C-r>=expand('<cword>') <CR><CR>"                 , "search" },
	},
	v = {
		["<A-f>"]   = { ":SearchBoxIncSearch title=Search visual_mode=true<CR>"                                            , "search" },
		["<A-S-f>"] = { ":SearchBoxIncSearch title=Search visual_mode=true -- <C-r>=expand('<cword>') <CR><CR>"            , "search" },
		["<A-r>"]   = { ":SearchBoxReplace title=Replace visual_mode=true confirm=menu<CR>"                                , "search" },
		["<A-S-r>"] = { ":SearchBoxReplace title=Replace visual_mode=true confirm=menu -- <C-r>=expand('<cword>') <CR><CR>", "search" },
	},
}

mappings.lspsaga = {
	plugin = true,
	n = {
		["gf"]   = { ":Lspsaga finder def+ref<CR>", "finder"   , opts = { silent = true } },
		["gi"]   = { ":Lspsaga finder imp<CR>"    , "implement", opts = { silent = true } },
		["gr"]   = { ":Lspsaga rename<CR>"        , "rename"   , opts = { silent = true } },
		["K"]    = { ":Lspsaga hover_doc<CR>"     , "hover doc", opts = { silent = true } },
		["<F6>"] = { ":Lspsaga outline<CR>"       , "outline"  , opts = { silent = true } },
		-- Use <C-t> to jump back
		["gpd"] = { ":Lspsaga peek_definition<CR>", "float definition", opts = { silent = true } },
		-- Diagnsotic jump can use `<c-o>` to jump back
		["gk"] = { function() require("lspsaga.diagnostic"):goto_prev() end, "diagnostic jump prev", opts = { silent = true } },
		["gj"] = { function() require("lspsaga.diagnostic"):goto_next() end, "diagnostic jump next", opts = { silent = true } },
		-- Only jump to error
		["gek"] = { function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, "error jump prev", opts = { silent = true } },
		["gej"] = { function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end, "error jump next", opts = { silent = true } },
	}
}

mappings.dropbar = {
	plugin = true,
	n = {
		["<space>ww"] = { function() require("dropbar.api").pick() end, "pick winbar element", opts = { silent = true } },
	}
}

mappings.session = {
	plugin = true,
	n = {
		["<space>sl"] = { ":SessionManager load_last_session<CR>"   , "Load last session"   , opts = { silent = true, noremap = true } },
		["<space>ss"] = { ":SessionManager save_current_session<CR>", "Save current session", opts = { silent = true, noremap = true } },
		["<space>sd"] = { ":SessionManager load_last_session<CR>"   , "Delete session"      , opts = { silent = true, noremap = true } },
	}
}

mappings.dap = {
    plugin = true,
    n = {
        ["<F15>"] = { function() require("dapui").float_element("watches", { width = 100, height = 15, enter = true }) end, "Open Watches", opts = { silent = true } }, -- <S-F3>
        ["<F16>"] = { function() require("dap.ui.widgets").hover() end          , "Open preview",                                           opts = { silent = true } }, -- <S-F4>
        ["<F17>"] = { ":DapContinue<CR>"                                        , "Start or continue debugger",                             opts = { silent = true } }, -- <S-F5>
        ["<F29>"] = { function() require("dap").run_to_cursor() end             , "Run to cursor",                                          opts = { silent = true } }, -- <C-F5>
        ["<F18>"] = { function() require("dap").pause() end                     , "Pause debugger",                                         opts = { silent = true } }, -- <S-F6>
        ["<F19>"] = { function() require("dap").restart() end                   , "Restart debugger",                                       opts = { silent = true } }, -- <S-F7>
        ["<F20>"] = { ":DapTerminate<CR>"                                       , "Terminate debugger",                                     opts = { silent = true } }, -- <S-F8>
        ["<F22>"] = { ":DapStepOver<CR>"                                        , "Step Over",                                              opts = { silent = true } }, -- <S-F10>
        ["<F23>"] = { ":DapStepInto<CR>"                                        , "Step Into (next line)",                                  opts = { silent = true } }, -- <S-F11>
        ["<F24>"] = { ":DapStepOut<CR>"                                         , "Step Out",                                               opts = { silent = true } }, -- <S-F12>
        -- INFO: Doubleclick to toggle breakpoint
        ["<RightMouse>"] = {
            function()
                require('persistent-breakpoints.api').toggle_breakpoint()
            end,
            "Add breakpoint at line by double click",
			opts = { silent = true },
        },
        ["<F21>"] = {  -- <S-F9>
            function()
                require('persistent-breakpoints.api').toggle_breakpoint()
            end,
            "Add breakpoint at line",
			opts = { silent = true },
        },
        ["<F57>"] = {  -- <A-F9>
            function()
                require('persistent-breakpoints.api').set_conditional_breakpoint(vim.fn.input(' CONDITION    '))
            end,
            "Condition breakpoint",
			opts = { silent = true },
        },
        ["<F33>"] = {  -- <C-F9>
            function()
                require('persistent-breakpoints.api').clear_all_breakpoints()
            end,
            "Clear all breakpoints",
			opts = { silent = true },
        },
    }
}

return mappings
