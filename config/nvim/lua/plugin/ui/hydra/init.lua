-- UI for Git
local hydra_git = require("plugin.ui.hydra.git")
require("hydra")(hydra_git)

-- UI for Snacks picker
local hydra_picker = require("plugin.ui.hydra.picker")
require("hydra")(hydra_picker)

-- UI for dap
local hydra_dap = require("plugin.ui.hydra.dap")
require("hydra")(hydra_dap)

function ShowHydra(head)
	if head == "git" then
		require("hydra")(hydra_git):activate()
	end
	if head == "picker" then
		require("hydra")(hydra_picker):activate()
	end
	if head == "dap" then
		require("hydra")(hydra_dap):activate()
	end
end

