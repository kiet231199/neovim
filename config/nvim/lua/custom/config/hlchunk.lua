local status_ok, hlchunk = pcall(require, "hlchunk")
if not status_ok then
	print("Error: hlchunk")
	return
end

hlchunk.setup({
	chunk = {
        enable = true,
        support_filetypes = {
            "*.json",
            "*.c",
            "*.cpp",
            "*.vim",
            "*.h",
            "*.hpp",
            "*.lua",
            "*.py",
            "*.sh",
        },
        chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
        },
        style = "Yellow",
        exclude_filetype = {
			telescope_prompt = true,
		},
    },

    indent = {
        enable = true,
        use_treesitter = false,
        -- You can uncomment to get more indented line look like
        chars = {
            "│",
        },
        -- you can uncomment to get more indented line style
        style = {
			"#697094",
            -- vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("LineNr")), "fg", "gui"),
        },
        exclude_filetype = {
            alpha = true,
            help = true,
            lspinfo = true,
            packer = true,
            checkhealth = true,
            man = true,
            mason = true,
            NvimTree = true,
            plugin = true,
        },
    },

    line_num = {
        enable = false,
        support_filetypes = {
            "*.json",
            "*.c",
            "*.cpp",
            "*.vim",
            "*.h",
            "*.hpp",
            "*.lua",
            "*.py",
            "*.sh",
            "*.md",
        },
        style = "#7aa2f7",
    },

    blank = {
		enable = false,
        chars = {
            " ",
        },
        style = {
            vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
        },
        exclude_filetype = "...",
    },
})
