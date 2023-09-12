local status_ok, heirline = pcall(require, "heirline")
if not status_ok then
	print("Error: heirline")
	return
end

-- INFO: Define built in modules
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

-- INFO: Define built in utility functions
local get_hex = require('heirline.utils').get_highlight

-- INFO: Define some tables
local my_color = {
    primary = {
        fg = "#15161e",
        bg = "#7aa2f7",
    },
    secondary = {
        fg = "#0c1220",
        bg = "#616da0",
    },
    tertiary = {
        fg = "#5c87eb",
        bg = "#3b4261",
    },
    normal = {
        fg = "#c0caf5",
        bg = "#13141c",
    },
}

local my_exclude = {
    buftype = { "nofile", "prompt", "quickfix" },
    filetype = { "neo-tree" },
}

local vimode = {
    condition = function()
        return conditions.is_active() and not conditions.buffer_matches(my_exclude)
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
            i = "",
            ic = "C",
            ix = "X",
            R = "󰌨",
            Rc = "󰌨C",
            Rx = "󰌨X",
            Rv = "󰌨V",
            Rvc = "󰌨C",
            Rvx = "󰌨X",
            c = "",
            cv = "V",
            r = "󰌨",
            rm = "󰌨",
            t = "",
            ["no\22"] = "?",
            ["\22"] = "󰉷?",
            ["\22s"] = "󰉷?",
            ["\19"] = "󰉷?",
            ["r?"] = "󰋖",
            ["!"] = "󰋖",
        },
        mode_colors = {
            n = "#7aa2f7",
            i = "#3d59a1",
            v = "#5c87eb",
            V = "#5c87eb",
            c =  "#3acaba",
            s =  "purple",
            S =  "purple",
            R =  "#3acaba",
            r =  "#3acaba",
            ["\19"] = "purple",
            ["\22"] = "cyan",
            ["!"] =  "pink",
            t =  "pink",
        }
    },
    {
        provider = '',
        hl = function(self)
            local mode = vim.fn.mode(1):sub(1, 1) -- get only the first mode character
            return { fg = self.mode_colors[mode], bold = true, bg = get_hex("Normal").bg }
        end,
    },
    {
        flexible = 7,
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
            update = {
                "ModeChanged",
                pattern = "*:*",
                callback = vim.schedule_wrap(function()
                    vim.cmd("redrawstatus")
                end),
            },

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
            update = {
                "ModeChanged",
                pattern = "*:*",
                callback = vim.schedule_wrap(function()
                    vim.cmd("redrawstatus")
                end),
            },
        },
    },
    {
        provider = '',
        hl = function(self)
            local mode = vim.fn.mode(1):sub(1, 1) -- get only the first mode character
            return { fg = self.mode_colors[mode], bold = true, bg = my_color.secondary.bg }
        end,
    },
}

