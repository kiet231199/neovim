require("custom.options")

local custom = {}

custom.plugins = {
	-- Startup -----------------------------------------------------
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
	['nvim-tree/nvim-tree.lua'] = {
		-- Desc: File explorer
		config = function()
			require("custom.config.nvim-tree")
		end,
		keys = {
			{ "<F5>", "<cmd>NvimTreeFindFileToggle<CR>", mode = "", silent = true, noremap = true },
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
		init = function()
			require("core.utils").load_mappings("gitsigns")
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
		keys = {
			{ "<space>", mode = "n" },
		},
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
		config = function()
			require("custom.config.trouble")
		end,
	},
	['jose-elias-alvarez/null-ls.nvim'] = {
		-- Desc: Language server for builtin language
		config = function()
			require("custom.config.null-ls")
		end,
	},
	['MunifTanjim/prettier.nvim'] = {
		-- Desc: Prettier for buitin language
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

	-- Highlighter -------------------------------------------------
	['nvim-treesitter/nvim-treesitter'] = {
		-- Desc: Code highlight
		config = function()
			require("custom.config.treesitter")
		end,
	},
	['nvim-treesitter/nvim-treesitter-textobjects'] = {
		-- Desc: Code ultilities
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
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

	-- Easy editing ------------------------------------------------
	['kqito/vim-easy-replace'] = {
		-- Desc: Quick replace
		keys = {
			{ "<leader>ra", "<cmd>EasyReplaceWord<CR>", mode = "n", silent = true, noremap = true },
			{ "<leader>rc", "<cmd>EasyReplaceCword<CR>", mode = "n", silent = true, noremap = true },
			{ "<leader>ra", "<cmd>EasyReplaceWordInVisual<CR>", mode = "v", silent = true, noremap = true },
			{ "<leader>rc", "<cmd>EasyReplaceCwordInVisual<CR>", mode = "v", silent = true, noremap = true },
		},
	},
	['Vonr/align.nvim'] = {
		-- Desc: Quick align
		config = function()
			require("custom.config.align")
		end,
		keys = {
			{ "aa", "<cmd>lua require'align'.align_to_char(1, true)<CR>", mode = "x", silent = true, noremap = true },
			{ "as", "<cmd>lua require'align'.align_to_char(2, true, true)<CR>", mode = "x", silent = true, noremap = true },
			{ "aw", "<cmd>lua require'align'.align_to_string(false, true, true)<CR>", mode = "x", silent = true, noremap = true },
			{ "ar", "<cmd>lua require'align'.align_to_string(true, true, true)<CR>", mode = "x", silent = true, noremap = true },
		}
	},
	['fedepujol/move.nvim'] = {
		-- Desc: Quick move
		pin = true,
		init = function()
			require("core.utils").load_mappings("move")
		end,
	},
	['nguyenvukhang/nvim-toggler'] = {
		-- Desc: Toggle word (true/false)
		config = function()
			require("nvim-toggler").setup()
		end,
	},
	['astaos/nvim-ultivisual'] = {
		-- Desc: Quick move by tab, quick surround
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
	['chrisgrieser/nvim-spider'] = {
	 	-- Desc: Quick move
		config = function()
			require("spider").setup({ skipInsignificantPunctuation = false })
		end,
		init = function()
			vim.keymap.set({ "n", "o", "x"}, ">", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
			-- vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-w" })
			vim.keymap.set({ "n", "o", "x" }, "<", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-w" })
			-- vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-w" })
		end,
	},

	-- Search ------------------------------------------------------
	['VonHeikemen/searchbox.nvim'] = {
		-- Desc: Search box
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
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("custom.config.noice")
		end,
	},
	['folke/which-key.nvim'] = {
		-- Desc: Show keymap
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
		-- TODO: Fix to compatible with other plugin
		dependencies = {
			'anuvyklack/middleclass',
			'anuvyklack/animation.nvim',
		},
		config = function()
			require("custom.config.windows")
		end,
		event = "WinNew",
	},

	-- Picker ------------------------------------------------------
	['ziontee113/icon-picker.nvim'] = {
		-- Desc: Icon quick search
		lazy = true,
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
		config = function()
			require("custom.config.colorpicker")
		end,
	},

	-- Float terminal ----------------------------------------------
	['rebelot/terminal.nvim'] = {
		-- Desc: Float terminal
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
		config = function()
			require("custom.config.pretty-fold")
		end,
	},
	['nvim-zh/colorful-winsep.nvim'] = {
		-- Desc: Win separator
		pin = true,
		commit = 'bb06c86',
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
		config = function()
			require("custom.config.twilight")
		end,
	},
	['Bekaboo/deadcolumn.nvim'] = {
	 	-- Desc: Page column
		config = function()
			require("custom.config.deadcolumn")
		end,
	},
	['yaocccc/nvim-foldsign'] = {
		-- Desc: Fold sign
		config = function()
			require("custom.config.foldsign")
		end,
	},
	['dvoytik/hi-my-words.nvim'] = {
		-- Desc: Highlight many colors
		config = function()
			require("hi-my-words").setup()
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
		config = function()
			require("custom.config.indentblankline")
		end,
	},

	-- Register, session ---------------------------------------
	['Shatur/neovim-session-manager'] = {
		-- Desc: Session
		config = function()
			require("custom.config.sessions")
		end,
		keys = {
			{ "sl", "<cmd>SessionManager load_last_session<CR>", mode = "n", silent = true, noremap = true },
			{ "ss", "<cmd>SessionManager save_current_session<CR>", mode = "n", silent = true, noremap = true },
			{ "sd", "<cmd>SessionManager delete_session<CR>", mode = "n", silent = true, noremap = true },
		},
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

	-- Plugin on testing ----------------------------------------
	['mrjones2014/smart-splits.nvim'] = {},
	['voldikss/vim-floaterm'] = {},
	['hungnguyen1503/friendly-snippets'] = {
		pin = true,
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
