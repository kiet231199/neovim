local status_ok, ripsubstitute = pcall(require, "rip-substitute")
if not status_ok then
	print("Error: rip-substitute")
	return
end

ripsubstitute.setup({
	popupWin = {
		title = "  Replace ",
		border = "rounded",
		matchCountHlGroup = "Keyword",
		noMatchHlGroup = "ErrorMsg",
		hideSearchReplaceLabels = false,
		position = "bottom", -- "top"|"bottom"
	},
	prefill = {
		normal = "cursorWord", -- "cursorWord"|false
		visual = "selectionFirstLine", -- "selectionFirstLine"|false
		startInReplaceLineIfPrefill = false,
	},
	keymaps = {
		-- normal & visual mode
		confirm = "<CR>",
		abort = "<ESC>",
		prevSubst = "<Up>",
		nextSubst = "<Down>",
		openAtRegex101 = "R",
		insertModeConfirm = "<C-CR>", -- (except this one, obviously)
	},
	incrementalPreview = {
		matchHlGroup = "IncSearch",
		rangeBackdrop = {
			enabled = true,
			blend = 50, -- between 0 and 100
		},
	},
	regexOptions = {
		-- pcre2 enables lookarounds and backreferences, but performs slower
		pcre2 = true,
		---@type "case-sensitive"|"ignore-case"|"smart-case"
		casing = "case-sensitive",
		-- disable if you use named capture groups (see README for details)
		autoBraceSimpleCaptureGroups = false,
	},
	editingBehavior = {
		-- Experimental. When typing `()` in the `search` line, automatically
		-- adds `$n` to the `replace` line.
		autoCaptureGroups = false,
	},
	notificationOnSuccess = true,
})
