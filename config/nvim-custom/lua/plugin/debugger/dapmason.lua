local status_ok, masondap = pcall(require, "mason-nvim-dap")
if not status_ok then
    return
end

masondap.setup({
    ensure_installed = {
        "codelldb",
        "cppdbg",
    },
    automatic_installation = false,
    handlers = {
        -- function(config)
        --     -- all sources with no handler get passed here
        --
        --     -- Keep original functionality
        --     require('mason-nvim-dap').default_setup(config)
        -- end,
        --
        -- cppdbg = function(config)
        --     config.adapters = {
        --         id = 'cppdbg',
        --         type = 'executable',
        --         -- command = vim.fn.exepath('OpenDebugAD7'),
        --         command = 'C:\\Users\\hungquangnguyen\\.vscode\\extensions\\ms-vscode.cpptools-1.17.5-win32-x64\\debugAdapters\\bin\\OpenDebugAD7.exe',
        --         options = {
        --             detached = false,
        --         },
        --     }
        --     config.configurations = {
        --         {
        --             name = 'C++ Launch GDB',
        --             type = 'cppdbg',
        --             request = 'launch',
        --             -- program = function()
        --             --     return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\', 'file')
        --             -- end,
        --             program = "D:\\CodeTest\\TestC\\src\\main.exe",
        --             cwd = '${workspaceFolder}',
        --             stopAtEntry = false,
        --             windows = {
        --                 MIMode = 'gdb',
        --                 miDebuggerPath = 'C:\\Renesas\\rcar-xos\\v3.8.0\\tools\\toolchains\\mingw64\\bin\\gdb.exe',
        --             }
        --         },
        --
        --         {
        --             name = "Launch file",
        --             type = "cppdbg",
        --             request = "launch",
        --             program = function()
        --                 return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        --             end,
        --             cwd = '${workspaceFolder}',
        --             stopAtEntry = true,
        --         },
        --
        --         {
        --             name = 'Attach to gdbserver :1234',
        --             type = 'cppdbg',
        --             request = 'launch',
        --             MIMode = 'gdb',
        --             miDebuggerPath = 'C:\\Renesas\\rcar-xos\\v3.8.0\\tools\\toolchains\\mingw64\\bin\\gdb.exe',
        --             cwd = '${workspaceFolder}',
        --             program = function()
        --                 return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\', 'file')
        --             end,
        --         },
        --     }
        --     masondap.default_setup(config)
        -- end,
        --
        -- codelldb = function(config)
        --     config.configurations = {
        --         {
        --             name = 'LLDB: Launch file',
        --             type = 'codelldb',
        --             request = 'launch',
        --             program = function()
        --                 return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\', 'file')
        --             end,
        --             cwd = '${workspaceFolder}',
        --             stopOnEntry = false,
        --             args = {},
        --         },
        --
        --         {
        --             name = 'LLDB: Launch remote test',
        --             type = 'codelldb',
        --             request = 'launch',
        --             program = function()
        --                 return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\', 'file')
        --             end,
        --             cwd = '${workspaceFolder}',
        --             stopOnEntry = false,
        --             args = {},
        --             windows = {
        --                 MIMode = 'gdb',
        --                 miDebuggerPath = 'C:\\Renesas\\rcar-xos\\v3.8.0\\tools\\toolchains\\mingw64\\bin\\gdb.exe',
        --             }
        --         },
        --     }
        --     masondap.default_setup(config)
        -- end,
    }
})
