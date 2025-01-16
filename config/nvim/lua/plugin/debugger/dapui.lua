local dapui_status_ok, dapui = pcall(require, "dapui")
if not dapui_status_ok then
	print("Error: dapui")
	return
end

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	print("Error: dap")
	return
end

dapui.setup({
    controls = {
        element = "repl",
        enabled = true,
        icons = {
            disconnect = " ",
            pause = " ",
            play = " ",
            run_last = " ",
            step_back = " ",
            step_into = " ",
            step_out = " ",
            step_over = " ",
            terminate = " "
        }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
        border = "rounded",
        mappings = {
            close = { "q", "<Esc>" }
        }
    },
    force_buffers = true,
    icons = {
        collapsed = "",
        current_frame = "",
        expanded = ""
    },
	layouts = { {
		elements = { {
			id = "scopes",
			size = 0.5
		}, {
			id = "repl",
			size = 0.5
		}, },
		position = "left",
		size = 50
	}, {
		elements = { {
			id = "stacks",
			size = 0.6
		}, {
			id = "breakpoints",
			size = 0.3
		}, {
			id = "watches",
			size = 0.3
		} },
		position = "bottom",
		size = 13
	} },
    mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
    },
    render = {
        indent = 1,
        max_value_lines = 100
    }
})

dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
dap.listeners.before.disconnect["dapui_config"] = function() dapui.close() end
