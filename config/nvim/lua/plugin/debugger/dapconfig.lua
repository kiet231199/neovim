local dap = require('dap')

-- Resolve a debugger for the current platform: keep the Linux default unchanged
-- and pick gdb/lldb from PATH on Windows (e.g. from MSYS2 or LLVM).
local function find_debugger()
	if vim.fn.has("win32") == 1 then
		local exe = vim.fn.exepath("gdb")
		if exe == "" then exe = vim.fn.exepath("lldb") end
		return exe
	end
	return "/usr/bin/gdb"
end

-- c/cpp
local cpptools = vim.g.dot_path .. "/config/dap/extension/debugAdapters/bin/OpenDebugAD7"
if vim.fn.has("win32") == 1 and vim.fn.filereadable(cpptools .. ".exe") == 1 then
	cpptools = cpptools .. ".exe" -- Windows build of the adapter
end

dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = cpptools,
}
dap.configurations.c = {
    {
        name = "Local debug",
        type = "cppdbg",
        request = "launch",
        MIMode = "gdb",
        miDebuggerPath = find_debugger(),
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = false,
        setupCommands = {
			-- {
			-- 	description = 'Set arguments to debugger',
			-- 	text = 'set args output -c',
			-- 	ignoreFailures = true
			-- },
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
        stopAtEntry = false,
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        setupCommands = {
            {
                description = 'Setup sysroot',
                text = 'set sysroot /data1/tftpboot/kietpham/g2l/', -- INFO: Path to tftpboot
                ignoreFailures = false
            },
        },
    },
    {
        name = 'IT2 Remote debug',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = '192.168.5.125:80', -- INFO: Remote board IP
        miDebuggerPath = vim.fn.exepath('/data2/sdk/01_G2L/sysroots/x86_64-pokysdk-linux/usr/bin/aarch64-poky-linux/aarch64-poky-linux-gdb'),         -- INFO: Path to bin/aarch64-poky-linux-gdb in toolchain
        cwd = '${workspaceFolder}',
        stopAtEntry = false,
        program = function()
            return vim.fn.input('Path to executable: ', '/data1/kietpham/01_codec/omx_test/IT/IT2/build/usr/local/bin/', 'file')
        end,
        setupCommands = {
            {
                description = 'Setup sysroot',
                text = 'set sysroot /data1/tftpboot/kietpham/g2l/', -- INFO: Path to tftpboot
                ignoreFailures = false
            },
			-- {
			-- 	description = 'Set arguments to debugger',
			-- 	text = 'set args "output"',
			-- 	ignoreFailures = true
			-- },
        },
    },
}

dap.configurations.cpp = dap.configurations.c
