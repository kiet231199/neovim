local dap = require('dap')

-- c/cpp
dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = vim.g.neovim_path .. "/config/dap/extension/debugAdapters/bin/OpenDebugAD7",
}
dap.configurations.c = {
    {
        name = "Local debug",
        type = "cppdbg",
        request = "launch",
        MIMode = "gdb",
        miDebuggerPath = "/usr/bin/gdb",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        setupCommands = {
            {
                text = '-enable-pretty-printing',
                description = 'enable pretty printing',
                ignoreFailures = false
            },
        },
    },
    {
        name = 'Remote debug',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = '192.168.5.125:80', -- INFO: Remote board IP
        miDebuggerPath = vim.fn.exepath('/data2/sdk/01_G2L/sysroots/x86_64-pokysdk-linux/usr/bin/aarch64-poky-linux/aarch64-poky-linux-gdb'),         -- INFO: Path to bin/aarch64-poky-linux-gdb in toolchain
        cwd = '${workspaceFolder}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        setupCommands = {
            {
                description = 'Setup sysroot',
                text = 'set sysroot /data1/tftpboot/kietpham/g2l/',
                ignoreFailures = false
            },
            {
                description = 'enable pretty printing',
                text = '-enable-pretty-printing',
                ignoreFailures = false
            },
        },
    },
}

dap.configurations.cpp = dap.configurations.c
