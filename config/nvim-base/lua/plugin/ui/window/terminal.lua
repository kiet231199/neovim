local status_ok, terminal = pcall(require, "terminal")
if not status_ok then
	print("Error: terminal")
	return
end

require("terminal").setup({
	layout = {
		open_cmd = "botright vnew"
	}
})

-- Htop
local htop = require("terminal").terminal:new({
    layout = {
		open_cmd = "float",
		width = 0.7,
		height = 0.5,
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

vim.keymap.set({ "n", "t" }, "<space>tn", function()
	local index = require("terminal").current_term_index() or 0
	local terms = require("terminal.active_terminals"):get_sorted_terminals()
	for i = 1, #terms do
		terms[i]:close()
	end
	if #terms ~= 0 then
		if index == 0 then
			terms[1]:open(nil, true)
		else
			index = index % #terms + 1
		end
		require("terminal").open(index, nil, false)
	end
end, { desc = "next terminal", silent = true })

vim.keymap.set({ "n", "t" }, "<space>tp", function()
	local index = require("terminal").current_term_index() or 0
	local terms = require("terminal.active_terminals"):get_sorted_terminals()
	for i = 1, #terms do
		terms[i]:close()
	end
	if #terms ~= 0 then
		if index == 0 then
			terms[1]:open(nil, true)
		else
			index = (index + #terms - 1) % #terms + 1
		end
		require("terminal").open(index, nil, false)
	end
end, { desc = "prev terminal", silent = true })

vim.keymap.set({ "n", "t" }, "<space>tc", function()
	local index = require("terminal").current_term_index()
	require("terminal").close(index)
end, { silent = true })

vim.keymap.set({ "n", "t" }, "<space>tk", function()
	local index = require("terminal").current_term_index()
	require("terminal").kill(index)
end, { silent = true })

vim.keymap.set({ "n", "t" }, "<C-Right>", require("terminal.mappings").move({ open_cmd = "botright vnew" }), { silent = true })
vim.keymap.set({ "n", "t" }, "<C-Down>" , require("terminal.mappings").move({ open_cmd = "botright new" }) , { silent = true })
vim.keymap.set({ "n", "t" }, "<C-Space>", require("terminal.mappings").move({ open_cmd = "float", width = 0.8, height = 0.8, border = "rounded" }), { silent = true })
