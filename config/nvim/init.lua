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

-- Define path for python3 and nodejs framework
vim.g.python3_host_prog = vim.g.dot_path .. "/tools/python-3.10.7/bin/python3"
vim.g.node_host_prog    = vim.g.dot_path .. "/tools/node-v16.17.1/lib/node_modules/neovim/bin/cli.js"

-- Set nvim as default git editor
vim.cmd[[
	if has('nvim') && executable('nvr')
		let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
	endif
]]

local lazypath = vim.g.dot_path .. "/config/lazy/lazy.nvim"
-- Setup plugins manager
-- WARN: Only uncomment below part on the first run of neovim to install lazy.nvim
-- if not vim.loop.fs_stat(lazypath) then
-- 	vim.fn.system({
-- 	"git",
-- 	"clone",
-- 	"--filter=blob:none",
-- 	"https://github.com/folke/lazy.nvim.git",
-- 	"--branch=stable", -- latest stable release
-- 	lazypath,
-- 	})
-- end
vim.opt.rtp:prepend(lazypath)

-- Call default settings
require("init")
