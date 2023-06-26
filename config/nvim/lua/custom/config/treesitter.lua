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
})

-- Only need to run on the first time, then comment it
-- if vim.fn.has("win32") == 1 then
-- 	install.compilers = { "x86_64-w64-mingw32-clang", "gcc", "g++" }
-- else
-- 	install.compilers = { "clang", "gcc" }
-- end
