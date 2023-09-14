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
        function(config)
            -- all sources with no handler get passed here
            masondap.default_setup(config)
        end,
        cppdbg = function(config)
            config.adapters = {
                id = 'cppdbg',
                type = 'executable',
                command = vim.fn.exepath('OpenDebugAD7'),
                options = {
                    detached = vim.fn.has("linux"),
                },
            }
            config.configurations = {
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
                    miDebuggerServerAddress = 'localhost:1234',
                    miDebuggerPath = vim.fn.exepath('gdb'),
                    cwd = '${workspaceFolder}',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                },
            }
            masondap.default_setup(config)
        end,
    }
})
