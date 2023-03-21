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
            "*.md",
            "*.txt",
        },
        chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
        },
        style = "Yellow",
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
            vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
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
            "*.md",
            "*.txt",
        },
        style = "#00ffff",
    },

    blank = {
        enable = true,
        chars = {
            " ",
        },
        style = {
            vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Whitespace")), "fg", "gui"),
        },
        exclude_filetype = "...",
    },
})
