-- Define neovim base path
local global_config = {}
if vim.fn.has("win32") == 1 then
	-- Window
else
	-- Linux
	vim.g.neovim_path = "/data4/kietpham/00_dot"

	global_config = {
		-- Disable netrw at the very start of your init.lua (strongly advised)
		loaded_netrw = 1,
		loaded_netrwPlugin = 1,

		-- Define path
		config_path = vim.g.neovim_path .. "/config",
		data_path = vim.g.neovim_path .. "/data",

		-- Define path for python3 and nodejs framework
		python3_host_prog = vim.g.neovim_path .. "/tools/python-3.10.7/bin/python3",
		node_host_prog = vim.g.neovim_path .. "/tools/node-v16.17.1/lib/node_modules/neovim/bin/cli.js",
	}
end

-- Load all global_config
for option, config in pairs(global_config) do
	vim.g[option] = config
end

-- Set nvim as default git editor
vim.cmd[[
	if has('nvim') && executable('nvr')
		let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
	endif
]]

-- Setup plugins manager
local lazypath = vim.g.config_path .. "/lazy/lazy.nvim"
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
