local status_ok, scissors = pcall(require, "scissors")
if not status_ok then
	print("Error: scissors")
	return
end

-- default settings
require("scissors").setup {
	snippetDir = vim.g.my_path .. "/snippets",
	editSnippetPopup = {
		height = 0.4, -- relative to the window, number between 0 and 1
		width = 0.6,
		border = "rounded",
		keymaps = {
			cancel = "q",
			saveChanges = "<CR>", -- alternatively, can also use `:w`
			goBackToSearch = "<BS>",
			deleteSnippet = "<C-BS>",
			duplicateSnippet = "<C-d>",
			openInFile = "<C-o>",
		},
	},
	telescope = {
		-- By default, the query only searches snippet prefixes. Set this to
		-- `true` to also search the body of the snippets.
		alsoSearchSnippetBody = false,
	},
	-- `none` writes as a minified json file using `vim.encode.json`.
	-- `yq`/`jq` ensure formatted & sorted json files, which is relevant when
	-- you version control your snippets.
	jsonFormatter = "none", -- "yq"|"jq"|"none"
}
