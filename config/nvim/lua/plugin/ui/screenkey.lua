local status_ok, screenkey = pcall(require, "screenkey")
if not status_ok then
	print("Error: screenkey")
	return
end

screenkey.setup({
    win_opts = {
        relative = "editor",
        anchor = "SE",
		width = 40,
        height = 1,
        border = "rounded",
		title = " Screenkey ",
		title_pos = "center",
        row = vim.o.lines - vim.o.cmdheight - 1,
        col = vim.o.columns - 2,
    },
    compress_after = 3,
    clear_after = 3,
    disable = {
        filetypes = {},
        buftypes = {},
    },
    display_infront = {},
    display_behind = {},
	show_leader = true,
    group_mappings = true,
    keys = {
        ["<TAB>"] = "󰌒",
        ["<CR>"] = "󰌑",
        ["<ESC>"] = "Esc",
        ["<SPACE>"] = "␣",
        ["<BS>"] = "󰌥",
        ["<DEL>"] = "Del",
        ["<LEFT>"] = "",
        ["<RIGHT>"] = "",
        ["<UP>"] = "",
        ["<DOWN>"] = "",
        ["<HOME>"] = "Home",
        ["<END>"] = "End",
        ["<PAGEUP>"] = "PgUp",
        ["<PAGEDOWN>"] = "PgDn",
        ["<INSERT>"] = "Ins",
        ["<F1>"] = "󱊫",
        ["<F2>"] = "󱊬",
        ["<F3>"] = "󱊭",
        ["<F4>"] = "󱊮",
        ["<F5>"] = "󱊯",
        ["<F6>"] = "󱊰",
        ["<F7>"] = "󱊱",
        ["<F8>"] = "󱊲",
        ["<F9>"] = "󱊳",
        ["<F10>"] = "󱊴",
        ["<F11>"] = "󱊵",
        ["<F12>"] = "󱊶",
        ["CTRL"] = "Ctrl",
        ["ALT"] = "Alt",
        ["SUPER"] = "󰘳",
    },
})

-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	group = vim.api.nvim_create_augroup("AutostartScreenkey", {}),
-- 	command = "Screenkey toggle",
-- 	desc = "Autostart Screenkey on VimEnter",
-- })
