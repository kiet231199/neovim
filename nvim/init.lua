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
local profiles = {
	nvim = { "~/neovim/config/nvim", {} },
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