local has_git = {
    condition = function()
        return (conditions.is_active() and conditions.is_git_repo()) and not conditions.buffer_matches(my_exclude)
    end,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    hl = {
        fg = my_color.secondary.fg,
        bg = my_color.secondary.bg,
    },
    {   -- git branch name
        provider = function(self)
            return "  " .. self.status_dict.head
        end,
        hl = { bold = true },
    },
    {
        condition = function(self)
            local count = 0
            count = count + (self.status_dict.added or 0)
            count = count + (self.status_dict.removed or 0)
            count = count + (self.status_dict.changed or 0)
            return (count > 0)
        end,
        provider = ' ',
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and (" " .. count)
        end,
        hl = { fg = "#374a45" },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and (" " .. count)
        end,
        hl = { fg = "#cc0000" },
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and (" " .. count)
        end,
        hl = { fg = "yellow" },
    },
    {
        provider = '',
        hl = {
            fg = my_color.secondary.bg,
            bg = my_color.tertiary.bg,
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
        return (conditions.is_active() and not conditions.is_git_repo()) and not conditions.buffer_matches(my_exclude)
    end,
    hl = {
        fg = my_color.secondary.fg,
        bg = my_color.secondary.bg,
    },
    {   -- git branch name
        provider = function()
            return "  None"
        end,
        hl = { bold = true }
    },
    {
        provider = '',
        hl = {
            fg = my_color.secondary.bg,
            bg = my_color.tertiary.bg,
        },
    },
}

local git = { -- Merge has_git and none_git together
    flexible = 6,
    {
        has_git,
        none_git,
    },
    {
        condition = conditions.is_active,
        provider = '',
        hl = {
            fg = my_color.secondary.bg,
            bg = my_color.normal.bg,
        },
    },
}

local filename = {
    hl = function()
        if conditions.is_active() then
            if conditions.buffer_matches(my_exclude) then
                return { fg = my_color.primary.fg, bg = my_color.primary.bg }
            else
                return { fg = my_color.tertiary.fg, bg = my_color.tertiary.bg }
            end
        else
            return { fg = my_color.normal.fg, bg = my_color.normal.bg }
        end
    end,
    {
        condition = function()
            return conditions.is_active() and conditions.buffer_matches(my_exclude)
        end,
        provider = '',
        hl = {
            fg = my_color.primary.bg,
            bg = my_color.primary.fg,
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
            if filename == "" then return " None" end
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
        provider = "",
    },
    {   -- read only icon
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = "",
    },
    {
        condition = conditions.is_active,
        provider = '',
        hl = function()
            if conditions.buffer_matches(my_exclude) then
                return { fg = my_color.primary.bg, bg = my_color.primary.fg, bold = true }
            else
                return { fg = my_color.tertiary.bg, bg = my_color.normal.bg, bold = true }
            end
        end,
    },
    on_click = {
        callback = function(self)
            print(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:~"))
        end,
        update = true,
        name = "filename_print"
    },
    update = { "VimResized", "WinResized", "BufEnter" },
}

local diagnostics = {
    condition = function()
        return conditions.is_active() and not conditions.buffer_matches(my_exclude)
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
        fg = my_color.tertiary.fg,
        bg = my_color.tertiary.bg,
    },
    update = { "DiagnosticChanged", "BufEnter" },
    {
        provider = '',
        hl = {
            fg = my_color.tertiary.bg,
            bg = my_color.normal.bg,
        },
    },
    {
        provider = " ",
    },
    {
        condition = conditions.has_diagnostics,
        {
            provider = function(self)
                return self.errors > 0 and (self.error_icon .. self.errors .. " ")
            end,
            hl = { fg = get_hex("DiagnosticError").fg },
        },
        {
            provider = function(self)
                return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
            end,
            hl = { fg = get_hex("DiagnosticWarn").fg },
        },
        {
            provider = function(self)
                return self.info > 0 and (self.info_icon .. self.info .. " ")
            end,
            hl = { fg = get_hex("DiagnosticInfo").fg },
        },
        {
            provider = function(self)
                return self.hints > 0 and (self.hint_icon .. self.hints)
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
        return conditions.is_active() and not conditions.buffer_matches(my_exclude)
    end,
    update = {'LspAttach', 'LspDetach'},
    hl = {
        fg = my_color.primary.fg,
        bg = my_color.primary.bg,
        bold = true,
    },
    {
        provider = '',
        hl = {
            fg = my_color.primary.bg,
            bg = my_color.tertiary.bg,
        },
    },
    {
        provider  = function()
            local lsp_numnr = 0
            for _,_ in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
                lsp_numnr = lsp_numnr + 1
            end
            return " " .. lsp_numnr
        end,
    },
    {
        provider = '',
        hl = {
            fg = my_color.primary.bg,
            bg = my_color.tertiary.bg,
        },
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

-- INFO: Reserved
local debugger = {
    condition = function()
        return conditions.is_active() and not conditions.buffer_matches(my_exclude)
    end,
    -- condition = function()
    --     local session = require("dap").session()
    --     return session ~= nil
    -- end,
    -- hl = "Debug"
    hl = {
        fg = my_color.tertiary.fg,
        bg = my_color.tertiary.bg,
    },
    {
        provider = function()
            return "  None"
            -- return " " .. require("dap").status()
         end,
    },
    {
        provider = '',
        hl = {
            fg = my_color.tertiary.bg,
            bg = my_color.normal.bg,
        },
    },
}

local key = {
    condition = function()
        if conditions.is_active() then
            return vim.o.cmdheight == 0
        else return false end
    end,
    hl = { fg = my_color.tertiary.fg, bg = my_color.tertiary.bg },
    {
        provider = '',
        hl = {
            fg = my_color.tertiary.bg,
            bg = my_color.normal.bg,
        },
    },
    { provider = "%3.5(%S%) " },
}

local macro = {
    condition = function()
        if conditions.is_active() then
            return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
        else return false end
    end,
    provider = " record macro to ",
    hl = { fg = "orange", bg = my_color.normal.bg, bold = true },
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
}

local percentage = {
    condition = function()
        return conditions.is_active() and not conditions.buffer_matches(my_exclude)
    end,
    static = {
        sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
    },
    hl = {
        fg = my_color.secondary.fg,
        bg = my_color.secondary.bg,
    },
    {
        provider = '',
        hl = {
            fg = my_color.secondary.bg,
            bg = my_color.tertiary.bg,
        },
    },
    {
        flexible = 3,
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
                -- hl = { fg = my_color.secondary.fg },
            },
        },
        { provider = "" },
    }
}

local lines = {
    hl = function()
        if conditions.is_active() then
            return { fg = my_color.primary.fg, bg = my_color.primary.bg, bold = true }
        else
            return { fg = my_color.normal.fg, bg = my_color.normal.bg, bold = false }
        end
    end,
    {
        condition = conditions.is_active,
        provider = '',
        hl = {
            fg = my_color.primary.bg,
            bg = my_color.secondary.bg,
        },
    },
    {
        provider = "%9(%l %c%)",
    },
    {
        condition = conditions.is_not_active,
        provider = ' ',
    },
    {
        condition = conditions.is_active,
        provider = '',
        hl = {
            fg = my_color.primary.bg,
            bg = my_color.normal.bg,
        },
    },
}

local blank = { provider = "" }

local statusline = {
    {
        flexible = 8,
        vimode,
    },
    git,
    filename,
    { provider = "%=" }, -- middle align
    {
        flexible = 2,
        {
            diagnostics,
            lsp,
            debugger,
        },
        blank,
    },
    { provider = "%=" }, -- right align
    {
        flexible = 1,
        {
            macro,
            key,
        },
        blank,
    },
    {
        flexible = 4,
        {
            percentage,
            lines,
        },
        blank,
    },
}

return statusline
