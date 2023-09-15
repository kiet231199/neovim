local dap = require('dap')

-- c/cpp
dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = vim.g.neovim_path .. "/config/dap/extension/debugAdapters/bin/OpenDebugAD7",
}
dap.configurations.c = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
    },
    {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234', -- INFO: Remote board IP
        miDebuggerPath = vim.fn.exepath('gdb'),     -- INFO: Path to bin/aarch64-poky-linux-gdb in toolchain
        cwd = '${workspaceFolder}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
    },
}

dap.configurations.cpp = dap.configurations.c
