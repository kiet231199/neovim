local status_ok, terminal = pcall(require, "terminal")
if not status_ok then
	print("Error: terminal")
	return
end

require("terminal").setup({
	layout = {
		border = "rounded",
	},
	autoclose = true,
})

local htop = require("terminal").terminal:new({
    layout = {
		open_cmd = "float",
		width = 120,
		height = 35,
		border = "rounded",
	},
    cmd = { "htop" },
})
vim.api.nvim_create_user_command("Htop", function()
    htop:toggle(nil, true)
end, { nargs = "?" })

local lazygit = require("terminal").terminal:new({
	layout = {
		open_cmd = "float",
		height = 0.9,
		width = 0.9,
		border = "rounded",
	},
    cmd = { "lazygit" },
})
vim.env["GIT_EDITOR"] = "nvr -cc close -cc split --remote-wait +'set bufhidden=wipe'"
vim.api.nvim_create_user_command("Lazygit", function(args)
    lazygit.cwd = args.args and vim.fn.expand(args.args)
    lazygit:toggle(nil, true)
end, { nargs = "?" })

