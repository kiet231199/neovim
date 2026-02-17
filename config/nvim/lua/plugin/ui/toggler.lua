local status_ok, megatoggler = pcall(require, "megatoggler")
if not status_ok then
	print("Error: megatoggler")
	return
end

megatoggler.setup({
    ui = {
        width = 60,
        height = 10,
        border = "rounded",  -- also used for value inputs
        value_input = 'overlay', -- 'overlay' | 'nui' (requires nui.nvim)
        padding = '  ',      -- global left padding for items
        icons = { checked = '', unchecked = '' },
    },
    persist = false,
    persist_namespace = "default",
    persist_file = vim.fn.stdpath('config') .. '/megatoggler_state.json',
    tabs = {
        {
            -- global options you might want to persist
            id = " Globals ",
            items = {
                {
                    id = "Status Line",
                    get = function()
                        if vim.o.laststatus == 3 then return true
                        else return false end
                    end,
                    on_toggle = function()
                        if vim.o.laststatus == 3 then
                            vim.o.laststatus = 2
                            return
                        end
                        vim.o.laststatus = 3
                    end,
                },
            }
        },
        {
            id = " Features ",
            items = {
                {
                    id = "Copy Mode",
                    get = function()
                        return not vim.o.number
                    end,
                    on_toggle = function()
                        if vim.o.number == true then
                            vim.o.signcolumn = "no"
                            vim.o.number = false
                            vim.o.relativenumber = false
                            -- vim.o.mouse = ""
                            require("snacks").indent.disable()
                            vim.cmd("ScrollViewDisable")
                        else
                            vim.o.signcolumn = "yes"
                            vim.o.number = true
                            vim.o.relativenumber = true
                            -- vim.o.mouse = "a"
                            require("snacks").indent.enable()
                            vim.cmd("ScrollViewEnable")
                        end
                    end
                },
                {
                    id = "LSP Diagnostic",
                    get = function()
                        return vim.diagnostic.is_enabled()
                    end,
                    on_toggle = function()
                        if vim.diagnostic.is_enabled() then
                            vim.diagnostic.enable(false)
                        else
                            vim.diagnostic.enable(true)
                        end
                    end
                },
                {
                    id = "Dark Mode",
                    get = function()
                        local option = require("plugin.colorscheme").get_option()
                        if option.background == "dark" then return true
                        else return false end
                    end,
                    on_toggle = function()
                        require("plugin.colorscheme").toggle_background()
                    end
                },
            }
        }
    }
})
