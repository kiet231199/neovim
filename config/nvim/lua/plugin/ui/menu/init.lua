local normal = require("plugin.ui.menu.normal")
local visual = require("plugin.ui.menu.visual")

-- nvim real user
vim.keymap.set("n", "<Space>", function()
	require("menu").open(normal, { border = "rounded" })
end, {})

vim.keymap.set("x", "<Space>", function()
	require("menu").open(visual, { border = "rounded" })
end, {})

-- nvim fake -user
vim.keymap.set("n", "<RightMouse>", function()
	require("menu").open(normal, { border = "rounded" })
end, {})

vim.keymap.set("x", "<RightMouse>", function()
	require("menu").open(visual, { border = "rounded" })
end, {})
