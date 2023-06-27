local status_ok, hardtime = pcall(require, "hardtime")
if not status_ok then
	print("Error: hardtime")
	return
end

hardtime.setup({
	max_time = 300,
	max_count = 5,
	disable_mouse = false,
	hint = true,
	notifications = true,
	allow_different_key = false,
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
		["-"] = { "n", "v" },
		["+"] = { "n", "v" },
		["gj"] = { "n", "v" },
		["gk"] = { "n", "v" },
		["<CR>"] = { "n", "v" },
		["<C-M>"] = { "n", "v" },
		["<C-N>"] = { "n", "v" },
		["<C-P>"] = { "n", "v" },
	},
	disabled_keys = {
		-- ["<UP>"] = { "", "i" },
		-- ["<DOWN>"] = { "", "i" },
		-- ["<LEFT>"] = { "", "i" },
		-- ["<RIGHT>"] = { "", "i" }
	},
	disabled_filetypes = { "qf", "netrw", "neo-tree", "lazy", "mason" },
})
