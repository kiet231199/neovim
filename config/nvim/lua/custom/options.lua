vim.g.mapleader = ","

local options = {
	backup         = false,                             -- creates a backup file
	clipboard      = "unnamedplus",                     -- allows neovim to access the system clipboard
	cmdheight      = 1,                                 -- more space in the neovim command line for displaying messages
	completeopt    = { "menu", "menuone", "noselect" }, -- mostly just for cmp
	conceallevel   = 0,                                 -- so that `` is visible in markdown files
	fileencoding   = "utf-8",                           -- the encoding written to a file
	hlsearch       = true,                              -- highlight all matches on previous search pattern
	ignorecase     = false,                             -- ignore case in search patterns
	mouse          = "a",                               -- allow the mouse to be used in neovim
	mousemodel     = "popup",
	mousemoveevent = true,
	pumheight      = 20,                                -- pop up menu height
	showmode       = false,                             -- we don't need to see things like -- INSERT -- anymor
	showtabline    = 1,                                 -- always show tabs
	smartcase      = true,                              -- smart case
	smartindent    = true,                              -- make indenting smarter again
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
	signcolumn     = "yes",                             -- always show the sign column, otherwise it would shift the text each time
	wrap           = false,                             -- display lines as one long line
	scrolloff      = 0,                                 -- is one of my fav
	sidescrolloff  = 8,
	wildmenu       = true,
	wildmode       = "list",
	synmaxcol      = 300,
	filetype  	   = "on",
	whichwrap  	   = "bs<>[]hl",
	diffopt        = { "vertical", "closeoff" },
	colorcolumn    = "80",
}

vim.opt.listchars:append "space:▁"
vim.opt.listchars:append "eol:↲"
vim.opt.listchars:append "tab:░░"

vim.opt.shortmess:append "c"
vim.opt.iskeyword:append "-"
vim.opt.whichwrap:append "<,>,[,],h,l"

vim.opt.formatoptions:remove({ "c", "r", "o" })

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- Set limitation for git commit
vim.cmd 'autocmd Filetype gitcommit setlocal spell textwidth=72'

-- Autocmd
-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	command = "silent! lua vim.highlight.on_yank({ timeout = 500 })",
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
})

-- User define function
function IsView()
	if vim.o.number == true then
		vim.o.signcolumn = "no"
		vim.o.number = false
		vim.o.relativenumber = false
		vim.o.mouse = ""
		vim.cmd("IndentBlanklineDisable")
		vim.cmd("ScrollViewDisable")
	else
		vim.o.signcolumn = "yes"
		vim.o.number = true
		vim.o.relativenumber = true
		vim.o.mouse = "a"
		vim.cmd("IndentBlanklineEnable")
		vim.cmd("ScrollViewEnable")
	end
end

function SetGlobalStatusLine()
	if vim.o.laststatus == 3 then
		vim.o.laststatus = 2
	else
		vim.o.laststatus = 3
	end
end
