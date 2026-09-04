--       ___           ___           ___           ___                                    ___
--      /  /\         /__/\         /  /\         /  /\          ___        ___          /__/\
--     /  /:/         \  \:\       /  /:/_       /  /::\        /__/\      /  /\        |  |::\
--    /  /:/           \__\:\     /  /:/ /\     /  /:/\:\       \  \:\    /  /:/        |  |:|:\
--   /  /:/  ___   ___ /  /::\   /  /:/ /:/_   /  /:/  \:\       \  \:\  /__/::\      __|__|:|\:\
--  /__/:/  /  /\ /__/\  /:/\:\ /__/:/ /:/ /\ /__/:/ \__\:\  ___  \__\:\ \__\/\:\__  /__/::::| \:\
--  \  \:\ /  /:/ \  \:\/:/__\/ \  \:\/:/ /:/ \  \:\ /  /:/ /__/\ |  |:|    \  \:\/\ \  \:\~~\__\/
--   \  \:\  /:/   \  \::/       \  \::/ /:/   \  \:\  /:/  \  \:\|  |:|     \__\::/  \  \:\
--    \  \:\/:/     \  \:\        \  \:\/:/     \  \:\/:/    \  \:\__|:|     /__/:/    \  \:\
--     \  \::/       \  \:\        \  \::/       \  \::/      \__\::::/      \__\/      \  \:\
--      \__\/         \__\/         \__\/         \__\/           ~~~~                   \__\/
--
-- A config switcher written in Lua by NTBBloodbath and Vhyrro.
-- Full information can be found on https://github.com/NTBBloodbath/cheovim

-- INFO: List all configuration here
-- The default location is "~/neovim". Set the NVIM_DOT_PATH environment
-- variable to point at any other deployment directory (the install scripts
-- patch this fallback, so you normally never need to touch it).
local nvim_dir = vim.env.NVIM_DOT_PATH or "~/neovim"
local profiles = {
	nvim = { nvim_dir .. "/config/nvim", {} },
}

-- Create all the plugins if necessary and start up the rest of cheovim!
require("loader").load_profile_to_rtp("nvim", profiles)
require("loader").load_config()

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	desc = "Invoke a post-load command specified by the user once the user configuration is loaded",
	pattern = "*",
	callback = function()
		local state = require("state").state

		-- Grab the configuration for our current profile
		local profile_config = state.profiles[state.current_profile.name][2]

		-- If we have defined a config variable then
		if profile_config.config then
			-- Depending on the type of the config variable execute the code in a different way
			-- NOTE: We defer for 100ms here to be absolutely sure the config has loaded
			vim.defer_fn(
				vim.schedule_wrap(function()
					if type(profile_config.config) == "string" then
						vim.cmd(profile_config.config)
					elseif type(profile_config.config) == "function" then
						profile_config.config()
					end
				end),
				50
			)
		end
	end,
})
