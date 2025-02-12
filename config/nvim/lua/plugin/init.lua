local plugins = {}

plugins = {
	-- Colorscheme -------------------------------------------------
	['folke/tokyonight.nvim'] = {
		-- Desc: Tokyo-night
        priority = 1100,
		config = function()
			require("plugin.colorscheme.tokyonight")
		end,
	},

	-- Explorer ----------------------------------------------------
	['matbme/JABS.nvim'] = {
		-- Desc: Tab explorer
		config = function()
			require("plugin.utility.jabs")
		end,
		keys = require("utils").lazy_mappings("jabs")
	},

	-- Tabline and Statusline --------------------------------------
	['rebelot/heirline.nvim'] = {
		-- Desc: Show both tabline and statusline
		init = function()
			vim.opt.laststatus = 2
			vim.opt.showcmdloc = 'statusline'
			vim.opt.showtabline = 2
			vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
			vim.g.dap = false -- For nvim-dap lazyload
		end,
		config = function()
			require("plugin.line.heirline")
		end,
	},
	['Bekaboo/dropbar.nvim'] = {
		-- Desc: Winbar
		init = function()
			require("utils").load_mappings("dropbar")
		end,
		config = function()
			require("plugin.line.dropbar")
		end,
	},

	-- Git ---------------------------------------------------------
	['lewis6991/gitsigns.nvim'] = {
		-- Desc: Git icon and ultilities
		config = function()
			require("plugin.git.gitsigns")
		end,
	},
	['FabijanZulj/blame.nvim'] = {
		-- Desc: Git show commit contents
		config = function()
			require("plugin.git.blame")
		end
	},
	['sindrets/diffview.nvim'] = {
		-- Desc: Show git diff
		config = function()
			require("plugin.git.diffview")
		end,
	},
	['isakbm/gitgraph.nvim'] = {
		-- Desc: Draw Git graph
		dependencies = { 'sindrets/diffview.nvim' },
		config = function()
			require("plugin.git.gitgraph")
		end,
	},

    -- Finder ------------------------------------------------------
	['folke/snacks.nvim'] = {
		-- Desc: Collection of small ultility plugins
        priority = 1000,
		init = function()
            vim.g.snacks_animate   = true
            vim.g.snacks_dashboard = true
            vim.g.snacks_bigfile   = true
            vim.g.snacks_explorer  = true
            vim.g.snacks_notifier  = true
            vim.g.snacks_picker    = true
            vim.g.snacks_indent    = true
            vim.g.snacks_scratch   = true
            vim.g.snacks_scroll    = true

			-- Mappings
			require("utils").load_mappings("snacks_explorer")
			require("utils").load_mappings("snacks_scratch")
			require("utils").load_mappings("snacks_picker")
        end,
		config = function()
			require("plugin.utility.snacks")
			-- BUG: Enable indent at start up. Unless, it sometimes does not load
			require("snacks").indent.enable()
		end
	},

	-- Language Server Protocol ------------------------------------
	['folke/lazydev.nvim'] = {
		-- Desc: Quick LuaLS configuration
		ft = { "lua" },
		opts = {
			library = { path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
	['neovim/nvim-lspconfig'] = {
		-- Desc: LSP config manager
		ft = { "lua", "python", "c", "cpp", "bash", "sh", "cmake" },
		dependencies = {
			-- Desc: LSP formatter
			'lukas-reineke/lsp-format.nvim',
			'Djancyp/lsp-range-format',
		},
		init = function()
			require("utils").load_mappings("lspconfig")
		end,
		config = function()
			require("plugin.lsp.lspconfig")
		end,
	},
	['williamboman/mason.nvim'] = {
		-- Desc: LSP installer
		config = function()
			require("plugin.lsp.mason")
		end,
		cmd = "Mason",
	},
	['glepnir/lspsaga.nvim'] = {
		-- Desc: LSP better UI
		config = function()
			require("plugin.lsp.lspsaga")
		end,
		keys = require("utils").lazy_mappings("lspsaga")
	},
	['https://git.sr.ht/~whynothugo/lsp_lines.nvim'] = {
		-- Desc: LSP show line diagnostics
		config = true,
		keys = require("utils").lazy_mappings("lsplines")
	},
	['folke/trouble.nvim'] = {
		-- Desc: Show LSP diagnostics
		config = function()
			require("plugin.lsp.trouble")
		end,
		cmd = { "Trouble" },
	},
	['saghen/blink.cmp'] = {
	    -- Desc: LSP Completion manager
	    commit = "507d0d7",
		event = { "InsertEnter", "CmdlineEnter" },
	    dependencies = {
	    	-- Desc: CMP source importer for blink.nvim
			'saghen/blink.compat',
			-- Desc: CMP colorful list
			'xzbdmw/colorful-menu.nvim',
			-- Desc: CMP for ripgrep
			'mikavilpas/blink-ripgrep.nvim',
			-- Desc: CMP for doxygen
			'paopaol/cmp-doxygen',
			-- -- Desc: Completion for commandline
			'dmitmel/cmp-cmdline-history',
	    },
	    config = function()
			require("plugin.lsp.blink")
		end,
	},

	-- Treesitter -------------------------------------------------
	['nvim-treesitter/nvim-treesitter'] = {
		-- Desc: Code highlight
		dependencies = {
			-- Desc: Treesitter navigate
			'nvim-treesitter/nvim-treesitter-textobjects',
			-- Desc: Bracket color
			'nvim-treesitter/nvim-treesitter',
            -- Desc: Beautiful help document
			'OXY2DEV/helpview.nvim',
		},
		config = function()
			require("plugin.treesitter.treesitter")
		end,
	},
	['folke/ts-comments.nvim'] = {
		-- Desc: Improve performance for TS comment
		ft = { "lua", "python", "c", "cpp", "bash", "sh", "cmake" },
        opts = {
            c = { "// %s", "/* %s */" },
            cpp = { "// %s", "/* %s */" },
        },
	},

	-- Debugger --------------------------------------------------
    ['mfussenegger/nvim-dap'] = {
        -- Desc: Debugger Adapter
        -- ft = { "c", "cpp" },
		dependencies = {
            -- Desc: UI for DAP
			'rcarriga/nvim-dap-ui',
            -- Desc: Virtual text debug information
			'theHamsta/nvim-dap-virtual-text',
            -- Desc: Conditional breakpoint
			'Weissle/persistent-breakpoints.nvim',
			-- Desc: Breakpoints navigation
			'ofirgall/goto-breakpoints.nvim',
		},
        config = function()
            vim.g.dap = true -- Update for statusline
            require("plugin.debugger.dapconfig")
        end,
        keys = require("utils").lazy_mappings("dap")
    },
    ['rcarriga/nvim-dap-ui'] = {
        -- Desc: UI for DAP
        dependencies = { 'nvim-neotest/nvim-nio' },
        lazy = true,
        config = function()
            require("plugin.debugger.dapui")
        end
    },
    ['theHamsta/nvim-dap-virtual-text'] = {
        -- Desc: Virtual text debug information
        lazy = true,
        config = function()
            require("plugin.debugger.daptext")
        end
    },
    ['Weissle/persistent-breakpoints.nvim'] = {
        -- Desc: Conditional breakpoint
        lazy = true,
        opts = {
            load_breakpoints_event = { "BufReadPost" },
        },
    },

	-- Editor -----------------------------------------------------
	['folke/flash.nvim'] = {
		-- Desc: navigate code fast
		config = function()
			require("plugin.editor.flash")
		end,
		keys = require("utils").lazy_mappings("flash")
	},
	['numToStr/Comment.nvim'] = {
		-- Desc: Quick comment
		ft = { "lua", "python", "c", "cpp", "bash", "sh", "cmake" },
		config = function()
			require("plugin.editor.comment.comment")
		end,
	},
	['folke/todo-comments.nvim'] = {
		-- Desc: Todo comment
		version = "*",
		dependencies = { 'nvim-lua/plenary.nvim', },
		config = function()
			require("plugin.editor.comment.todo")
		end,
	},
    ['altermo/ultimate-autopair.nvim'] = {
		-- Desc: Smart placing bracket
		event = { "InsertEnter" },
        config = function()
            require("plugin.editor.autopair")
        end,
    },
	['kylechui/nvim-surround'] = {
		-- Desc: Smart pair
		config = true,
	},
	['NStefan002/visual-surround.nvim'] = {
		-- Desc: Smart pair in visual mode
		event = { "ModeChanged" },
		opts = {
			surround_chars = { "{", "}", "[", "]", "(", ")", "'", '"', "`" },
		},
	},
	['kqito/vim-easy-replace'] = {
		-- Desc: Quick replace
		keys = require("utils").lazy_mappings("ezreplace")
	},
	['Vonr/align.nvim'] = {
		-- Desc: Quick align
		commit = "8bfed3",
		keys = require("utils").lazy_mappings("align")
	},
	['fedepujol/move.nvim'] = {
		-- Desc: Quick move
		pin = true,
		opts = {
            char = { enable = true },
		},
		keys = require("utils").lazy_mappings("move")
	},
	['nguyenvukhang/nvim-toggler'] = {
		-- Desc: Toggle word (true/false)
		config = true,
		keys = require("utils").lazy_mappings("toggler")
	},
	['brenton-leighton/multiple-cursors.nvim'] = {
		-- Desc: Multiple cursors
		config = true,
		keys = require("utils").lazy_mappings("multiplecursors")
	},
	['SunnyTamang/select-undo.nvim'] = {
		-- Desc: Undo on selected part
        opts = {
            line_mapping = "su",
            partial_mapping = "scu",
        }
	},

	-- Better UI ---------------------------------------------------
	['kevinhwang91/nvim-hlslens'] = {
		-- Desc: Highlight search
		event = { "ModeChanged" },
		config = function()
			require("plugin.ui.hlslens")
		end,
		keys = require("utils").lazy_mappings("hlslens")
	},
	['dstein64/nvim-scrollview'] = {
		-- Desc: Scrollbar
		config = function()
			require("plugin.ui.scrollview")
		end,
	},
	['folke/noice.nvim'] = {
		-- Desc: Show message popup, LSP progress, popup commandline
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("plugin.ui.noice")
		end,
	},
	['anuvyklack/windows.nvim'] = {
		-- Desc: Smooth window swap
		event = "WinNew",
		dependencies = {
			'anuvyklack/middleclass',
			'anuvyklack/animation.nvim',
		},
		config = function()
			require("plugin.ui.window.windows")
		end,
		keys = require("utils").lazy_mappings("windows")
	},
	['folke/edgy.nvim'] = {
		-- Desc: manage predefine window layout
		event = "CmdlineEnter",
		init = function()
			vim.opt.splitkeep = "screen"
		end,
		config = function()
			require("plugin.ui.window.edgy")
		end,
	},

	-- Float terminal ----------------------------------------------
	['rebelot/terminal.nvim'] = {
		-- Desc: Float terminal
		init = function()
			require("utils").load_mappings("terminal")
		end,
		config = function()
			require("plugin.ui.window.terminal")
		end,
	},
	['nvimtools/hydra.nvim'] = {
		-- Desc: Menu keymap
		dependencies = {
			'lewis6991/gitsigns.nvim',
			'FabijanZulj/blame.nvim',
			'sindrets/diffview.nvim',
		},
		config = function()
			require("plugin.ui.hydra")
		end,
	},

	-- Colorful ----------------------------------------------------
	['itchyny/vim-cursorword'] = {
		-- Desc: Underline word undercursor
	},
	['yaocccc/nvim-foldsign'] = {
		-- Desc: Fold sign
		config = function()
			require("plugin.ui.fold.foldsign")
		end,
	},
	['OXY2DEV/foldtext.nvim'] = {
		-- Desc: Pretty foldtext
		config = function()
            require("plugin.ui.fold.foldtext")
		end,
	},
	['nvim-zh/colorful-winsep.nvim'] = {
		-- Desc: Win separator
		commit = "e1b72c",
		event = "WinNew",
		config = function()
			require("plugin.ui.window.winsep")
		end,
	},
	['echasnovski/mini.trailspace'] = {
		-- Desc: Highlight, remove trailing space
		event = "VeryLazy",
		version = false,
		config = true,
	},
	['fmbarina/multicolumn.nvim'] = {
		-- Desc: Smart column
		ft = { "lua", "python", "c", "cpp", "bash", "sh", "cmake", "git" },
		config = function()
			require("plugin.ui.multicolumn")
		end,
	},
	['NStefan002/screenkey.nvim'] = {
		-- Desc: Key tracking
		config = function()
			require("plugin.ui.screenkey")
		end,
		keys = require("utils").lazy_mappings("screenkey")
	},

	-- Utility --------------------------------------------------
	['Shatur/neovim-session-manager'] = {
		-- Desc: Session
		config = function()
			require("plugin.utility.sessions")
		end,
		keys = require("utils").lazy_mappings("session")
	},
	['folke/which-key.nvim'] = {
		-- Desc: Show keymap
		config = function()
			require("plugin.utility.whichkey")
		end,
	},
	['christoomey/vim-tmux-navigator'] = {
		-- Desc: Switch pane between VIM and TMUX
		keys = require("utils").lazy_mappings("tmux")
	},
    ['RaafatTurki/hex.nvim'] = {
		-- Desc: The same to hex dump
		cmd = { "HexDump", "HexAssemble", "HexToggle" },
		config = true,
	},
	['Dan7h3x/LazyDo'] = {
		-- Desc: Tasks noting
		event = "VeryLazy",
		config = function()
			require("plugin.ui.lazydo")
		end,
		keys = require("utils").lazy_mappings("lazydo")
	},
	['ryanoasis/vim-devicons'] = {
		-- Desc: devicons source for vim
	},
	['kyazdani42/nvim-web-devicons'] = {
		-- Desc: devicons source for neovim
	},

	-- Plugin on testing ----------------------------------------
	['nvzone/menu'] = {
		-- Desc: Utility menu
		dependencies = {
			-- Desc: UI framework
			'nvzone/volt',
		},
		keys = require("utils").lazy_mappings("menu")
	},

	-- Plugin on pending ----------------------------------------
	-- ERROR: Check blink commit to fix critical error
	-- TODO: Config for menu + hydra
	-- TODO: Update snacks picker to use with Todo (Currently, it's a bug from Snacks)

}

-- Load lazy (plugin manager)
local lazy_exits, lazy = pcall(require, "lazy")

if lazy_exits then
	-- Override with default plugins with user ones
	plugins = require("utils").merge_plugins(plugins)

	-- Overide lazy options with user ones
	local options = require("plugin.lazy")
	options = require("utils").load_override(options, "folke/lazy.nvim")

	-- Load plugins and options
	lazy.setup(plugins, options)
end

