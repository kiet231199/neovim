local custom = {}

custom.plugins = { -- Startup -----------------------------------------------------
	['goolord/alpha-nvim'] = {
		-- Desc: Start up screen
		config = function()
			require("custom.config.alpha")
		end,
	},
	['folke/drop.nvim'] = {
		-- Desc: Waiting screen
		config = function()
			require("custom.config.drop")
		end,
	},
	['lewis6991/impatient.nvim'] = {
		-- Desc: Boost startup time
		config = function()
			require("custom.config.impatient")
		end,
	},

	-- Colorscheme -------------------------------------------------
	['folke/tokyonight.nvim'] = {
		-- Desc: Colorscheme manager
		config = function()
			require("custom.config.tokyonight")
			vim.cmd("colorscheme tokyonight")
		end,
	},

	-- Workspace ---------------------------------------------------
	['nvim-neo-tree/neo-tree.nvim'] = {
		-- Desc: File browser
		-- INFO: Need to reconfigure highlight
		config = function()
			require("custom.config.neotree")
		end,
		keys = {
			{ "<F5>", ":NeoTreeFocusToggle<CR>", mode = "", silent = true, noremap = true },
		},
	},
	['matbme/JABS.nvim'] = {
		-- Desc: Tab explorer
		config = function()
			require("custom.config.jabs")
		end,
		keys = {
			{ "<tab>", "<cmd>JABSOpen<CR>", mode = "n", silent = true, noremap = true },
		},
	},

	-- Tabline and Statusline --------------------------------------
	['nvim-lualine/lualine.nvim'] = {
		-- Desc: Status line
		-- TODO: Config for dynamic lualine
		config = function()
			require("custom.config.lualine")
		end,
	},
	['kdheepak/tabline.nvim'] = {
		-- Desc: Tabline
		config = function()
			require("custom.config.tabline")
		end,
	},

	-- Git ---------------------------------------------------------
	['lewis6991/gitsigns.nvim'] = {
		-- Desc: Git icon
		config = function()
			require("custom.config.gitsigns")
		end,
		init = function()
			require("core.utils").load_mappings("gitsigns")
		end,
	},
	['rhysd/git-messenger.vim'] = {
		-- Desc: Git show commit contents
		config = function()
			require("custom.config.gitmessenger")
		end,
		keys = {
			{ "<F10>", "<Plug>(git-messenger)", mode = "n", silent = true, noremap = true },
		},
	},
	['sindrets/diffview.nvim'] = {
		-- Desc: Git watch diffview
		pin = true,
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		commit = '03deb5',
		config = function()
			require("custom.config.diffview")
		end,
		cmd = "DiffviewOpen",
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
			-- Desc: Icon quick search
			'ziontee113/icon-picker.nvim',
			-- Desc: Color quick search
			'ziontee113/color-picker.nvim',
		},
		config = function()
			require("custom.config.telescope")
		end,
		init = function()
			require("core.utils").load_mappings("telescope")
		end,
	},
	['AckslD/nvim-neoclip.lua'] = {
		-- Desc: Preview clipboard
		lazy = true,
		config = function()
			require("custom.config.neoclip")
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
			require("custom.config.lspconfig")
		end,
		init = function()
			require("core.utils").load_mappings("lspconfig")
		end,
	},
	['williamboman/mason.nvim'] = {
		-- Desc: LSP installer
		config = function()
			require("custom.config.mason")
		end,
		cmd = "Mason",
	},
	['glepnir/lspsaga.nvim'] = {
		-- Desc: LSP better UI
		event = "VeryLazy",
		dependencies = {
			'anuvyklack/windows.nvim',
		},
		config = function()
			require("custom.config.lspsaga")
		end,
		init = function()
			require("core.utils").load_mappings("lspsaga")
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
			require("custom.config.trouble")
		end,
	},
	['jose-elias-alvarez/null-ls.nvim'] = {
		-- Desc: Language server for builtin language
		event = "VeryLazy",
		config = function()
			require("custom.config.null-ls")
		end,
	},
	['MunifTanjim/prettier.nvim'] = {
		-- Desc: Prettier for buitin language
		event = "VeryLazy",
		config = function()
			require("custom.config.prettier")
		end,
	},

	-- LSP completion source ---------------------------------------
	['hrsh7th/nvim-cmp'] = {
		-- Desc: Completion manager
		dependencies = {
			-- Desc: Completion for LSP
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
			require("custom.config.cmp")
		end,
		event = { "InsertEnter", "CmdlineEnter" },
	},
	['hungnguyen1503/friendly-snippets'] = {
		-- Desc: Additional snippets
		event = "VeryLazy",
		pin = true,
	},

	-- Highlighter -------------------------------------------------
	['nvim-treesitter/nvim-treesitter'] = {
		-- Desc: Code highlight
		config = function()
			require("custom.config.treesitter")
		end,
	},
	['p00f/nvim-ts-rainbow'] = {
		-- Desc: Bracket color
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
	},

	-- Bracket -----------------------------------------------------
	['ZhiyuanLck/smart-pairs'] = {
		-- Desc: Smart placing bracket
		config = function()
			require("pairs"):setup({ enter = { enable_mapping = false } })
		end,
		event = "InsertEnter",
	},
	['abecodes/tabout.nvim'] = {
		-- Desc: Tabout of bracket
		config = function()
			require("custom.config.tabout")
		end,
		init = function()
			require("core.utils").load_mappings("tabout")
		end,
	},

	-- Commenter ---------------------------------------------------
	['numToStr/Comment.nvim'] = {
		-- Desc: Quick comment
		config = function()
			require("custom.config.comment")
		end,
	},
	['folke/todo-comments.nvim'] = {
		-- Desc: Todo comment
		config = function()
			require("custom.config.todo")
		end,
	},
	['s1n7ax/nvim-comment-frame'] = {
		-- Desc: Create comment block
		event = "VeryLazy",
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
		config = function()
			require("custom.config.comment-frame")
		end,
	},

	-- Easy editing ------------------------------------------------
	['kqito/vim-easy-replace'] = {
		-- Desc: Quick replace
		keys = {
			{ "<leader>ra", ":EasyReplaceWord<CR>", mode = "n", silent = true, noremap = true },
			{ "<leader>rc", ":EasyReplaceCword<CR>", mode = "n", silent = true, noremap = true },
			{ "<leader>ra", ":EasyReplaceWordInVisual<CR>", mode = "v", silent = true, noremap = true },
			{ "<leader>rc", ":EasyReplaceCwordInVisual<CR>", mode = "v", silent = true, noremap = true },
		},
	},
	['AckslD/muren.nvim'] = {
		-- Desc: replace pattern
		config = function()
			require("custom.config.muren")
		end,
		keys = {
			{ "<leader>rp", ":MurenToggle<CR>", mode = "n", silent = true, noremap = true },
		}
	},
	['Vonr/align.nvim'] = {
		-- Desc: Quick align
		event = "VeryLazy",
		config = function()
			require("custom.config.align")
		end,
	},
	['fedepujol/move.nvim'] = {
		-- Desc: Quick move
		event = "VeryLazy",
		pin = true,
		init = function()
			require("core.utils").load_mappings("move")
		end,
	},
	['nguyenvukhang/nvim-toggler'] = {
		-- Desc: Toggle word (true/false)
		event = "VeryLazy",
		config = function()
			require("nvim-toggler").setup()
		end,
	},
	['astaos/nvim-ultivisual'] = {
		-- Desc: Quick move by tab, quick surround
		event = "VeryLazy",
		config = function()
			require("custom.config.ultivisual")
		end,
	},
	['kylechui/nvim-surround'] = {
		-- Desc: Smart pair
		config = function()
			require("nvim-surround").setup()
		end,
		event = "InsertEnter",
	},
	['folke/flash.nvim'] = {
		-- Desc: navigate code fast
		event = "VeryLazy",
		config = function()
			require("custom.config.flash")
		end,
		keys = {
			{ "f", mode = { "n", "x", "o" }, function() require("flash").jump() end, },
			{ "t", mode = { "n", "x", "o" }, function() require("flash").treesitter_search() end, },
			{ "T", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, },
		},
	},

	-- Search ------------------------------------------------------
	['VonHeikemen/searchbox.nvim'] = {
		-- Desc: Search box
		event = "VeryLazy",
		dependencies = {
			'MunifTanjim/nui.nvim',
		},
		config = function()
			require("custom.config.searchbox")
		end,
		init = function()
			require("core.utils").load_mappings("searchbox")
		end,
	},
	['kevinhwang91/nvim-hlslens'] = {
		-- Desc: Highlight search
		event = "VeryLazy",
		config = function()
			require("custom.config.hlslens")
		end,
	},

	-- Scroll ------------------------------------------------------
	['karb94/neoscroll.nvim'] = {
		-- Desc: Smooth scrolling
		config = function()
			require("custom.config.neoscroll")
		end,
	},
	['dstein64/nvim-scrollview'] = {
		-- Desc: Scrollbar
		config = function()
			require("custom.config.scrollview")
		end,
	},
	['gen740/SmoothCursor.nvim'] = {
		-- Desc: Cursor pointer
		config = function()
			require("custom.config.smoothcursor")
		end,
	},

	-- Better UI ---------------------------------------------------
	['rcarriga/nvim-notify'] = {
		-- Desc: Message popup
		config = function()
			require("custom.config.notify")
		end,
	},
	['folke/noice.nvim'] = {
		-- Desc: Show message popup, LSP progress, popup commandline
		-- INFO: Disable on neovide
		enabled = vim.g.neovide == nil,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("custom.config.noice")
			require("telescope").load_extension("noice")
		end,
	},
	['folke/which-key.nvim'] = {
		-- Desc: Show keymap
		event = "VeryLazy",
		config = function()
			require("custom.config.whichkey")
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
			require("custom.config.window-autowidth")
		end,
		event = "WinNew",
	},
	['folke/edgy.nvim'] = {
		-- Desc: manage predefine window layout
		-- INFO: Need to be reconfigure with neotree
		event = "VeryLazy",
		dependencies = {
			-- Desc: Neo-tree for git outline
			'nvim-neo-tree/neo-tree.nvim',
		},
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
		config = function()
			require("custom.config.edgy")
		end,
	},

	-- Picker ------------------------------------------------------
	['ziontee113/icon-picker.nvim'] = {
		-- Desc: Icon quick search
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			'stevearc/dressing.nvim',
		},
		config = function()
			require("custom.config.iconpicker")
		end,
	},
	['ziontee113/color-picker.nvim'] = {
		-- Desc: Color quick search
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("custom.config.colorpicker")
		end,
	},

	-- Float terminal ----------------------------------------------
	['rebelot/terminal.nvim'] = {
		-- Desc: Float terminal
		event = "VeryLazy",
		config = function()
			require("custom.config.terminal")
		end,
		init = function()
			require("core.utils").load_mappings("terminal")
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
			require("custom.config.pretty-fold")
		end,
	},
	['nvim-zh/colorful-winsep.nvim'] = {
		-- Desc: Win separator
		config = function()
			require("custom.config.winsep")
		end,
		event = "WinNew",
	},
	['folke/zen-mode.nvim'] = {
		-- Desc: Focus on function (pair with twilight)
		dependencies = {
			'folke/twilight.nvim',
		},
		config = function()
			require("custom.config.zenmode")
		end,
		keys = {
			{ "<F7>", "<cmd>ZenMode<CR>", mode = "", silent = true, noremap = true },
		},
	},
	['folke/twilight.nvim'] = {
		-- Desc: Focus on function
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("custom.config.twilight")
		end,
	},
	['Bekaboo/deadcolumn.nvim'] = {
	 	-- Desc: Page column
		event = "VeryLazy",
		config = function()
			require("custom.config.deadcolumn")
		end,
	},
	['yaocccc/nvim-foldsign'] = {
		-- Desc: Fold sign
		event = "VeryLazy",
		config = function()
			require("custom.config.foldsign")
		end,
	},
	['dvoytik/hi-my-words.nvim'] = {
		-- Desc: Highlight word with many colors
		event = "VeryLazy",
		config = function()
			require("custom.config.himywords")
		end,
		init = function()
			require("core.utils").load_mappings("himywords")
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
			require("custom.config.indentblankline")
		end,
	},

	-- Register, session ---------------------------------------
	['Shatur/neovim-session-manager'] = {
		-- Desc: Session
		event = "VeryLazy",
		config = function()
			require("custom.config.sessions")
		end,
		init = function()
			require("core.utils").load_mappings("session")
		end,
	},

	-- Minimap --------------------------------------------------
	['gorbit99/codewindow.nvim'] = {
		-- Desc: Minimap window
		config = function()
			require("custom.config.codewindow")
		end,
		keys = {
			{ "<F4>", "<cmd>lua require'codewindow'.toggle_minimap()<CR>", mode = "", silent = true, noremap = true },
		}
	},
	-- Winbar ---------------------------------------------------
	['Bekaboo/dropbar.nvim'] = {
	 	-- Desc: Dropping winbar
		-- FIXME: Temporarily disabled winbar on window
		enabled = vim.fn.has("unix") == 1,
		config = function()
			require("custom.config.dropbar")
		end,
		init = function()
			require("core.utils").load_mappings("dropbar")
		end,
	},

	-- Utility --------------------------------------------------
	['trmckay/based.nvim'] = {
		-- Desc: Conver dec to hex
		config = function()
			require("custom.config.based")
		end,
		keys = {
			{ "<leader>bh", "<cmd>BasedConvert hex<CR>", mode = "n", silent = true, noremap = true },
			{ "<leader>bd", "<cmd>BasedConvert dec<CR>", mode = "n", silent = true, noremap = true },
		},
	},
	['cloudysake/asciitree.nvim'] = {
		-- Desc: Auto generate tree
		config = function()
			require("custom.config.asciitree")
		end,
		cmd = "Asciitree",
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
	-- Plugin on testing ----------------------------------------
	['JellyApple102/easyread.nvim'] = {
		-- Desc: Bionic highlighting
		event = "VeryLazy",
		config = function()
			require("custom.config.easyread")
		end,
	},
	['m4xshen/hardtime.nvim'] = {
		-- Desc: Remind
		-- INFO: Need to update Hint message, this plugin is in early
		event = "VeryLazy",
		config = function()
			require("custom.config.hardtime")
		end,
	},

	-- Icon source (need to be placed at the end) ------------------
	['ryanoasis/vim-devicons'] = {
		-- Desc: devicons source for vim
	},
	['kyazdani42/nvim-web-devicons'] = {
		-- Desc: devicons source for neovim
	},
}

custom.highlights = require("custom.highlights")

custom.mappings = require("custom.mappings")

return custom
