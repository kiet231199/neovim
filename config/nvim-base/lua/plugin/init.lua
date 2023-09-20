local plugins = {}

plugins = {
	-- Startup -----------------------------------------------------
	['goolord/alpha-nvim'] = {
		-- Desc: Start up screen
		config = function()
			require("plugin.startup.alpha")
		end,
	},
	['lewis6991/impatient.nvim'] = {
		-- Desc: Boost startup time
		config = function()
			require("plugin.startup.impatient")
		end,
	},

	-- Colorscheme -------------------------------------------------
	['folke/tokyonight.nvim'] = {
		-- Desc: Colorscheme manager
		config = function()
			require("plugin.colorscheme.tokyonight")
			vim.cmd("colorscheme tokyonight")
		end,
	},

	-- Explorer ----------------------------------------------------
	['nvim-neo-tree/neo-tree.nvim'] = {
		-- Desc: File browser
		-- INFO: Need to reconfigure highlight
		config = function()
			require("plugin.explorer.neotree")
		end,
		keys = {
			{ "<F5>", ":NeoTreeFocusToggle<CR>", mode = "", silent = true, noremap = true },
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
		-- FIXME: Temporarily disabled winbar on window
		enabled = vim.fn.has("unix") == 1,
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
			-- Desc: Icon quick search
			'ziontee113/icon-picker.nvim',
			-- Desc: Color quick search
			'ziontee113/color-picker.nvim',
		},
		config = function()
			require("plugin.finder.telescope")
		end,
		init = function()
			require("utils").load_mappings("telescope")
		end,
	},

	-- Window -----------------------------------------------------
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
	['nvim-zh/colorful-winsep.nvim'] = {
		-- Desc: Win separator
        cond = true,
		config = function()
			require("plugin.ui.window.winsep")
		end,
		event = "WinNew",
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
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
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
	['dstein64/nvim-scrollview'] = {
		-- Desc: Scrollbar
		config = function()
			require("plugin.editor.scroll.scrollview")
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
			require("plugin.editor.tabout")
		end,
		init = function()
			require("utils").load_mappings("tabout")
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
			require("plugin.ui.indentblankline")
		end,
	},
	['fmbarina/multicolumn.nvim'] = {
		-- Desc: Smart column
		config = function()
			require("plugin.ui.multicolumn")
		end,
	},

	-- Utility --------------------------------------------------
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
	['ryanoasis/vim-devicons'] = {
		-- Desc: devicons source for vim
	},
	['kyazdani42/nvim-web-devicons'] = {
		-- Desc: devicons source for neovim
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

