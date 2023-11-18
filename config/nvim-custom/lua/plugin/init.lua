local plugins = {}

plugins = {
	-- Startup -----------------------------------------------------
	['goolord/alpha-nvim'] = {
		-- Desc: Start up screen
		config = function()
			require("plugin.startup.alpha")
		end,
	},

	-- Colorscheme -------------------------------------------------
    -- INFO: Colorscheme is selected in plugin.colorscheme.init
	['folke/tokyonight.nvim'] = {
		-- Desc: Tokyo-night
		config = function()
			require("plugin.colorscheme.tokyonight")
		end,
	},
    ['polirritmico/monokai-nightasty.nvim'] = {
		-- Desc: Monokai-night
		config = function()
			require("plugin.colorscheme.monokai")
		end,
    },

	-- Explorer ----------------------------------------------------
	['nvim-neo-tree/neo-tree.nvim'] = {
		-- Desc: File browser
		init = function()
			require("utils").load_mappings("neotree")
		end,
		config = function()
			require("plugin.explorer.neotree")
		end,
		cmd = "NeoTreeFocusToggle",
	},
	['matbme/JABS.nvim'] = {
		-- Desc: Tab explorer
		init = function()
			require("utils").load_mappings("jabs")
		end,
		config = function()
			require("plugin.explorer.jabs")
		end,
		cmd = "JABSOpen",
	},

	-- Tabline and Statusline --------------------------------------
	['rebelot/heirline.nvim'] = {
        -- Desc: Show both tabline and statusline
        init = function()
			vim.opt.laststatus = 2
            vim.opt.showcmdloc = 'statusline'
            vim.opt.showtabline = 2
            vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
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
		init = function()
			require("utils").load_mappings("gitsigns")
		end,
		config = function()
			require("plugin.git.gitsigns")
		end,
	},
	['rhysd/git-messenger.vim'] = {
		-- Desc: Git show commit contents
		-- TODO: Long term: Convert this plugin to lua, and can be customizable
		config = function()
			require("plugin.git.gitmessenger")
		end,
		keys = {
			{ "<F10>", mode = "", ":Gitmessenger<CR>", silent = true },
		}
	},

	-- Fuzy finder -------------------------------------------------
	['nvim-telescope/telescope.nvim'] = {
		-- Desc: Telescope
		dependencies = {
			-- Desc: Prevent duplicate function
			'nvim-lua/plenary.nvim',
			{
				-- Desc: Quick search
				'nvim-telescope/telescope-fzf-native.nvim',
				build = "make",
			},
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
		init = function()
			require("utils").load_mappings("telescope")
		end,
		config = function()
			require("plugin.telescope.telescope")
		end,
	},
	['AckslD/nvim-neoclip.lua'] = {
		-- Desc: Preview clipboard
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
		config = function()
			require("plugin.telescope.neoclip")
		end,
	},

	-- Language Server Protocol ------------------------------------
	['neovim/nvim-lspconfig'] = {
		-- Desc: LSP config manager
		ft = { "lua", "python", "c", "cpp", "bash", "cmake" },
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
		ft = { "lua", "python", "c", "cpp", "bash", "cmake" },
		init = function()
			require("utils").load_mappings("lspsaga")
		end,
		config = function()
			require("plugin.lsp.lspsaga")
		end,
	},
	['https://git.sr.ht/~whynothugo/lsp_lines.nvim'] = {
		-- Desc: LSP show line diagnostics
		config = function()
			require("lsp_lines").setup()
		end,
		keys = {
			{ "<F3>", mode = "", ":lua require('lsp_lines').toggle()<CR>", silent = true, noremap = true },
		}
	},
	['folke/trouble.nvim'] = {
		-- Desc: Show LSP diagnostics
		ft = { "lua", "python", "c", "cpp", "bash", "cmake" },
		config = function()
			require("plugin.lsp.trouble")
		end,
	},
	['hrsh7th/nvim-cmp'] = {
		-- Desc: LSP Completion manager
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			-- Desc: LSP Completion source
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lsp-document-symbol',
			'hrsh7th/cmp-nvim-lsp-signature-help',
			-- Desc: Completion for buffer
			'hrsh7th/cmp-buffer',
			'amarakon/nvim-cmp-buffer-lines',
			-- Desc: Completion for directory/file path
			'hrsh7th/cmp-path',
			-- Desc: Completion for commandline
			'hrsh7th/cmp-cmdline',
			'dmitmel/cmp-cmdline-history',
			-- Desc: Completion for ripgrep
			'lukas-reineke/cmp-rg',
			-- Desc: Completion for other stuff
			'petertriho/cmp-git',
			'delphinus/cmp-ctags',
			'bydlw98/cmp-env',
			-- Desc: Sorting completion base on priority
			'lukas-reineke/cmp-under-comparator',
			-- Desc: Snippet for LSP
			'L3MON4D3/LuaSnip',
			-- Desc: Completion for Luasnip
			'saadparwaiz1/cmp_luasnip',
			'doxnit/cmp-luasnip-choice',
			-- Desc: Additional snippets
			'hungnguyen1503/friendly-snippets',
			-- Desc: Completion for DAP
			'rcarriga/cmp-dap',
		},
		config = function()
			require("plugin.lsp.cmp")
		end,
	},

	-- Treesitter -------------------------------------------------
	['nvim-treesitter/nvim-treesitter'] = {
		-- Desc: Code highlight
		config = function()
			require("plugin.treesitter.treesitter")
		end,
	},
	['p00f/nvim-ts-rainbow'] = {
		-- Desc: Bracket color
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	},

	-- Debugger --------------------------------------------------
    ['mfussenegger/nvim-dap'] = {
        -- Desc: Debugger Adapter
		ft = { "c", "cpp" },
		init = function()
			require("utils").load_mappings("dap")
		end,
        config = function()
            require("plugin.debugger.dapconfig")
        end,
    },
    ['rcarriga/nvim-dap-ui'] = {
        -- Desc: UI for DAP
		ft = { "c", "cpp" },
        dependencies = { 'mfussenegger/nvim-dap' },
        config = function()
            require("plugin.debugger.dapui")
        end,
    },
    ['theHamsta/nvim-dap-virtual-text'] = {
        -- Desc: Virtual text debug information
		ft = { "c", "cpp" },
		dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'mfussenegger/nvim-dap'
        },
        config = function()
            require("plugin.debugger.daptext")
        end,
    },
    ['Weissle/persistent-breakpoints.nvim'] = {
        -- Desc: Conditional breakpoint
		ft = { "c", "cpp" },
		dependencies = { 'mfussenegger/nvim-dap' },
        config = function()
            require('persistent-breakpoints').setup {
                load_breakpoints_event = { "BufReadPost" }
            }
        end,
    },

	-- Editor -----------------------------------------------------
	['folke/flash.nvim'] = {
		-- Desc: navigate code fast
		config = function()
			require("plugin.editor.flash")
		end,
		keys = {
			{ "f", mode = { "n", "x", "o" }, function() require("flash").jump() end, },
			{ "t", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, },
		},
	},
	['sustech-data/wildfire.nvim'] = {
		-- Desc: Treesitter quick select
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
		config = function()
			require("wildfire").setup()
		end,
	},
    ['nvim-treesitter/nvim-treesitter-textobjects'] = {
		-- Desc: Treesitter navigate
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
    },
	['numToStr/Comment.nvim'] = {
		-- Desc: Quick comment
		ft = { "lua", "python", "c", "cpp", "bash", "cmake" },
		config = function()
			require("plugin.editor.comment.comment")
		end,
	},
	['s1n7ax/nvim-comment-frame'] = {
		-- Desc: Create comment block
		ft = { "lua", "python", "c", "cpp", "bash", "cmake" },
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
		config = function()
			require("plugin.editor.comment.comment-frame")
		end,
	},
	['folke/todo-comments.nvim'] = {
		-- Desc: Todo comment
		config = function()
			require("plugin.editor.comment.todo")
		end,
	},
    ['altermo/ultimate-autopair.nvim'] = {
		-- Desc: Smart placing bracket
		event = { "ModeChanged" },
        config = function()
            require("plugin.editor.autopair")
        end,
    },
	['kylechui/nvim-surround'] = {
		-- Desc: Smart pair
		event = { "ModeChanged" },
		config = function()
			require("nvim-surround").setup()
		end,
	},
	['roobert/surround-ui.nvim'] = {
		event = { "ModeChanged" },
		dependencies = {
			"kylechui/nvim-surround",
			"folke/which-key.nvim",
		},
		config = function()
			require("surround-ui").setup({
				root_key = "s"
			})
		end,
	},
    ['roobert/search-replace.nvim'] = {
		-- Desc: Quick replace
		config = function()
			require("search-replace").setup()
		end,
		keys = {
			{ "<leader>ra", ":SearchReplaceWithinVisualSelection<CR>",       mode = "v", silent = true, noremap = true },
			{ "<leader>rc", ":SearchReplaceWithinVisualSelectionCExpr<CR>",  mode = "v", silent = true, noremap = true },
		},
	},
	['Vonr/align.nvim'] = {
		-- Desc: Quick align
		commit = "8bfed3",
		init = function()
			require("utils").load_mappings("align")
		end,
	},
	['fedepujol/move.nvim'] = {
		-- Desc: Quick move
		pin = true,
		init = function()
			require("utils").load_mappings("move")
		end,
	},
	['nguyenvukhang/nvim-toggler'] = {
		-- Desc: Toggle word (true/false)
		config = function()
			require("nvim-toggler").setup()
		end,
	},
	['brenton-leighton/multiple-cursors.nvim'] = {
		-- Desc: Multiple cursors
		init = function()
			require("utils").load_mappings("multiplecursors")
		end,
		config = function()
			require("multiple-cursors").setup()
		end,
	},

	-- Better UI ---------------------------------------------------
	['VonHeikemen/searchbox.nvim'] = {
		-- Desc: Search box
		dependencies = {
			'MunifTanjim/nui.nvim',
		},
		init = function()
			require("utils").load_mappings("searchbox")
		end,
		config = function()
			require("plugin.ui.search.searchbox")
		end,
	},
	['kevinhwang91/nvim-hlslens'] = {
		-- Desc: Highlight search
		init = function()
			require("utils").load_mappings("hlslens")
		end,
		config = function()
			require("plugin.ui.search.hlslens")
		end,
	},
	['karb94/neoscroll.nvim'] = {
		-- Desc: Smooth scrolling
		config = function()
			require("plugin.ui.scroll.neoscroll")
		end,
	},
	['dstein64/nvim-scrollview'] = {
		-- Desc: Scrollbar
		config = function()
			require("plugin.ui.scroll.scrollview")
		end,
	},
	['gen740/SmoothCursor.nvim'] = {
		-- Desc: Cursor pointer
		config = function()
			require("plugin.ui.scroll.smoothcursor")
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

	-- Window -----------------------------------------------------
	['xorid/swap-split.nvim'] = {
		-- Desc: Window choose
		event = "WinNew",
		init = function()
			require("utils").load_mappings("swapsplit")
		end
	},
	['anuvyklack/windows.nvim'] = {
		-- Desc: Smooth window swap
		event = "WinNew",
		dependencies = {
			'anuvyklack/middleclass',
			'anuvyklack/animation.nvim',
		},
		init = function()
			require("utils").load_mappings("windows")
		end,
		config = function()
			require("plugin.ui.window.window-autowidth")
		end,
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
        dependencies = {
            'stevearc/dressing.nvim',
            'nvim-telescope/telescope.nvim',
        },
        cmd = 'Nerdy',
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

	-- Colorful ----------------------------------------------------
	['itchyny/vim-cursorword'] = {
		-- Desc: Underline word undercursor
	},
	['anuvyklack/pretty-fold.nvim'] = {
		-- Desc: Fold text
		config = function()
			require("plugin.ui.fold.pretty-fold")
		end,
	},
	['yaocccc/nvim-foldsign'] = {
		-- Desc: Fold sign
		config = function()
			require("plugin.ui.fold.foldsign")
		end,
	},
	['nvim-zh/colorful-winsep.nvim'] = {
		-- Desc: Win separator
		event = "WinNew",
		config = function()
			require("plugin.ui.window.winsep")
		end,
	},
	['dvoytik/hi-my-words.nvim'] = {
		-- Desc: Highlight word with many colors
		init = function()
			require("utils").load_mappings("himywords")
		end,
		config = function()
			require("plugin.ui.himywords")
		end,
	},
	['echasnovski/mini.trailspace'] = {
		-- Desc: Highlight, remove trailing space
		version = false,
		config = function()
			require("mini.trailspace").setup()
		end,
	},
	['lukas-reineke/indent-blankline.nvim'] = {
		-- Desc: Indentline
		config = function()
			require("plugin.ui.ibl")
		end,
	},
	['fmbarina/multicolumn.nvim'] = {
		-- Desc: Smart column
		ft = { "lua", "python", "c", "cpp", "bash", "cmake", "git" },
		config = function()
			require("plugin.ui.multicolumn")
		end,
	},
	['JellyApple102/easyread.nvim'] = {
		-- Desc: Bionic highlighting
		ft = { "text", "markdown" },
		config = function()
			require("plugin.ui.easyread")
		end,
	},

	-- Utility --------------------------------------------------
	['folke/drop.nvim'] = {
		-- Desc: Waiting screen
		config = function()
			require("plugin.utility.drop")
		end,
	},
	['rcarriga/nvim-notify'] = {
		-- Desc: Message popup
		config = function()
			require("plugin.utility.notify")
		end,
	},
	['Shatur/neovim-session-manager'] = {
		-- Desc: Session
		init = function()
			require("utils").load_mappings("session")
		end,
		config = function()
			require("plugin.utility.sessions")
		end,
	},
	['folke/which-key.nvim'] = {
		-- Desc: Show keymap
		config = function()
			require("plugin.utility.whichkey")
		end,
	},
	['trmckay/based.nvim'] = {
		-- Desc: Conver dec to hex
		config = function()
			require("plugin.utility.based")
		end,
		keys = {
			{ "<leader>bh", "<cmd>BasedConvert hex<CR>", mode = "n", silent = true, noremap = true },
			{ "<leader>bd", "<cmd>BasedConvert dec<CR>", mode = "n", silent = true, noremap = true },
		},
	},
	['cloudysake/asciitree.nvim'] = {
		-- Desc: Auto generate tree
		config = function()
			require("plugin.utility.asciitree")
		end,
		cmd = "AsciiTree",
	},
	['christoomey/vim-tmux-navigator'] = {
		-- Desc: Switch pane between VIM and TMUX
		config = function()
			vim.cmd [[
				noremap <silent> <C-b>h :<C-U>TmuxNavigateLeft<cr>
				noremap <silent> <C-b>j :<C-U>TmuxNavigateDown<cr>
				noremap <silent> <C-b>k :<C-U>TmuxNavigateUp<cr>
				noremap <silent> <C-b>l :<C-U>TmuxNavigateRight<cr>
			]]
		end,
	},
	['ryanoasis/vim-devicons'] = {
		-- Desc: devicons source for vim
	},
	['kyazdani42/nvim-web-devicons'] = {
		-- Desc: devicons source for neovim
	},

	-- Reserved plugins -----------------------------------------
	['lewis6991/impatient.nvim'] = { cond = false },
	['kqito/vim-easy-replace'] = { cond = false },
	['mg979/vim-visual-multi'] = { cond = false },

	-- Plugin on testing ----------------------------------------

	-- Plugin on pending ----------------------------------------
	['ray-x/navigator.lua'] = {}, -- check for replacing LSP saga
	['ray-x/lsp_signature.nvim'] = {}, -- check for replacing LSP signature help
	['NeogitOrg/neogit'] = {}, -- check for replacing git messenger
	['abeldekat/lazyflex.nvim'] = {},
	['soulis-1256/hoverhints.nvim'] = {},
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
