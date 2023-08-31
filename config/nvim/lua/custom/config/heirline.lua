local status_ok, heirline = pcall(require, "heirline")
if not status_ok then
	print("Error: heirline")
	return
end

local get_hex = require('heirline/utils').get_highlight

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
        bg = "#13141c",
    },
}

local vimode = {
    init = function(self)
        self.mode = vim.fn.mode(1)
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
            i = "I",
            ic = "Ic",
            ix = "Ix",
            R = "󰌨 Replace",
            Rc = "󰌨 Replace-C",
            Rx = "󰌨 Replace-X",
            Rv = "󰌨 Replace-V",
            Rvc = "󰌨 Visual-Replace-C",
            Rvx = "󰌨 Visual-Replace-X",
            c = " Command",
            cv = " Command",
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
            n = "red" ,
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
    provider = function(self)
        return "  %2("..self.mode_names[self.mode].."%)"
    end,
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = get_hex("Normal").bg, bg = self.mode_colors[mode], bold = true, }
    end,
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
            vim.cmd("redrawstatus")
        end),
    },
}

-- text = '',
-- text = '',
--
local statusline = {
    -- {
    --     {
    --         provider = ' ',
    --     },
        vimode,
    --     {
    --         provider = '',
    --     },
    -- },
    -- {
    --     provider = " %f ",
    --     hl = {
    --         fg = get_hex("DiagnosticError").fg,
    --         bg = my_color.primary.bg,
    --     },
    -- },
    -- {
    --     provider = "%p %)",
    -- },
}

heirline.setup({
    statusline = statusline,
    opts = {
        disable_winbar_cb = true,
    },
})
