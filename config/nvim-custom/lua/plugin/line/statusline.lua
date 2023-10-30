local status_ok, heirline = pcall(require, "heirline")
if not status_ok then
	print("Error: heirline")
	return
end

local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local get_hex = require('heirline.utils').get_highlight
local separator = require("plugin.line.icon").get_icon()

local exclusion = {
    buftype = { "nofile", "prompt", "quickfix" },
    filetype = { "neo-tree" },
}

local vimode = {
    condition = function()
        return conditions.is_active() and not conditions.buffer_matches(exclusion)
    end,
    static = {
        mode_names = {
            n = " Normal",
            no = " Normal-?",
            nov = " Normal-?",
            noV = " Normal-?",
            niI = " Normal-I",
            niR = " Normal-R",
            niV = " Normal-V",
            nt = " Normal-T",
            v = "󰉷 Visual",
            vs = "󰉷 Visual-Select",
            V = "󰉷 Visual-L",
            Vs = "󰉷 Visual-Select-L",
            s = "󰉷 Select",
            S = "󰉷 Select-L",
            i = " Insert",
            ic = " Insert-C",
            ix = " Insert-X",
            R = "󰌨 Replace",
            Rc = "󰌨 Replace-C",
            Rx = "󰌨 Replace-X",
            Rv = "󰌨 Replace-V",
            Rvc = "󰌨 Visual-Replace-C",
            Rvx = "󰌨 Visual-Replace-X",
            c = " Command",
            cv = " Command-V",
            r = "󰌨 Replace",
            rm = "󰌨 Replace",
            t = " Terminal",
            ["no\22"] = " Normal ?",
            ["\22"] = "󰉷 Visual ?",
            ["\22s"] = "󰉷 Visual ?",
            ["\19"] = "󰉷 Select ?",
            ["r?"] = "󰋖 Unknown",
            ["!"] = "󰋖 Unknown",
        },
        mode_names_short = {
            n = "",
            no = "?",
            nov = "?",
            noV = "?",
            niI = "I",
            niR = "R",
            niV = "V",
            nt = "T",
            v = "󰉷",
            vs = "󰉷",
            V = "󰉷L",
            Vs = "󰉷L",
            s = "󰉷",
            S = "󰉷L",
            i = " ",
            ic = " C",
            ix = " X",
            R = "󰌨 ",
            Rc = "󰌨 C",
            Rx = "󰌨 X",
            Rv = "󰌨 V",
            Rvc = "󰌨 C",
            Rvx = "󰌨 X",
            c = " ",
            cv = " V",
            r = "󰌨 ",
            rm = "󰌨 ",
            t = " ",
            ["no\22"] = " ?",
            ["\22"] = "󰉷?",
            ["\22s"] = "󰉷?",
            ["\19"] = "󰉷?",
            ["r?"] = "󰋖",
            ["!"] = "󰋖",
        },
        mode_colors = {
            n = "mode_n",
            i = "mode_i",
            v = "mode_v",
            V = "mode_v",
            c = "mode_c",
            s = "mode_s",
            S = "mode_s",
            R = "mode_r",
            r = "mode_r",
            ["\19"] = "mode_na1",
            ["\22"] = "mode_na2",
            ["!"] =  "mode_na3",
            t =  "mode_t",
        }
    },
    {
        provider = separator.external.left,
        hl = function(self)
            local mode = vim.fn.mode(1):sub(1, 1) -- get only the first mode character
            return { fg = self.mode_colors[mode], bold = true, bg = "normal_bg" }
        end,
    },
    {
        flexible = 8,
        {
            init = function(self)
                self.mode = vim.fn.mode(1)
            end,
            provider = function(self)
                return "%2("..self.mode_names[self.mode].."%)"
            end,
            hl = function(self)
                local mode = self.mode:sub(1, 1) -- get only the first mode character
                return { fg = "#15161e", bg = self.mode_colors[mode], bold = true, }
            end,
        },
        {
            init = function(self)
                self.mode = vim.fn.mode(1)
            end,
            provider = function(self)
                return "%1("..self.mode_names_short[self.mode].."%)"
            end,
            hl = function(self)
                local mode = self.mode:sub(1, 1) -- get only the first mode character
                return { fg = "#15161e", bg = self.mode_colors[mode], bold = true, }
            end,
        },
    },
    {
        provider = separator.external.right,
        hl = function(self)
            local mode = vim.fn.mode(1):sub(1, 1) -- get only the first mode character
            return { fg = self.mode_colors[mode], bold = true, bg = "secondary_bg" }
        end,
    },
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
    on_click = {
        callback = function()
            vim.cmd("lua ToggleCopyMode()")
        end,
        update = true,
        name = "toggle_copy_mode",
    },
}

