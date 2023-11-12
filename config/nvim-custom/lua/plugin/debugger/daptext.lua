local status_ok, virtualtext = pcall(require, "nvim-dap-virtual-text")
if not status_ok then
	print("Error: nvim-dap-virtual-text")
	return
end

virtualtext.setup({
    enabled = true,                        -- enable this plugin (the default)
    enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = true,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = false,              -- show stop reason when stopped for exceptions
    commented = false,                     -- prefix virtual text with comment string
    only_first_definition = false,         -- only show virtual text at first definition (if there are multiple)
    all_references = true,                 -- show virtual text on all all references of the variable (not only definitions)
    clear_on_continue = false,             -- clear virtual text on "continue" (might cause flickering when stepping)
    display_callback = function(variable, buf, stackframe, node, options)
      if options.virt_text_pos == 'inline' then
        return ' 󰶢 ' .. variable.value
      else
        return variable.name .. ' 󰶢 ' .. variable.value
      end
    end,
    virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
    -- experimental features:
    all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
})
