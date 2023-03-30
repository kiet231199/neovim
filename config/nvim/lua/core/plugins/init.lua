local plugins = {
	-- Startup -----------------------------------------------------
	['lewis6991/impatient.nvim'] = {
		-- Desc: Boost startup time
		priority = 1000,
		config = function()
			require("core.plugins.config.impatient")
		end,
	},
	-- Colorscheme -------------------------------------------------
	["folke/tokyonight.nvim"] = {
		-- Desc: Colorscheme manager
		config = function()
			require("core.plugins.config.tokyonight")
			vim.cmd("colorscheme tokyonight")
		end,
	},
	-- Workspace ---------------------------------------------------
	['nvim-tree/nvim-tree.lua'] = {
		-- Desc: File explorer
		config = function()
			require("core.plugins.config.nvim-tree")
		end,
		keys = {
			{ "<F5>", "<cmd>NvimTreeFindFileToggle<CR>", mode = "", silent = true, noremap = true },
		},
	},
	-- Tabline and Statusline --------------------------------------
	['nvim-lualine/lualine.nvim'] = {
		-- Desc: Status line
		-- TODO: Config for dynamic lualine
		priority = 998,
		config = function()
			require("core.plugins.config.lualine")
		end,
	},
	['kdheepak/tabline.nvim'] = {
		-- Desc: Tabline
		priority = 998,
		config = function()
			require("core.plugins.config.tabline")
		end,
	},
	-- Git ---------------------------------------------------------
	['lewis6991/gitsigns.nvim'] = {
		-- Desc: Git icon
		config = function()
			require("core.plugins.config.gitsigns")
		end,
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
			require("core.plugins.config.telescope")
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
			require("plugins.core.config.neoclip")
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
			require("core.plugins.config.lspconfig")
		end,
		init = function()
			require("core.utils").load_mappings("lspconfig")
		end,
	},
	['williamboman/mason.nvim'] = {
		-- Desc: LSP installer
		config = function()
			require("core.plugins.config.mason")
		end,
		cmd = "Mason",
	},
	['glepnir/lspsaga.nvim'] = {
		-- Desc: LSP better UI
		event = 'BufRead',
		dependencies = {
			'anuvyklack/windows.nvim',
		},
		config = function()
			require("core.plugins.config.lspsaga")
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
	['jose-elias-alvarez/null-ls.nvim'] = {
		-- Desc: Language server for builtin language
		config = function()
			require("core.plugins.config.null-ls")
		end,
	},
	['MunifTanjim/prettier.nvim'] = {
		-- Desc: Prettier for buitin language
		config = function()
			require("core.plugins.config.prettier")
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
			require("core.plugins.config.cmp")
		end,
		event = { "InsertEnter", "CmdlineEnter" },
	},

	-- Highlighter -------------------------------------------------
	['nvim-treesitter/nvim-treesitter'] = {
		-- Desc: Code highlight
		config = function()
			require("core.plugins.config.treesitter")
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
			require("pairs"):setup()
		end,
		event = "InsertEnter",
	},
	['kylechui/nvim-surround'] = {
		-- Desc: Smart pair
		config = function()
			require("nvim-surround").setup()
		end,
		event = "InsertEnter",
	},
	['kevinhwang91/nvim-hlslens'] = {
		-- Desc: Highlight search
		config = function()
			require("core.plugins.config.hlslens")
		end,
	},
	-- Scroll ------------------------------------------------------
	['dstein64/nvim-scrollview'] = {
		-- Desc: Scrollbar
		config = function()
			require("core.plugins.config.scrollview")
		end,
	},
	-- Float terminal ----------------------------------------------
	['akinsho/toggleterm.nvim'] = {
		-- Desc: float terminal
		-- TODO: Config to be more stable
		config = function()
			require("core.plugins.config.toggleterm")
		end,
		init = function()
			require("core.utils").load_mappings("toggleterm")
		end,
		keys = {
			{ "<F8>", "<cmd>ToggleTerm direction=float<CR>", mode = "n", silent = true, noremap = true },
		},
	},
	['anuvyklack/pretty-fold.nvim'] = {
		-- Desc: Fold text
		config = function()
			require("core.plugins.config.pretty-fold")
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
	['yaocccc/nvim-foldsign'] = {
		-- Desc: Fold sign
		config = function()
			require("core.plugins.config.foldsign")
		end,
	},
	['shellRaining/hlchunk.nvim'] = {
		-- Desc: Indent highlights
		config = function()
			require("core.plugins.config.hlchunk")
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

-- Load lazy (plugin manager)
local lazy_exits, lazy = pcall(require, "lazy")

if lazy_exits then
	-- Override with default plugins with user ones
	plugins = require("core.utils").merge_plugins(plugins)

	-- Overide lazy options with user ones
	local options = require("core.lazy")
	options = require("core.utils").load_override(options, "folke/lazy.nvim")

	-- Load plugins and options
	lazy.setup(plugins, options)
end
