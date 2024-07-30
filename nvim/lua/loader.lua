-- Loader for neovim configurations
local loader = {}

-- Initialize the loader and the state
local state = require("state")

function loader.get_profiles(path)
	-- No pcall or error checking here because we need to be as speedy as possible
	local selected_profile, profiles = dofile(path)

	return selected_profile, profiles
end

function loader.load_profile_to_rtp(selected_profile, profiles)
	-- Set the public variable for use by other files
	state.set({
		profiles = profiles,
		current_profile = {
			name = selected_profile,
			path = vim.fn.fnamemodify(profiles[selected_profile][1], ":p:h"),
			init = vim.fn.fnamemodify(profiles[selected_profile][1] .. "/init.lua", ":p"),
		},
	})

	-- Set the local variable for private using
	local _state = state.state
	-- Save a local copy of current runtimepath
	local rtp = vim.opt.runtimepath:get()
	-- Append current profile path as the second rtp path and shift all other path on it
	table.insert(rtp, 2, _state.current_profile.path)
	-- Save new runtimepath
	vim.opt.runtimepath = rtp
	-- Add user configuration to the current path
	package.path = package.path .. ";" .. vim.fn.expand(_state.current_profile.path) .. "/lua/?.lua"
end

function loader.load_config()
	local profiles = state.state.profiles
	local selected_profile = state.state.current_profile.name
	local selected = profiles[selected_profile]

	-- If we haven't selected a valid profile or that profile doesn't come with a path then error out
	if not selected then
		vim.notify("[ERROR] Unable to find profile with name" .. selected_profile, vim.log.levels.ERROR)
		return
	elseif not selected[1] then
		vim.notify(
			"[ERROR] Unable to load profile with name"
				.. selected_profile
				.. "- the first element of the profile must be a path.",
			vim.log.levels.ERROR
		)
		return
	end

	-- Clone the current stdpath function definition into an unused func
	vim.fn._stdpath = vim.fn.stdpath

	-- Override vim.fn.stdpath to manipulate the data returned by it. Yes, I know, changing core functions
	-- is really bad practice in any codebase, however this is our only way to make things like LunarVim etc. work
	vim.fn.stdpath = function(what)
		if what:lower() == "config" then
			return selected[1]
		end
		return vim.fn._stdpath(what)
	end

	-- WARN: we do not expand it if configuration path is an URL
	selected[1] = vim.fn.expand(selected[1])

	-- Load the config and restore the plugin/ directory
	dofile(selected[1] .. "/init.lua")
end

return loader
