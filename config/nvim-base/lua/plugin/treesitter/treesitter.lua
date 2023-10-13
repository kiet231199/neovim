local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

local status_ok, install = pcall(require, "nvim-treesitter.install")
if not status_ok then
	return
end

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
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["[f"] = { query = "@function.outer", desc = "next function start point" },
                ["[s"] = { query = "@class.outer", desc = "next struct start point" },
                ["[a"] = { query = "@parameter.outer", desc = "next param" },
                ["[i"] = { query = "@conditional.outer", desc = "next conditional start point" },
                ["[l"] = { query = "@loop.outer", desc = "next loop start point" },
            },
            goto_next_end= {
                ["]f"] = { query = "@function.outer", desc = "next function end point" },
                ["]s"] = { query = "@class.outer", desc = "next struct end point" },
                ["]a"] = { query = "@parameter.outer", desc = "next param" },
                ["]i"] = { query = "@conditional.outer", desc = "next conditional end point" },
                ["]l"] = { query = "@loop.outer", desc = "next loop end point" },
            },
            goto_previous_start = {
                ["[F"] = { query = "@function.outer", desc = "prev function start point" },
                ["[S"] = { query = "@class.outer", desc = "prev struct start point" },
                ["[A"] = { query = "@parameter.outer", desc = "prev param" },
                ["[I"] = { query = "@conditional.outer", desc = "prev conditional start point" },
                ["[L"] = { query = "@loop.outer", desc = "prev loop start point" },
            },
            goto_previous_end = {
                ["]F"] = { query = "@function.outer", desc = "prev function end point" },
                ["]S"] = { query = "@class.outer", desc = "prev struct end point" },
                ["]A"] = { query = "@parameter.outer", desc = "prev param" },
                ["]I"] = { query = "@conditional.outer", desc = "prev conditional end point" },
                ["]L"] = { query = "@loop.outer", desc = "prev loop end point" },
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
