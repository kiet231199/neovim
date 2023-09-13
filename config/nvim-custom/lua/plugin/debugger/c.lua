local dap = require("dap")

-- c/cpp
dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    -- command = '/home/felix/.config/nvim/dap/gdb/extension/debugAdapters/bin/OpenDebugAD7',
    -- command = vim.fn.exepath('OpenDebugAD7'),
    command = "D:\\Software\\ms-vscode.cpptools-1.17.5-win32-x64\\debugAdapters\\bin\\OpenDebugAD7.exe",
    options = {
        detached = false
    },
}
dap.configurations.c = {
    {
        name = "Launch file cppdbg",
        type = "cppdbg",
        request = "launch",
        -- program = function()
        --     return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\', 'file')
        -- end,
        program = "D:\\CodeTest\\TestC\\src\\main",
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
        MIMode = "gdb",
        miDebuggerPath = "C:\\MinGW\\bin\\gdb.exe",
        -- setupCommands = {
        --     {
        --         description = 'enable pretty printing',
        --         text = '-enable-pretty-printing',
        --         ignoreFailures = true
        --     },
        -- }
    },
}