local has_git = {
    condition = function()
        return (conditions.is_active() and conditions.is_git_repo()) and not conditions.buffer_matches(exclusion)
    end,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    hl = {
        fg = "secondary_fg",
        bg = "secondary_bg",
    },
    {   -- git branch name
        provider = function(self)
            return "  " .. self.status_dict.head
        end,
        hl = { bold = true },
    },
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = ' ' .. separator.internal.right,
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and (" " .. vim.g.propofont .. count)
        end,
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and (" " .. vim.g.propofont .. count)
        end,
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and (" " .. vim.g.propofont .. count)
        end,
    },
    {
        provider = separator.external.right,
        hl = {
            fg = "secondary_bg",
            bg = "tertiary_bg",
        },
    },
    on_click = {
        callback = function()
            vim.cmd("Gitsigns toggle_current_line_blame")
        end,
        update = true,
        name = "toggle_git_blame",
    },
}

local none_git = {
    condition = function()
        return (conditions.is_active() and not conditions.is_git_repo()) and not conditions.buffer_matches(exclusion)
    end,
    hl = {
        fg = "secondary_fg",
        bg = "secondary_bg",
    },
    {   -- git branch name
        provider = function()
            return " " .. vim.g.propofont
        end,
        hl = { bold = true }
    },
    {
        provider = separator.external.right,
        hl = {
            fg = "secondary_bg",
            bg = "tertiary_bg",
        },
    },
}

local git = { -- Merge has_git and none_git together
    flexible = 7,
    {
        has_git,
        none_git,
    },
    {
        condition = conditions.is_active,
        provider = separator.external.right,
        hl = {
            fg = "secondary_bg",
            bg = "tertiary_bg",
        },
    },
}

