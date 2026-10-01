--  Default configuration path of Neovim
-- ┌──────────────────────────┐
-- │   ${HOME}/.config/nvim/  │
-- └───┬──────────────────────┘
--     │    Store ultility functions to load config out of `stdpath("config")`
--     │   ┌───────┐
--     ├──>│  lua  │
--     │   └───────┘
--     │    Define path to your configuration here
--     │   ┌────────────┐
--     └──>│  init.lua  │ >>>-----------------------┐
--         └────────────┘                           |
--                                                  |
--  Anywhere you like. Ex: /data1/kietpham/00_dot   |
-- ┌───────────┐                                    |
-- │  ${DOT}/  │                                    |
-- └───┬───────┘                                    |
--     │   ┌──────────┐                             |
--     ├──>│  config  │                             |
--     │   └───┬──────┘                             |
--     │       │   ┌────────┐      Point to here    |
--     │       ├──>│  nvim  │ <<<-------------------┘
--     │       │   └───┬────┘
--     │       │       │   ┌────────────┐  ─┐
--     │       │       ├──>│  init.lua  │   │
--     │       │       │   └────────────┘    ╲  Your real configuration for
--     │       │       │   ┌───────┐         ╱  Neovim is stored here
--     │       │       └──>│  lua  │        │
--     │       │           └───────┘       ─┘
--     │       │   ┌────────┐
--     │       ├──>│  lazy  │
--     │       │   └────────┘
--     │       │    Storing Debug Adapter
--     │       │   ┌───────┐
--     │       ├──>│  dap  │
--     │       │   └───────┘
--     │       │    Storing LSP
--     │       │   ┌─────────┐
--     │       └──>│  mason  │
--     │           └─────────┘
--     │    Storing neccessary tools for neovim, these must be exported to ${PATH}
--     │   ┌─────────┐
--     └──>│  tools  │
--         └─────────┘

-- Get dot files path
vim.g.dot_path = vim.fn.fnamemodify(require("state").state.current_profile.path, ":h:h")

-- Resolve provider runtimes: prefer the bundled toolchain, otherwise fall back
-- to the system python3/node so the config also works on Windows.
local function find_host_prog(candidates)
	for _, candidate in ipairs(candidates) do
		if vim.fn.filereadable(candidate) == 1 then
			return candidate
		end
	end
	return nil
end

-- The bundled tools/ tree only ships Linux builds; on Windows leave the host
-- programs unset so neovim auto-detects python3/node from PATH.
if vim.fn.has("win32") == 1 then
	vim.g.python3_host_prog = nil
	vim.g.node_host_prog = nil
else
	vim.g.python3_host_prog = find_host_prog({
		-- vim.g.dot_path .. "/tools/python-3.10.7/bin/python3",
		vim.fn.exepath("python3"),
	})
	vim.g.node_host_prog = find_host_prog({
		vim.g.dot_path .. "/tools/node-v16.17.1/lib/node_modules/neovim/bin/cli.js",
	})
end

-- Set nvim as default git editor
vim.cmd[[
	if has('nvim') && executable('nvr')
		let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
	endif
]]

-- Setup plugins manager. Linux installs ship lazy.nvim inside the extracted
-- config/lazy pack; Windows installs do not extract the Linux-only packs, so
-- fall back to cloning lazy.nvim from GitHub into the data dir on first start.
local function setup_lazy()
	local packpath = vim.fs.joinpath(vim.g.dot_path, "config", "lazy", "lazy.nvim")
	if vim.fn.isdirectory(packpath) == 1 then
		return packpath
	end
	local bootstrap = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "lazy.nvim")
	if vim.fn.isdirectory(bootstrap) ~= 1 and vim.fn.executable("git") == 1 then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			bootstrap,
		})
	end
	return bootstrap
end
local lazypath = setup_lazy()
vim.opt.rtp:prepend(lazypath)

-- Call default settings
require("init")
