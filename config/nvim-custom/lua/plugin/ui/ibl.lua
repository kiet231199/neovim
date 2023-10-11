local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
	print("Error: ibl")
	return
end

ibl.setup({
    enabled = true,
    indent = {
        char = "▏",
        highlight = "IblIndent",
        smart_indent_cap = true,
    },
    whitespace = {
        highlight = "IblWhitespace",
        remove_blankline_trail = true,
    },
    scope = {
        enabled = true,
        char = "▏",
        show_start = true,
        show_end = true,
        injected_languages = true,
        highlight = "IblScope",
        include = {
            node_type = {
                c = { "case_statement" },
				lua = {
					"function_call",
					"table_constructor",
					"field",
				},
            }
        },
        exclude = {
            language = {},
        },
    },
    exclude = {
        filetypes = {
            "lspinfo",
            "packer",
            "checkhealth",
            "help",
            "man",
            "gitcommit",
            "TelescopePrompt",
            "TelescopeResults",
        },
        buftypes = {
            "terminal",
            "nofile",
            "quickfix",
            "prompt",
        },
    },
})

