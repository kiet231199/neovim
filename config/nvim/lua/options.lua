-- Option
vim.g.mapleader = ","
vim.g.propofont = " "
vim.g.loaded_netrwPlugin = 0
vim.g.loaded_netrw = 0

local options = {
	backup         = false,                             -- creates a backup file
	cmdheight      = 1,                                 -- more space in the neovim command line for displaying messages
	completeopt    = { "menu", "menuone", "noselect" }, -- mostly just for cmp
	conceallevel   = 0,                                 -- so that `` is visible in markdown files
	fileencoding   = "utf-8",                           -- the encoding written to a file
	hlsearch       = true,                              -- highlight all matches on previous search pattern
	ignorecase     = false,                             -- ignore case in search patterns
	mouse          = "a",                               -- allow the mouse to be used in neovim
	mousemodel     = "extend",
	mousemoveevent = true,
	pumheight      = 20,                                -- pop up menu height
	showmode       = false,                             -- we don't need to see things like -- INSERT -- anymor
	showtabline    = 1,                                 -- always show tabs
	smartcase      = true,                              -- smart case
	copyindent     = true,
	smarttab       = true,                              -- make tab smarter again
	splitbelow     = true,                              -- force all horizontal splits to go below current window
	splitright     = true,                              -- force all vertical splits to go to the right of current window
	swapfile       = false,                             -- creates a swapfile
	termguicolors  = true,                              -- set term gui colors (most terminals support this)
	timeoutlen     = 700,                               -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile       = true,                              -- enable persistent undo
	updatetime     = 1000,                              -- faster completion (4000ms default)
	writebackup    = false,                             -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab      = false,                             -- convert tabs to spaces
	shiftwidth     = 4,                                 -- the number of spaces inserted for each indentation
	tabstop        = 4,                                 -- insert 4 spaces for a tab
	cursorline     = true,                              -- highlight the current line
	number         = true,                              -- set numbered lines
	relativenumber = true,                              -- set relative numbered lines
	numberwidth    = 2,                                 -- set number column width to 2 {default 4}
	signcolumn     = "auto:1-4",                        -- auto resize sign column (min = 1, max = 6)
	wrap           = false,                             -- display lines as one long line
	scrolloff      = 0,                                 -- is one of my fav
	sidescrolloff  = 0,
	wildmenu       = true,
	wildmode       = "list",
	synmaxcol      = 300,
	filetype  	   = "on",
	whichwrap  	   = "bs<>[]hl",
	diffopt        = { "vertical", "closeoff" },
	colorcolumn    = "80",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- Characters
vim.opt.listchars:append({ space = "▁", eol = "↲", tab = "░░" })
vim.opt.shortmess:append("c")
vim.opt.formatoptions:remove({ "c", "r", "o" })

-- Sign icons
vim.fn.sign_define('DapBreakpoint',          { text = ' ', texthl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text = ' ', texthl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected',  { text = ' ', texthl = 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint',            { text = ' ', texthl = 'DapLogPoint' })
vim.fn.sign_define('DapStopped',             { text = '󰁕 ', texthl = 'DapStopped' })
