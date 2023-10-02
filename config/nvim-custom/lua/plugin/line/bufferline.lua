local status_ok, heirline = pcall(require, "heirline")
if not status_ok then
	print("Error: heirline")
	return
end

local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local separator = require("plugin.line.icon").get_icon()

local exclusion = {
    buftype = { "nofile", "prompt", "quickfix" },
    filetype = { "neo-tree" },
}

-- initialize the buflist cache
local current_buffer_list = {}

local update_buffer_list = function()
    vim.schedule(function()
        local buffers = vim.tbl_filter(function(bufnr)
            return vim.api.nvim_buf_get_option(bufnr, "buflisted")
        end, vim.api.nvim_list_bufs())
        for i, v in ipairs(buffers) do
            current_buffer_list[i] = v
        end
        for i = #buffers + 1, #current_buffer_list do
            current_buffer_list[i] = nil
        end
    end)
end

-- setup an autocmd that updates the buffer list every events happend
vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete", "SourcePost" }, {
    callback = function()
        update_buffer_list()
    end,
})

local buffername = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(self.bufnr)
    end,
    hl = function(self)
        if self.is_active then
            return { fg = "primary_fg", bg = "primary_bg" }
        elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
            return { fg = "tertiary_fg", bg = "tertiary_bg" }
        else
            return { fg = "secondary_fg", bg = "secondary_bg" }
        end
    end,
    {
        provider = separator.external.left,
        hl = function(self)
            if self.is_active then
                return { fg = "primary_bg", bg = "normal_bg" }
            elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
                return { fg = "tertiary_bg", bg = "normal_bg" }
            else
                return { fg = "secondary_bg", bg = "normal_bg" }
            end
        end,
    },
    {
        provider = function(self)
            return " " .. (self.bufnr) .. ". "
        end,
    },
    {
        init = function(self)
            local extension = vim.fn.fnamemodify(self.filename, ":e")
            self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(self.filename, extension, { default = true })
        end,
        provider = function(self)
            return self.icon and (self.icon .. " ")
        end,
    },
    {
        provider = function(self)
            local name = self.filename
            name = name == "" and " None" or vim.fn.fnamemodify(self.filename, ":t")
            return name
        end,
        hl = function(self)
            return { bold = self.is_active }
        end,
    },
    {
        {
            condition = function(self)
                return vim.api.nvim_buf_get_option(self.bufnr, "modified")
            end,
            provider = " ",
        },
        {
            condition = function(self)
                return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
                    or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
            end,
            provider = function(self)
                if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
                    return "  "
                else
                    return " "
                end
            end,
        },
    },
    {
        condition = function(self)
            return not vim.api.nvim_buf_get_option(self.bufnr, "modified")
        end,
        { provider = " " },
        {
            provider = "",
            on_click = {
                callback = function(_, minwid)
                    vim.schedule(function()
                        vim.api.nvim_buf_delete(minwid, { force = false })
                        vim.cmd.redrawtabline()
                    end)
                end,
                minwid = function(self)
                    return self.bufnr
                end,
                name = "heirline_tabline_close_buffer_callback",
            },
        },
    },
    { provider = " " },
    {
        provider = separator.external.right,
        hl = function(self)
            if self.is_active then
                return { fg = "primary_bg", bg = "normal_bg" }
            elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
                return { fg = "tertiary_bg", bg = "normal_bg" }
            else
                return { fg = "secondary_bg", bg = "normal_bg" }
            end
        end,
    },
    on_click = {
        callback = function(_, minwid, _, button)
            if (button == "m") then -- close on mouse middle click
                vim.schedule(function()
                    vim.api.nvim_buf_delete(minwid, { force = false })
                end)
            else
                vim.api.nvim_win_set_buf(0, minwid)
            end
        end,
        minwid = function(self)
            return self.bufnr
        end,
        name = "heirline_tabline_buffer_callback",
    },
}

local buffer = utils.make_buflist(
    { buffername, { provider = " " } },
    { provider = " ", hl = { fg = "orange", bg = "normal_bg" } },
    { provider = " ", hl = { fg = "orange", bg = "normal_bg" } },
    function() return current_buffer_list end,
    false
)

local offset = {
    condition = function(self)
        local win = vim.api.nvim_tabpage_list_wins(0)[1]
        local bufnr = vim.api.nvim_win_get_buf(win)
        self.winid = win

        if vim.bo[bufnr].filetype == "neo-tree" then
            self.title = "Neo-tree"
            return true
        -- elseif vim.bo[bufnr].filetype == "TagBar" then
        --     ...
        end
    end,
    hl = function(self)
        local bufnr = vim.api.nvim_win_get_buf(0)
        if vim.api.nvim_get_current_win() == self.winid or vim.bo[bufnr].filetype == "neo-tree" then
            return { fg = "primary_bg", bg = "normal_bg" }
        else
            return { fg = "normal_bg", bg = "normal_bg" }
        end
    end,
    { provider = separator.external.left },
    {
        provider = function(self)
            local title = self.title
            local width = vim.api.nvim_win_get_width(self.winid)
            local pad = math.ceil((width - #title) / 2) - 1
            return string.rep(" ", pad) .. title .. string.rep(" ", pad)
        end,
        hl = function(self)
            local bufnr = vim.api.nvim_win_get_buf(0)
            if vim.api.nvim_get_current_win() == self.winid or vim.bo[bufnr].filetype == "neo-tree" then
                return { fg = "primary_fg", bg = "primary_bg", bold = true }
            else
                return { fg = "normal_fg", bg = "normal_bg" }
            end
        end,
    },
    { provider = separator.external.right .. " " },
}

local time = {
    hl = {
        fg = "primary_fg",
        bg = "primary_bg",
        bold = true,
    },
    {
        condition = conditions.is_active,
        provider = separator.external.left,
        hl = {
            fg = "primary_bg",
            bg = "normal_bg",
        },
    },
    {
        provider = function()
            if vim.fn.winwidth(0) > 100 then
                return ' 󰃰 ' .. vim.fn.strftime('%H:%M - %a, %d/%m/%Y') .. ' '
            else
                return ' 󰃰 ' .. vim.fn.strftime('%H:%M - %D') .. ' '
            end
        end,
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

local bufferline = {
    offset,
    buffer,
    { provider = "%=" }, -- right align
    time,
    hl = { fg = "primary_bg", bg = "normal_bg" },
}

return bufferline
