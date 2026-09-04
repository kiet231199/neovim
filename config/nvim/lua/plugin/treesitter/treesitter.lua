-- nvim-treesitter (main branch, full rewrite):
--   * `require("nvim-treesitter.configs").setup{...}` no longer exists.
--   * Highlighting / folding / indentation are Neovim built-ins, enabled per
--     filetype via autocommands below.
--   * Parsers are installed with `require("nvim-treesitter").install{...}`.
local ts_ok, treesitter = pcall(require, "nvim-treesitter")
if not ts_ok then
	return
end

-- `tree-sitter build` prefers MSVC (cl.exe) on Windows; force gcc/clang so the
-- toolchain already in ${PATH} (e.g. WinLibs MinGW) is used instead.
if vim.fn.has("win32") == 1 and vim.env.CC == nil then
	vim.env.CC = "gcc"
end

treesitter.setup({})

-- Languages to install on first start (no-op when already installed)
local ensure_installed = {
	"c", "cpp", "lua", "vim", "vimdoc", "query",
	"python", "bash", "cmake",
	"markdown", "markdown_inline",
	"json", "yaml", "html",
}

local installed = treesitter.get_installed("parsers")
local missing = vim.iter(ensure_installed)
	:filter(function(lang)
		return not vim.list_contains(installed, lang)
	end)
	:totable()

if #missing > 0 then
	treesitter.install(missing)
end

-- Treesitter highlighting (built-in feature)
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
	callback = function(args)
		-- Start only when a parser is available for this filetype
		pcall(vim.treesitter.start, args.buf)
	end,
})

-- Treesitter indentation (experimental, provided by the plugin)
vim.api.nvim_create_autocmd("FileType", {
	group = "user-treesitter",
	callback = function(args)
		vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- nvim-treesitter-textobjects (main branch): flat setup + manual keymaps
local to_ok, textobjects = pcall(require, "nvim-treesitter-textobjects")
if to_ok then
	textobjects.setup({
		move = {
			set_jumps = true, -- whether to set jumps in the jumplist
		},
	})

	local move = require("nvim-treesitter-textobjects.move")
	local modes = { "n", "x", "o" }
	local function map(lhs, fn, query, desc)
		vim.keymap.set(modes, lhs, function()
			move[fn](query, "textobjects")
		end, { silent = true, desc = desc })
	end

	-- Next start
	map("]F", "goto_next_start", "@function.outer",    "Next function start")
	map("]C", "goto_next_start", "@class.outer",       "Next class/struct start")
	map("]P", "goto_next_start", "@parameter.outer",   "Next parameter start")
	map("]I", "goto_next_start", "@conditional.outer", "Next conditional start")
	map("]L", "goto_next_start", "@loop.outer",        "Next loop start")
	map("]R", "goto_next_start", "@return.outer",      "Next return start")
	-- Next end
	map("]f", "goto_next_end",   "@function.outer",    "Next function end")
	map("]c", "goto_next_end",   "@class.outer",       "Next class/struct end")
	map("]p", "goto_next_end",   "@parameter.inner",   "Next parameter end")
	map("]i", "goto_next_end",   "@conditional.outer", "Next conditional end")
	map("]l", "goto_next_end",   "@loop.outer",        "Next loop end")
	map("]r", "goto_next_end",   "@return.inner",      "Next return end")
	-- Previous start
	map("[F", "goto_previous_start", "@function.outer",    "Previous function start")
	map("[C", "goto_previous_start", "@class.outer",       "Previous class/struct start")
	map("[P", "goto_previous_start", "@parameter.outer",   "Previous parameter start")
	map("[I", "goto_previous_start", "@conditional.outer", "Previous conditional start")
	map("[L", "goto_previous_start", "@loop.outer",        "Previous loop start")
	map("[R", "goto_previous_start", "@return.outer",      "Previous return start")
	-- Previous end
	map("[f", "goto_previous_end",   "@function.outer",    "Previous function end")
	map("[c", "goto_previous_end",   "@class.outer",       "Previous class/struct end")
	map("[p", "goto_previous_end",   "@parameter.inner",   "Previous parameter end")
	map("[i", "goto_previous_end",   "@conditional.outer", "Previous conditional end")
	map("[l", "goto_previous_end",   "@loop.outer",        "Previous loop end")
	map("[r", "goto_previous_end",   "@return.inner",      "Previous return end")
end

-- Old `configs.setup` options intentionally dropped:
--   rainbow  -> plugin (nvim-ts-rainbow) not installed anymore
--   matchup / endwise -> plugins not installed
--   autopairs -> handled by ultimate-autopair.nvim
--   incremental_selection -> removed upstream; textobjects covers navigation
-- Parser compilers (first install only): the toolchain in ${PATH} is used
-- (gcc via WinLibs on Windows, clang/gcc elsewhere).
