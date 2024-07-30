vim.keymap.set('x', '<space>ac', function()
    require'align'.align_to_char({
        length = 1,
    })
end, { desc = "Align to 1 char" }) -- Aligns to 1 character, looking left

vim.keymap.set('x', '<space>aC', function()
    require'align'.align_to_char({
        preview = true,
        length = 2,
    })
end, { desc = "Align to 2 char" }) -- Aligns to 2 characters, looking left and with previews

vim.keymap.set('x', '<space>as', function()
    require'align'.align_to_string({
        preview = true,
        regex = false,
    })
end, { desc = "Align to string" }) -- Aligns to a string, looking left and with previews

vim.keymap.set('x', '<space>aS', function()
    require'align'.align_to_string({
        preview = true,
        regex = true,
    })
end, { desc = "Align to string + regex" }) -- Aligns to a string with regex, looking left and with previews

vim.keymap.set('n', '<space>ap', function()
    require'align'.align_to_operator(
        require'align'.align_to_string,
        {
            regex = false,
            preview = true,
        }
    )
end, { desc = "Align to string + regex" }) -- Aligns to a paragraph, looking left and with previews
