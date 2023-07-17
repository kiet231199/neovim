local status_ok, hardtime = pcall(require, "hardtime")
if not status_ok then
	print("Error: hardtime")
	return
end

hardtime.setup({
	max_time = 100,
	max_count = 15,
	disable_mouse = false,
	hint = true,
	notifications = true,
	allow_different_key = true,
	resetting_keys = {
		["1"] = { "n", "v" },
		["2"] = { "n", "v" },
		["3"] = { "n", "v" },
		["4"] = { "n", "v" },
		["5"] = { "n", "v" },
		["6"] = { "n", "v" },
		["7"] = { "n", "v" },
		["8"] = { "n", "v" },
		["9"] = { "n", "v" },
		["c"] = { "n" },
		["C"] = { "n" },
		["d"] = { "n" },
		["x"] = { "n" },
		["X"] = { "n" },
		["y"] = { "n" },
		["Y"] = { "n" },
		["p"] = { "n" },
		["P"] = { "n" },
	},
	restricted_keys = {
		["h"] = { "n", "v" },
		["j"] = { "n", "v" },
		["k"] = { "n", "v" },
		["l"] = { "n", "v" },
	},
	disabled_keys = {},
	disabled_filetypes = { "qf", "netrw", "neo-tree", "lazy", "mason" },
})
