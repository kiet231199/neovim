local plugins = {}

plugins = {
	-- Startup -----------------------------------------------------
	['goolord/alpha-nvim'] = {
		-- Desc: Start up screen
		config = function()
			require("plugin.startup.alpha")
		end,
	},
	['folke/drop.nvim'] = {
		-- Desc: Waiting screen
		config = function()
			require("plugin.startup.drop")
		end,
	},
	['lewis6991/impatient.nvim'] = {
		-- Desc: Boost startup time
		config = function()
			require("plugin.startup.impatient")
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
		config = function()
			require("plugin.explorer.neotree")
		end,
		keys = {
			{ "<F5>", ":NeoTreeFocusToggle<CR>", mode = "", silent = true, noremap = true },
		},
	},
	['matbme/JABS.nvim'] = {
		-- Desc: Tab explorer
		config = function()
			require("plugin.explorer.jabs")
		end,
		keys = {
			{ "<tab>", "<cmd>JABSOpen<CR>", mode = "n", silent = true, noremap = true },
		},
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
		config = function()
			require("plugin.line.dropbar")
		end,
		init = function()
			require("utils").load_mappings("dropbar")
		end,
	},

	-- Git ---------------------------------------------------------
	['lewis6991/gitsigns.nvim'] = {
		-- Desc: Git icon and ultilities
		config = function()
			require("plugin.git.gitsigns")
		end,
		init = function()
			require("utils").load_mappings("gitsigns")
		end,
	},
	['rhysd/git-messenger.vim'] = {
		-- Desc: Git show commit contents
		-- TODO: Long term: Convert this plugin to lua, and can be customizable
		config = function()
			require("plugin.git.gitmessenger")
		end,
		keys = {
			{ "<F10>", "<Plug>(git-messenger)", mode = "n", silent = true, noremap = true },
		},
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
			require("plugin.finder.telescope")
		end,
		init = function()
			require("utils").load_mappings("telescope")
		end,
	},
	['AckslD/nvim-neoclip.lua'] = {
		-- Desc: Preview clipboard
		lazy = true,
		config = function()
			require("plugin.finder.neoclip")
		end,
	},

	-- Language Server Protocol ------------------------------------
	['neovim/nvim-lspconfig'] = {
		-- Desc: LSP config manager
		dependencies = {
			'folke/neodev.nvim',
			-- Desc: LSP formatter
			'lukas-reineke/lsp-format.nvim',
			'Djancyp/lsp-range-format',
		},
		config = function()
			require("plugin.lsp.lspconfig")
		end,
		init = function()
			require("utils").load_mappings("lspconfig")
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
		event = "VeryLazy",
		config = function()
			require("plugin.lsp.lspsaga")
		end,
		init = function()
			require("utils").load_mappings("lspsaga")
		end,
	},
	['https://git.sr.ht/~whynothugo/lsp_lines.nvim'] = {
		-- Desc: LSP show line diagnostics
		config = function()
			require("lsp_lines").setup()
		end,
		keys = {
			{ "<F3>", "<cmd> lua require'lsp_lines'.toggle()<CR>", mode = "", silent = true, noremap = true },
		},
	},
	['folke/trouble.nvim'] = {
		-- Desc: Show LSP diagnostics
		event = "VeryLazy",
		config = function()
			require("plugin.lsp.trouble")
		end,
	},
	['hrsh7th/nvim-cmp'] = {
		-- Desc: LSP Completion manager
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
		},
		config = function()
			require("plugin.lsp.cmp")
		end,
		event = { "InsertEnter", "CmdlineEnter" },
	},
	['hungnguyen1503/friendly-snippets'] = {
		-- Desc: Additional snippets
		event = "VeryLazy",
		pin = true,
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
        config = function()
            require("plugin.debugger.dapconfig")
        end,
		init = function()
			require("utils").load_mappings("dap")
		end,
    },
    ['rcarriga/nvim-dap-ui'] = {
        -- Desc: UI for DAP
        event = "VeryLazy",
        dependencies = { 'mfussenegger/nvim-dap' },
        config = function()
            require("plugin.debugger.dapui")
        end
    },
    ['theHamsta/nvim-dap-virtual-text'] = {
        -- Desc: Virtual text debug information
		-- ERROR: Can not toggle virtual text anymore
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
		dependencies = { 'mfussenegger/nvim-dap' },
        config = function()
            require('persistent-breakpoints').setup {
                load_breakpoints_event = { "BufReadPost" }
            }
        end,
    },

	-- Editor -----------------------------------------------------
	['numToStr/Comment.nvim'] = {
		-- Desc: Quick comment
		config = function()
			require("plugin.editor.comment.comment")
		end,
	},
	['folke/todo-comments.nvim'] = {
		-- Desc: Todo comment
		config = function()
			require("plugin.editor.comment.todo")
		end,
	},
	['s1n7ax/nvim-comment-frame'] = {
		-- Desc: Create comment block
		event = "VeryLazy",
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
		config = function()
			require("plugin.editor.comment.comment-frame")
		end,
	},
	['karb94/neoscroll.nvim'] = {
		-- Desc: Smooth scrolling
		config = function()
			require("plugin.editor.scroll.neoscroll")
		end,
	},
	['dstein64/nvim-scrollview'] = {
		-- Desc: Scrollbar
		config = function()
			require("plugin.editor.scroll.scrollview")
		end,
	},
	['gen740/SmoothCursor.nvim'] = {
		-- Desc: Cursor pointer
		config = function()
			require("plugin.editor.scroll.smoothcursor")
		end,
	},
	['VonHeikemen/searchbox.nvim'] = {
		-- Desc: Search box
		event = "VeryLazy",
		dependencies = {
			'MunifTanjim/nui.nvim',
		},
		config = function()
			require("plugin.editor.search.searchbox")
		end,
		init = function()
			require("utils").load_mappings("searchbox")
		end,
	},
	['kevinhwang91/nvim-hlslens'] = {
		-- Desc: Highlight search
		event = "VeryLazy",
		config = function()
			require("plugin.editor.search.hlslens")
		end,
	},
	['backdround/improved-search.nvim'] = {
		-- Desc: search multiple words
		event = "VeryLazy",
		config = function()
			vim.keymap.set({ "n", "x" }, "#", require("improved-search").in_place)
		end,
	},
    ['altermo/ultimate-autopair.nvim'] = {
		-- Desc: Smart placing bracket
        config = function()
            require("plugin.editor.autopair")
        end,
    },
	['kylechui/nvim-surround'] = {
		-- Desc: Smart pair
		config = function()
			require("nvim-surround").setup()
		end,
	},
	['roobert/surround-ui.nvim'] = {
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
	['kqito/vim-easy-replace'] = {
		-- Desc: Quick replace
		keys = {
			{ "<leader>ra", ":EasyReplaceWord<CR>", mode = "n", silent = true, noremap = true },
			{ "<leader>rc", ":EasyReplaceCword<CR>", mode = "n", silent = true, noremap = true },
			{ "<leader>ra", ":EasyReplaceWordInVisual<CR>", mode = "v", silent = true, noremap = true },
			{ "<leader>rc", ":EasyReplaceCwordInVisual<CR>", mode = "v", silent = true, noremap = true },
		},
	},
	['mg979/vim-visual-multi'] = {
		-- Desc: Multiple cursor
		-- TODO: Investiage to use this plugin
		event = "VeryLazy",
	},
	['Vonr/align.nvim'] = {
		-- Desc: Quick align
		event = "VeryLazy",
		config = function()
			require("plugin.editor.align")
		end,
	},
	['fedepujol/move.nvim'] = {
		-- Desc: Quick move
		event = "VeryLazy",
		pin = true,
		init = function()
			require("utils").load_mappings("move")
		end,
	},
	['nguyenvukhang/nvim-toggler'] = {
		-- Desc: Toggle word (true/false)
		event = "VeryLazy",
		config = function()
			require("nvim-toggler").setup()
		end,
	},

	-- Navigating code  ------------------------------------------------
	['folke/flash.nvim'] = {
		-- Desc: navigate code fast
		event = "VeryLazy",
		config = function()
			require("plugin.navigate.flash")
		end,
		keys = {
			{ "f", mode = { "n", "x", "o" }, function() require("flash").jump() end, },
			{ "t", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, },
		},
	},
	['sustech-data/wildfire.nvim'] = {
		-- Desc: Treesitter quick select
		event = "VeryLazy",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("wildfire").setup()
		end,
	},
    ['nvim-treesitter/nvim-treesitter-textobjects'] = {
		-- Desc: Treesitter navigate
        after = "nvim-treesitter",
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
    },

	-- Better UI ---------------------------------------------------
	['folke/noice.nvim'] = {
		-- Desc: Show message popup, LSP progress, popup commandline
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("plugin.ui.noice")
			require("telescope").load_extension("noice")
		end,
	},

	-- Window -----------------------------------------------------
	['xorid/swap-split.nvim'] = {
		-- Desc: Window choose
		keys = {
			{ "sw", "<cmd>SwapSplit<CR>", mode = "n", silent = true, noremap = true },
		},
	},
	['anuvyklack/windows.nvim'] = {
		-- Desc: Smooth window swap
		dependencies = {
			'anuvyklack/middleclass',
			'anuvyklack/animation.nvim',
		},
		config = function()
			require("plugin.ui.window.window-autowidth")
		end,
		event = "VeryLazy",
	},
	['folke/edgy.nvim'] = {
		-- Desc: manage predefine window layout
		event = "VeryLazy",
		dependencies = {
			-- Desc: Neo-tree for git outline
			'nvim-neo-tree/neo-tree.nvim',
		},
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
		event = "VeryLazy",
		config = function()
			require("plugin.ui.window.terminal")
		end,
		init = function()
			require("utils").load_mappings("terminal")
		end,
	},

	-- Colorful ----------------------------------------------------
	['itchyny/vim-cursorword'] = {
		-- Desc: Underline word undercursor
	},
	['anuvyklack/pretty-fold.nvim'] = {
		-- Desc: Fold text
		event = "VeryLazy",
		config = function()
			require("plugin.ui.fold.pretty-fold")
		end,
	},
	['yaocccc/nvim-foldsign'] = {
		-- Desc: Fold sign
		event = "VeryLazy",
		config = function()
			require("plugin.ui.fold.foldsign")
		end,
	},
	['nvim-zh/colorful-winsep.nvim'] = {
		-- Desc: Win separator
        cond = true,
		config = function()
			require("plugin.ui.window.winsep")
		end,
		event = "WinNew",
	},
	['dvoytik/hi-my-words.nvim'] = {
		-- Desc: Highlight word with many colors
		event = "VeryLazy",
		config = function()
			require("plugin.ui.himywords")
		end,
		init = function()
			require("utils").load_mappings("himywords")
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
		config = function()
			require("plugin.ui.multicolumn")
		end,
	},
	['JellyApple102/easyread.nvim'] = {
		-- Desc: Bionic highlighting
		event = "VeryLazy",
		config = function()
			require("plugin.ui.easyread")
		end,
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
		event = "VeryLazy",
		config = function()
			require("plugin.utility.sessions")
		end,
		init = function()
			require("utils").load_mappings("session")
		end,
	},
	['folke/which-key.nvim'] = {
		-- Desc: Show keymap
		event = "VeryLazy",
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
        event = "VeryLazy",
		config = function()
			require("plugin.utility.asciitree")
		end,
	},
	['christoomey/vim-tmux-navigator'] = {
		-- Desc: Switch pane between VIM and TMUX
		event = "VeryLazy",
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

	-- Plugin on testing ----------------------------------------

	-- Plugin on pending ----------------------------------------
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

