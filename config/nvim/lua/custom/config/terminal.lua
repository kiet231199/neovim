local status_ok, terminal = pcall(require, "terminal")
if not status_ok then
	print("Error: terminal")
	return
end

require("terminal").setup()

-- Htop
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
	if htop:is_attached() == true then
		htop:close()
	else
		htop:open(nil, true)
	end
end, { nargs = "?" })

-- Lazygit
local lazygit = require("terminal").terminal:new({
    layout = {
		open_cmd = "float",
		height = 0.9,
		width = 0.9,
		border = "rounded",
	},
    cmd = { "lazygit" },
    autoclose = true,
})
vim.env["GIT_EDITOR"] = "nvr -cc close -cc split --remote-wait +'set bufhidden=wipe'"
vim.api.nvim_create_user_command("Lazygit", function(args)
    lazygit.cwd = args.args and vim.fn.expand(args.args)
	if lazygit:is_attached() == true then
		lazygit:close()
	else
		lazygit:open(nil, true)
	end
end, { nargs = "?" })

vim.keymap.set("n", "<leader>tn", function()
	local index = require("terminal").current_term_index()
	local total = require("terminal.active_terminals"):len()
	index = index % total + 1
	require("terminal").open(index, nil, false)
end, { silent = true })

vim.keymap.set("n", "<leader>tc", function()
	local index = require("terminal").current_term_index()
	require("terminal").close(index)
end, { silent = true })

vim.keymap.set("n", "<C-Right>", require("terminal.mappings").move({ open_cmd = "botright vnew" }), { silent = true })
vim.keymap.set("n", "<C-Down>", require("terminal.mappings").move({ open_cmd = "botright new" }), { silent = true })
vim.keymap.set("n", "<C-Space>", require("terminal.mappings").move({ open_cmd = "float", width = 80, height = 30, border = "rounded" }), { silent = true })

