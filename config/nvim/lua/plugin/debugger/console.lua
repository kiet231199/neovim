local status_ok, console = pcall(require, "lua-console")
if not status_ok then
	print("Error: lua-console")
	return
end

console.setup({
    buffer = {
        result_prefix = '=> ',
        save_path = vim.fn.stdpath('data') .. '/lua-console.lua',
        autosave = false,         -- autosave on console hide / close
        load_on_start = true,    -- load saved session on start
        preserve_context = false, -- preserve results between evaluations
    },
    window = {
        border = 'rounded', -- single|double|rounded
        height = 0.4,       -- percentage of main window
    },
    mappings = {
        toggle = '`',
        attach = false,
        quit = 'q',
        eval = '<CR>',
        eval_buffer = '<S-CR>',
        open = 'gf',
        messages = 'M',
        save = 'S',
        load = 'L',
        resize_up = '<C-Up>',
        resize_down = '<C-Down>',
        help = '?'
    },
})

-- Create a user command to be invoked by other plugin
-- local console_config = require("lua-console.config")
-- vim.api.nvim_create_user_command(
--     'ToggleLuaConsole',
--     callback = function()
--         console_config.toggle_console
--     end,
--     { desc = "Toggle Lua Console" }
-- )
