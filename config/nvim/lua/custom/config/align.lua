-- align_to_char(length, reverse, preview, marks)
-- align_to_string(is_pattern, reverse, preview, marks)
-- align(str, reverse, marks)
-- operator(fn, opts)
-- Where:
--      length: integer
--      reverse: boolean
--      preview: boolean
--      marks: table (e.g. {1, 0, 23, 15})
--      str: string (can be plaintext or Lua pattern if is_pattern is true)

local NS = { noremap = true, silent = true }

vim.keymap.set('x', '<space>ac', function() require'align'.align_to_char(1, true)             end, { desc = "Align to 1 char" }) -- Aligns to 1 character, looking left
vim.keymap.set('x', '<space>aw', function() require'align'.align_to_char(2, true, true)       end, { desc = "Align to 2 char" }) -- Aligns to 2 characters, looking left and with previews
vim.keymap.set('x', '<space>as', function() require'align'.align_to_string(false, true, true) end, { desc = "Align to string" }) -- Aligns to a string, looking left and with previews
vim.keymap.set('x', '<space>ap', function() require'align'.align_to_string(true, true, true)  end, { desc = "Align to pattern" }) -- Aligns to a Lua pattern, looking left and with previews
