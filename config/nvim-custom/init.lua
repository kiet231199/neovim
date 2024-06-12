-- Define neovim base path
-- Linux
vim.g.neovim_path = "/home/kietpham/neovim" -- WARN: Do not change this path
vim.g.my_path = "/home/kietpham/neovim"     -- INFO: Define parent path of your "config" folder here

global_config = {
	-- Define path
	config_path = vim.g.my_path .. "/config", -- Change config to .config if your path point to home
	data_path = vim.g.my_path .. "/data",

	-- Define path for python3 and nodejs framework
	python3_host_prog = vim.g.neovim_path .. "/tools/python-3.10.7/bin/python3",
	node_host_prog    = vim.g.neovim_path .. "/tools/node-v16.17.1/lib/node_modules/neovim/bin/cli.js",
}

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

local lazypath = vim.g.neovim_path .. "/config/lazy/lazy.nvim"
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