local filename = {
    hl = function()
        if conditions.is_active() then
            if conditions.buffer_matches(exclusion) then
                return { fg = "primary_fg", bg = "primary_bg" }
            else
                return { fg = "tertiary_fg", bg = "tertiary_bg" }
            end
        else
            return { fg = "normal_fg", bg = "normal_bg" }
        end
    end,
    {
        condition = function()
            return conditions.is_active() and conditions.buffer_matches(exclusion)
        end,
        provider = separator.external.left,
        hl = {
            fg = "primary_bg",
            bg = "primary_fg",
        },
    },
    {   -- file name icon
        init = function(self)
            local filename = vim.api.nvim_buf_get_name(0)
            local extension = vim.fn.fnamemodify(filename, ":e")
            self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
        end,
        provider = function(self)
            return self.icon and (" " .. self.icon .. " ")
        end,
    },
    { provider = "%<" }, -- this means that the statusline is cut here when there's not enough space
    {   -- file name
        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(0)
        end,
        provider = function(self)
            local filename = vim.fn.fnamemodify(self.filename, ":p:t")
            if filename == "" then return " Unnamed" end
            if not conditions.width_percent_below(#filename, 0.25) then
                filename = vim.fn.pathshorten(filename)
            end
            return filename .. " "
        end,
    },
    {   -- modify icon
        condition = function()
            return vim.bo.modified
        end,
        provider = "" .. vim.g.propofont,
    },
    {   -- read only icon
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = "",
    },
    {
        condition = conditions.is_active,
        provider = separator.external.right,
        hl = function()
            if conditions.buffer_matches(exclusion) then
                return { fg = "primary_bg", bg = "primary_fg", bold = true }
            else
                return { fg = "tertiary_bg", bg = "normal_bg", bold = true }
            end
        end,
    },
    on_click = {
        callback = function()
            print(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:~"))
        end,
        update = true,
        name = "filename_print"
    },
    update = { "VimResized", "WinResized", "BufEnter" },
}

local diagnostics = {
    condition = function()
        return conditions.is_active() and not conditions.buffer_matches(exclusion)
    end,
    init = function(self)
        self.error_icon = ""
        self.warn_icon = ""
        self.info_icon = ""
        self.hint_icon = "󰮕"
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,
    hl = {
        fg = "tertiary_fg",
        bg = "tertiary_bg",
    },
    update = { "DiagnosticChanged", "BufEnter" },
    {
        provider = separator.external.left,
        hl = {
            fg = "tertiary_bg",
            bg = "normal_bg",
        },
    },
    {
        condition = function()
			return conditions.has_diagnostics() and require("dap").session() == nil
		end,
        {
            provider = function(self)
                return self.errors > 0 and (" " .. self.error_icon .. vim.g.propofont .. self.errors)
            end,
            hl = { fg = get_hex("DiagnosticError").fg },
        },
        {
            provider = function(self)
                return self.warnings > 0 and (" " .. self.warn_icon .. vim.g.propofont .. self.warnings)
            end,
            hl = { fg = get_hex("DiagnosticWarn").fg },
        },
        {
            provider = function(self)
                return self.info > 0 and (" " .. self.info_icon .. vim.g.propofont .. self.info)
            end,
            hl = { fg = get_hex("DiagnosticInfo").fg },
        },
        {
            provider = function(self)
                return self.hints > 0 and (" " .. self.hint_icon .. vim.g.propofont .. self.hints)
            end,
            hl = { fg = get_hex("DiagnosticHint").fg },
        },
        { provider = " " },
    },
    on_click = {
        callback = function()
            require("trouble").toggle({ mode = "document_diagnostics" })
        end,
        name = "open_trouble",
    },
}

local lsp = {
    condition = function()
        return conditions.is_active() and not conditions.buffer_matches(exclusion)
    end,
    update = {'LspAttach', 'LspDetach'},
    hl = {
        fg = "secondary_fg",
        bg = "secondary_bg",
        bold = true,
    },
    {
        provider = separator.external.left,
        hl = {
            fg = "secondary_bg",
            bg = "tertiary_bg",
        },
    },
    {
        provider  = function()
            local lsp_numnr = 0
            for _,_ in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
                lsp_numnr = lsp_numnr + 1
            end
            return vim.g.propofont .. " " .. lsp_numnr .. " "
        end,
    },
    on_click = {
        callback = function()
            local names = {}
            for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
                table.insert(names, server.name)
            end
            print(table.concat(names, " "))
        end,
        update = true,
        name = "lsp_print"
    },
}

local status = {
    condition = function()
        return conditions.is_active() and not conditions.buffer_matches(exclusion)
    end,
    hl = {
        fg = "primary_fg",
        bg = "primary_bg",
        bold = true,
    },
    {
        provider = separator.external.left,
        hl = {
            fg = "primary_bg",
            bg = "secondary_bg",
        },
    },
    {
        provider  = function()
            if vim.fn.has("unix") then return "" .. vim.g.propofont
            else return "" .. vim.g.propofont end
        end,
    },
    {
        provider = separator.external.right,
        hl = {
            fg = "primary_bg",
            bg = "secondary_bg",
        },
    },
    on_click = {
        callback = function()
            print(vim.loop.os_uname().sysname)
        end,
        update = true,
        name = "print_os"
    },

}

local debug_status = false
local debug_session = {
    condition = function()
        return conditions.is_active() and not conditions.buffer_matches(exclusion)
    end,
    hl = {
        fg = "secondary_fg",
        bg = "secondary_bg",
    },
    {
        provider = function()
            local session = require("dap").session()
            if session ~= nil and debug_status then return "  " .. require("dap").status()
            else return " " .. vim.g.propofont end
        end,
    },
    {
        provider = separator.external.right,
        hl = {
            fg = "secondary_bg",
            bg = "tertiary_bg",
        },
    },
    on_click = {
        callback = function()
			if debug_status then debug_status = false
			else debug_status = true end
        end,
        update = true,
        name = "toggle_dap_status",
    },
}

local debug_repl = {
    condition = function()
        return conditions.is_active() and not conditions.buffer_matches(exclusion)
    end,
    hl = {
        fg = "tertiary_fg",
        bg = "tertiary_bg",
    },
    {
        {
            condition = function()
                return require("dap").session() ~= nil
            end,
            { provider = " " },
            {
                provider = vim.g.propofont .. "" .. vim.g.propofont,
                hl = { fg = "yellow" },
                on_click = {
                    callback = function()
                        vim.cmd("DapContinue")
                    end,
                    update = true,
                    name = "dap_run",
                },
            },
        },
        {
            condition = function()
                return require("dap").session() ~= nil
            end,
            { provider = " " },
            {
                provider = "" .. vim.g.propofont,
                hl = { fg = "green" },
                on_click = {
                    callback = function()
                        require("dap").pause()
                    end,
                    update = true,
                    name = "dap_pause",
                },
            },
        },
        {
            condition = function()
                return require("dap").session() ~= nil
            end,
            { provider = " " },
            {
                provider = "" .. vim.g.propofont,
                hl = { fg = "cyan" },
                on_click = {
                    callback = function()
                        vim.cmd("DapStepOver")
                    end,
                    update = true,
                    name = "dap_stepover",
                },
            },
        },
        {
            condition = function()
                return require("dap").session() ~= nil
            end,
            { provider = " " },
            {
                provider = "" .. vim.g.propofont,
                hl = { fg = "cyan" },
                on_click = {
                    callback = function()
                        vim.cmd("DapStepInto")
                    end,
                    update = true,
                    name = "dap_stepinto",
                },
            },
        },
        {
            condition = function()
                return require("dap").session() ~= nil
            end,
            { provider = " " },
            {
                provider = "" .. vim.g.propofont,
                hl = { fg = "cyan" },
                on_click = {
                    callback = function()
                        vim.cmd("DapStepOut")
                    end,
                    update = true,
                    name = "dap_stepout",
                },
            },
        },
        {
            condition = function()
                return require("dap").session() ~= nil
            end,
            { provider = " " },
            {
                provider = "" .. vim.g.propofont,
                hl = { fg = "red" },
                on_click = {
                    callback = function()
                        vim.cmd("DapTerminate")
                    end,
                    update = true,
                    name = "dap_terminate",
                },
            },
        },
        {
            condition = function()
                return require("dap").session() ~= nil
            end,
            { provider = " " },
            {
                provider = vim.g.propofont .. "󰇀" .. vim.g.propofont,
                hl = { fg = "yellow" },
                on_click = {
                    callback = function()
                        require("dap").run_to_cursor()
                    end,
                    update = true,
                    name = "dap_run_to_cursor",
                },
            },
        },
        {
            condition = function()
                return require("dap").session() ~= nil
            end,
            { provider = " " },
            {
                provider = "󱔏" .. vim.g.propofont,
                on_click = {
                    callback = function()
                        vim.cmd("DapVirtualTextToggle")
                        vim.cmd("DapVirtualTextForceRefresh")
                    end,
                    update = true,
                    name = "dap_toggle_virtual_text",
                },
            },
        },
    },
    {
        provider = separator.external.right,
        hl = {
            fg = "tertiary_bg",
            bg = "normal_bg",
        },
    },
}

local debugger = {
    debug_session,
    debug_repl,
}


local key = {
    flexible = 2,
    {
        condition = function()
            if conditions.is_active() and not conditions.buffer_matches(exclusion) then
                return vim.o.cmdheight == 0
            else return false end
        end,
        hl = { fg = "normal_fg", bg = "tertiary_bg" },
        {
            provider = separator.external.left,
            hl = {
                fg = "tertiary_bg",
                bg = "normal_bg",
            },
        },
        { provider = "%3.5(%S%) " },
    },
    {
        condition = conditions.is_active,
        provider = separator.external.left,
        hl = {
            fg = "tertiary_bg",
            bg = "normal_bg",
        },
    },
}

local macro = {
    flexible = 1,
    {
        condition = function()
            if conditions.is_active() and not conditions.buffer_matches(exclusion) then
                return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
            else return false end
        end,
        provider = " record macro to ",
        hl = { fg = "orange", bg = "normal_bg", bold = true },
        utils.surround({ "[", "]" }, nil, {
            provider = function()
                return vim.fn.reg_recording()
            end,
            hl = { fg = "green", bold = true },
        }),
        { provider = " " },
        update = {
            "RecordingEnter",
            "RecordingLeave",
        }
    },
    { provider = "" },
}

local percentage = {
    condition = function()
        return conditions.is_active() and not conditions.buffer_matches(exclusion)
    end,
    static = {
        sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
    },
    hl = {
        fg = "secondary_fg",
        bg = "secondary_bg",
    },
    {
        provider = separator.external.left,
        hl = {
            fg = "secondary_bg",
            bg = "tertiary_bg",
        },
    },
    {
        flexible = 5,
        {
            {
                provider = ' %P ',
            },
            {
                provider = function(self)
                    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
                    local lines = vim.api.nvim_buf_line_count(0)
                    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
                    return string.rep(self.sbar[i], 2) .. " "
                end,
            },
        },
        { provider = "" },
    }
}

local lines = {
    hl = function()
        if conditions.is_active() then
            return { fg = "primary_fg", bg = "primary_bg", bold = true }
        else
            return { fg = "normal_fg", bg = "normal_bg", bold = false }
        end
    end,
    {
        condition = conditions.is_active,
        provider = separator.external.left,
        hl = function()
            if conditions.buffer_matches(exclusion) then
                return { fg = "primary_bg", bg = "tertiary_bg" }
            else
                return { fg = "primary_bg", bg = "secondary_bg" }
            end
        end,
    },
    {
        flexible = 6,
        {
            {
                provider = " %4(%l %c%)",
            },
            {
                condition = conditions.is_not_active,
                provider = ' ',
            },
        },
        { provider = "" },
    },
    {
        condition = conditions.is_active,
        provider = separator.external.right,
        hl = {
            fg = "primary_bg",
            bg = "normal_bg",
        },
    },
}

local blank = { provider = "" }
local space = { provider = " " }

local statusline = {
    {
        flexible = 9,
        vimode,
    },
    git,
    filename,
    {
        { provider = "%=" }, -- middle align
        {
            flexible = 3,
            {
                space,
                diagnostics,
                lsp,
                status,
                debugger,
                space,
            },
            blank,
        },
        { provider = "%=" }, -- right align
        {
            macro,
            key,
            percentage,
            lines,
        },
    },
    hl = { fg = "normal_fg", bg = "normal_bg" },
}

return statusline
