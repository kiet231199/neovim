local status_ok, terminal = pcall(require, "terminal")
if not status_ok then
	print("Error: terminal")
	return
end

require("terminal").setup()

local htop = require("terminal").terminal:new({
    layout = {
		open_cmd = "float",
		width = 80,
		height = 30,
		border = "rounded",
	},
    cmd = { "htop" },
    autoclose = true,
})
vim.api.nvim_create_user_command("Htop", function()
    htop:toggle(nil, true)
end, { nargs = "?" })
