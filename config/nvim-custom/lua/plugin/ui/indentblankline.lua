local status_ok, indentblankline = pcall(require, "indent_blankline")
if not status_ok then
	print("Error: indent_blankline")
	return
end

indentblankline.setup({
    char = "▏",
	space_char_blankline = " ",
    context_char = "▏",
    show_current_context = true,
    show_current_context_start = true,
	char_highlight_list = {
        "IndentBlanklineIndent",
    },
})

