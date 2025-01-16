local plugins = {}

plugins = {
	['goolord/alpha-nvim'] = {
		-- Startup -----------------------------------------------------
		-- Desc: Start up screen
		config = function()
			require("plugin.startup.alpha")
		end,
	},

	-- Colorscheme -------------------------------------------------
    -- INFO: Colorscheme is selected in plugin.colorscheme.init
	['folke/tokyonight.nvim'] = {
		-- Desc: Tokyo-night
        priority = 1100,
		config = function()
			require("plugin.colorscheme.tokyonight")
		end,
},

	-- Explorer ----------------------------------------------------
	['nvim-neo-tree/neo-tree.nvim'] = {
		-- Desc: File browser
		config = function()
			require("plugin.explorer.neotree")
		end,
		keys = require("utils").lazy_mappings("neotree")
	},
	['matbme/JABS.nvim'] = {
		-- Desc: Tab explorer
		config = function()
			require("plugin.explorer.jabs")
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

	-- Fuzy finder -------------------------------------------------
	['nvim-telescope/telescope.nvim'] = {
		-- Desc: Telescope
		dependencies = {
			-- Desc: Prevent duplicate function
			'nvim-lua/plenary.nvim',
			-- Desc: File browser
			'nvim-telescope/telescope-file-browser.nvim',
			-- Desc: Project
			'nvim-telescope/telescope-project.nvim',
			-- Desc: UI for telescope
			'nvim-telescope/telescope-ui-select.nvim',
			-- Dess: Telescope DAP
			'nvim-telescope/telescope-dap.nvim',
			-- Desc: Builtin/extension picker for telescope
			'keyvchan/telescope-find-pickers.nvim',
			-- Desc: Menu command
			'LinArcX/telescope-command-palette.nvim',
			-- Desc: Preview clipboard
			'AckslD/nvim-neoclip.lua',
			-- Desc: Show LSP diagnostics
			'folke/trouble.nvim',
		},
		config = function()
			require("plugin.telescope.telescope")
		end,
	},

	-- Language Server Protocol ------------------------------------
	['neovim/nvim-lspconfig'] = {
		-- Desc: LSP config manager
		ft = { "lua", "python", "c", "cpp", "bash", "sh", "cmake" },
		dependencies = {
			'folke/neodev.nvim',
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
		ft = { "lua", "python", "c", "cpp", "bash", "sh", "cmake" },
		config = function()
			require("plugin.lsp.trouble")
		end,
	},
	['saghen/blink.cmp'] = {
	    -- Desc: LSP Completion manager
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
			-- Desc: Completion for buffer
			'amarakon/nvim-cmp-buffer-lines',
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

	-- Better UI ---------------------------------------------------
	['kevinhwang91/nvim-hlslens'] = {
		-- Desc: Highlight search
		event = { "ModeChanged" },
		config = function()
			require("plugin.ui.search.hlslens")
		end,
		keys = require("utils").lazy_mappings("hlslens")
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

	-- Picker ------------------------------------------------------
    ['2KAbhishek/nerdy.nvim'] = {
    	-- Desc: Icon picker
        dependencies = {
            'stevearc/dressing.nvim',
            'nvim-telescope/telescope.nvim',
        },
        cmd = 'Nerdy',
    },

	-- Float terminal ----------------------------------------------
	['rebelot/terminal.nvim'] = {
		-- Desc: Float terminal
		config = function()
			require("plugin.ui.window.terminal")
		end,
		keys = require("utils").lazy_mappings("terminal")
	},
	['nvimtools/hydra.nvim'] = {
		-- Desc: Menu keymap
		-- enabled = false,
		dependencies = {
			'lewis6991/gitsigns.nvim',
			'FabijanZulj/blame.nvim',
			'sindrets/diffview.nvim',
			'nvim-telescope/telescope.nvim',
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
	['rcarriga/nvim-notify'] = {
		-- Desc: Message popup
		config = function()
			require("plugin.utility.notify")
		end,
	},
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
	-- TODO: Config Lazyload (from nvim-dap to end)
	-- TODO: Config for blinks (Esc to cancel insert, Enter to confirm selection)
	-- TODO: Config for menu
	-- TODO: Update snacks (notifier + may use terminal to replace terminal + may use dashboard to replace dashboard)
	-- TODO: Update statuscolumn + foldtext (may use snacks-statuscolumn)
	-- TODO: Check to replace telescope with fzf-lua

	['luukvbaal/statuscol.nvim'] = {
		-- Desc: Status column
		enabled = false,
		config = function()
            require("plugin.ui.window.statuscol")
		end,
	},
	['OXY2DEV/foldtext.nvim'] = {
		config = true,
	},
	['folke/snacks.nvim'] = {
		-- Desc: Collection of small ultility plugins
        priority = 1000,
		init = function()
            vim.g.animate       = true
            vim.g.bigfile       = true
            vim.g.notifier      = true
            vim.g.snacks_indent = true
            vim.g.scratch       = true
            vim.g.snacks_scroll = true

			-- Mappings
			require("utils").load_mappings("snacks_scratch")
        end,
		config = function()
			require("plugin.utility.snacks")
			-- BUG: Enable indent at start up. Unless, it sometimes does not load
			require("snacks").indent.enable()
		end
	},
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

