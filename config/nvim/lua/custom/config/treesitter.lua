local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

local status_ok, install = pcall(require, "nvim-treesitter.install")
if not status_ok then
	return
end

-- build in text objects.
-- @block.inner
-- @block.outer
-- @call.inner
-- @call.outer
-- @class.inner
-- @class.outer
-- @comment.outer
-- @conditional.inner
-- @conditional.outer
-- @frame.inner
-- @frame.outer
-- @function.inner
-- @function.outer
-- @loop.inner
-- @loop.outer
-- @parameter.inner
-- @parameter.outer
-- @scopename.inner
-- @statement.outer

configs.setup({
    -- ensure_installed = { "c", "cpp"}, -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
    sync_install = true,
    auto_install = false,
	highlight = {
		enable = true, -- false will disable the whole extension
        use_languagetree = true,
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = {} },

    rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- termcolors = {} -- table of colour name strings
		colors = {
			'#458588',
			'#b16286',
			'#cc241d',
			'#d65d0e',
			'#458588',
			'#b16286',
			'#cc241d',
			'#d65d0e',
			'#458588',
			'#b16286',
			'#cc241d',
			'#d65d0e',
			'#458588',
			'#b16286',
			'#cc241d',
			'#d65d0e',
		},
		termcolors = {
			'brown',
			'Darkblue',
			'darkgray',
			'darkgreen',
			'darkcyan',
			'darkred',
			'darkmagenta',
			'brown',
			'gray',
			'black',
			'darkmagenta',
			'Darkblue',
			'darkgreen',
			'darkcyan',
			'darkred',
			'red',
		},
	},
	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = { query = "@function.outer", desc = "choose all function" },
				["if"] = { query = "@function.inner", desc = "choose content of function" },
				["as"] = { query = "@class.outer", desc = "choose all class" },
				["is"] = { query = "@class.inner", desc = "choose content of class" },
				["am"] = { query = "@call.outer", desc = "" },
				["im"] = { query = "@call.inner", desc = "" },
				["aa"] = { query = "@parameter.outer", desc = "" },
				["ia"] = { query = "@parameter.inner", desc = "" },
				["al"] = { query = "@loop.outer", desc = "" },
				["il"] = { query = "@loop.inner", desc = "" },
				["ai"] = { query = "@conditional.outer", desc = "choose all condition" },
				["ii"] = { query = "@conditional.inner", desc = "choose content of condition" },
				["a/"] = { query = "@comment.outer", desc = "choose content of comment" },
			},
		},
		move = {
			enable = false,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]f"] = "@function.outer",
				["]s"] = "@class.outer",
				["]a"] = "@parameter.outer",
				["]m"] = "@call.outer",
				["]b"] = "@block.outer",
				["]i"] = "@conditional.outer",
				["]l"] = "@loop.outer",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]S"] = "@class.outer",
				["]A"] = "@parameter.outer",
				["]B"] = "@block.outer",
				["]M"] = "@call.outer",
				["]I"] = "@conditional.outer",
				["]L"] = "@loop.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[s"] = "@class.outer",
				["[a"] = "@parameter.outer",
				["[m"] = "@call.outer",
				["[b"] = "@block.outer",
				["[i"] = "@conditional.outer",
				["[l"] = "@loop.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[S"] = "@class.outer",
				["[A"] = "@parameter.outer",
				["[M"] = "@call.outer",
				["[B"] = "@block.outer",
				["[I"] = "@conditional.outer",
				["[L"] = "@loop.outer",
			},
		},
	}
})

-- Only need to run on the first time, then comment it
-- if vim.fn.has("win32") == 1 then
-- 	install.compilers = { "x86_64-w64-mingw32-clang", "gcc", "g++" }
-- else
-- 	install.compilers = { "clang", "gcc" }
-- end
