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
        fg = "#5c87eb",
        bg = "#3b4261",
    },
    normal = {
        fg = "#c0caf5",
        bg = "#13141c",
    },
}

-- INFO: Component 1 - VI Mode
local vimode = {
    condition = conditions.is_active,
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
        mode_colors = {
            n = "#7aa2f7" ,
            i = "green",
            v = "cyan",
            V =  "cyan",
            c =  "orange",
            s =  "purple",
            S =  "purple",
            R =  "orange",
            r =  "orange",
            ["\19"] = "purple",
            ["\22"] = "cyan",
            ["!"] =  "red",
            t =  "red",
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
        provider = '',
        hl = function(self)
            local mode = vim.fn.mode(1):sub(1, 1) -- get only the first mode character
            return { fg = self.mode_colors[mode], bold = true, bg = my_color.normal.bg }
        end,
    },
    { provider = " " },
}

-- INFO: Component 2: Git
local git = {
    condition = conditions.is_active and conditions.is_git_repo,
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    hl = {
        fg = my_color.primary.fg,
        bg = my_color.primary.bg,
    },
    {
        provider = '',
        hl = {
            fg = my_color.primary.bg,
            bg = my_color.normal.bg,
        },
    },
    {   -- git branch name
        provider = function(self)
            return " " .. self.status_dict.head
        end,
        hl = { bold = true }
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and (" " .. count)
        end,
        hl = { fg = "green" },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and (" " .. count)
        end,
        hl = { fg = "red" },
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
            fg = my_color.primary.bg,
            bg = my_color.secondary.bg,
        },
    },
}

local none_git = {
    condition = conditions.is_active or not conditions.is_git_repo,
    hl = {
        fg = my_color.primary.fg,
        bg = my_color.primary.bg,
    },
    {
        provider = '',
        hl = {
            fg = my_color.primary.bg,
            bg = my_color.normal.bg,
        },
    },
    {   -- git branch name
        provider = function(self)
            return " None"
        end,
        hl = { bold = true }
    },
    {
        provider = '',
        hl = {
            fg = my_color.primary.bg,
            bg = my_color.secondary.bg,
        },
    },
}

-- INFO: Componen 3 - File name
local filename = {
    {
        provider = "%<", -- this means that the statusline is cut here when there's not enough space
        hl = function()
            if conditions.is_active then
                return { fg = my_color.secondary.fg, bg = my_color.secondary.bg }
            else
                return { fg = my_color.normal.fg, bg = my_color.normal.bg }
            end
        end,
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
            provider = '',
            hl = {
                fg = my_color.secondary.bg,
                bg = my_color.normal.bg,
            },
        },
        update = { "VimResized", "WinResized" },
    },
}

local diagnostics = {
    condition = conditions.is_active,
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
        fg = my_color.secondary.fg,
        bg = my_color.secondary.bg,
    },
    update = { "DiagnosticChanged", "BufEnter" },
    {
        provider = '',
        hl = {
            fg = my_color.secondary.bg,
            bg = my_color.normal.bg,
        },
    },
    {
        provider = " ",
    },
    {
        condition = conditions.has_diagnostics,
        provider = function(self)
            return self.errors > 0 and (self.error_icon .. self.errors .. " ")
        end,
        hl = { fg = get_hex("DiagnosticError").fg },
    },
    {
        condition = conditions.has_diagnostics,
        provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
        end,
        hl = { fg = get_hex("DiagnosticWarning").fg },
    },
    {
        condition = conditions.has_diagnostics,
        provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. " ")
        end,
        hl = { fg = get_hex("DiagnosticInfo").fg },
    },
    {
        condition = conditions.has_diagnostics,
        provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints)
        end,
        hl = { fg = get_hex("DiagnosticHint").fg },
    },
    {
        condition = conditions.has_diagnostics,
        provider = " ",
    },
}

local lsp = {
    condition = conditions.is_active or conditions.lsp_attached,
    update = {'LspAttach', 'LspDetach'},
    hl = {
        fg = my_color.primary.fg,
        bg = my_color.primary.bg,
    },
    {
        provider = '',
        hl = {
            fg = my_color.primary.bg,
            bg = my_color.secondary.bg,
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
            bg = my_color.secondary.bg,
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
    condition = conditions.is_active,
    -- condition = function()
    --     local session = require("dap").session()
    --     return session ~= nil
    -- end,
    -- hl = "Debug"
    hl = {
        fg = my_color.secondary.fg,
        bg = my_color.secondary.bg,
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
            fg = my_color.secondary.bg,
            bg = my_color.normal.bg,
        },
    },
}

local macro = {
    condition = function()
        if conditions.is_active then
            return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0
        else return false end
    end,
    provider = " ",
    hl = { fg = "orange", bold = true },
    utils.surround({ "[", "]" }, nil, {
        provider = function()
            return vim.fn.reg_recording()
        end,
        hl = { fg = "green", bold = true },
    }),
    update = {
        "RecordingEnter",
        "RecordingLeave",
    }
}

local percentage = {
    condition = conditions.is_active,
    static = {
        sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
    },
    hl = {
        fg = my_color.primary.fg,
        bg = my_color.primary.bg,
    },
    {
        provider = '',
        hl = {
            fg = my_color.primary.bg,
            bg = my_color.normal.bg,
        },
    },
    {
        provider = "%9(%l %c%) %P ",
    },
    {
        provider = function(self)
            local curr_line = vim.api.nvim_win_get_cursor(0)[1]
            local lines = vim.api.nvim_buf_line_count(0)
            local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
            return string.rep(self.sbar[i], 2)
        end,
        hl = { fg = my_color.primary.fg },
    },
    {
        provider = '',
        hl = {
            fg = my_color.primary.bg,
            bg = my_color.normal.bg,
        },
    },
}

local statusline = {
    vimode,
    git, none_git,
    filename,
    { provider = "%=" }, -- middle align
    diagnostics,
    lsp,
    debugger,
    { provider = "%=" }, -- right align
    macro,
    percentage,
}

heirline.setup({
    statusline = statusline,
    opts = {
        disable_winbar_cb = true,
    },
})
