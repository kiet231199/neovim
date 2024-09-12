-- UI for Git
local hydra_git = require("plugin.ui.hydra.git")
require("hydra")(hydra_git)

-- UI for Telescope
local hydra_telescope = require("plugin.ui.hydra.telescope")
require("hydra")(hydra_telescope)

-- UI for dap
-- local hydra_dap = require("plugin.ui.hydra.dap")
-- require("hydra")(hydra_dap)

function ShowHydra(head)
	if head == "git" then
		require("hydra")(hydra_git):activate()
	end
	if head == "telescope" then
		require("hydra")(hydra_telescope):activate()
	end
	-- if head == "dap" then
	-- 	require("hydra")(hydra_dap):activate()
	-- end
end

