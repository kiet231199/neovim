local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
	print("Error: ibl")
	return
end

ibl.setup({
    enabled = true,
    debounce = 100,
    indent = {
        char = "│",
        smart_indent_cap = true,
    },
    whitespace = {
        remove_blankline_trail = false,
    },
    scope = {
        enabled = true,
        show_start = true,
        show_end = true,
    },
    exclude = {
        filetypes = {
            "text",
            "markdown",
            "lspinfo",
            "packer",
            "checkhealth",
            "help",
            "man",
            "gitcommit",
            "TelescopePrompt",
            "TelescopeResults"
        },
        buftypes = {
            "terminal",
            "nofile",
            "quickfix",
            "prompt",
        },
    },
})

