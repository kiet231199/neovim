local status_ok, rr = pcall(require, "nvim-dap-rr")
if not status_ok then
	print("Error: nvim-dap-rr")
	return
end

local status_ok, dap = pcall(require, "dap")
if not status_ok then
	print("Error: dap")
	return
end

rr.setup({
    mappings = {
        reverse_continue = "<F19>",         -- <S-F7>
        reverse_step_over = "<F20>",        -- <S-F8>
        reverse_step_out = "<F21>",         -- <S-F9>
        reverse_step_into = "<F22>",        -- <S-F10>
        -- instruction level stepping
        step_over_i = "<F32>",              -- <C-F8>
        step_out_i = "<F33>",               -- <C-F8>
        step_into_i = "<F34>",              -- <C-F8>
        reverse_step_over_i = "<F44>",      -- <SC-F8>
        reverse_step_out_i = "<F45>",       -- <SC-F9>
        reverse_step_into_i = "<F46>",      -- <SC-F10>
    },
})

dap.configurations.c = { rr.get_config() }
dap.configurations.cpp = { rr.get_config() }
