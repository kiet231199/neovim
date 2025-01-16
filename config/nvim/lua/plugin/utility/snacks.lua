local snacks_status, snacks = pcall(require, "snacks")
if not snacks_status then
    print("Error: blink")
    return
end

--- @class animate
local animate = {
    enabled = vim.g.animate,
    duration = 20, -- ms per step
    easing = "linear",
    fps = 60, -- frames per second. Global setting for all animations
}

--- @class bigfile
local bigfile = {
    enabled = vim.g.bigfile,
    notify = true, -- show notification when big file detected
    size = 1.5 * 1024 * 1024, -- 1.5MB
}

--- @class notifier
local notifier = {
    enabled = vim.g.notifier,
    timeout = 3000, -- default timeout in ms
    width = { min = 40, max = 0.4 },
    height = { min = 1, max = 0.6 },
    -- editor margin to keep free. tabline and statusline are taken into account automatically
    margin = { top = 0, right = 1, bottom = 0 },
    padding = true, -- add 1 cell of left/right padding to the notification window
    sort = { "level", "added" }, -- sort by level and time
    -- minimum log level to display. TRACE is the lowest
    -- all notifications are stored in history
    level = vim.log.levels.TRACE,
    icons = {
        error = " ",
        warn = " ",
        info = " ",
        debug = " ",
        trace = " ",
    },
    keep = function()
        return vim.fn.getcmdpos() > 0
    end,
    style = "fancy",
    top_down = true, -- place notifications from top to bottom
    date_format = "%R", -- time format for notifications
    -- format for footer when more lines are available
    -- `%d` is replaced with the number of lines.
    -- only works for styles with a border
    ---@type string|boolean
    more_format = " ↓ %d lines ",
    refresh = 50, -- refresh at most every 50ms
}

--- @class indent
local indent = {
    enabled = vim.g.snacks_indent,
    indent = {
        priority = 900,
        enabled = true, -- enable indent guides
        char = "▏",
        only_scope = false, -- only show indent guides of the scope
        only_current = false, -- only show indent guides in the current window
        hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
    },
    -- animate scopes
    animate = {
        enabled = false,
    },
    scope = {
        enabled = true, -- enable highlighting the current scope
        priority = 900,
        char = "▏",
        underline = false, -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
    },
    chunk = {
        enabled = false,
        only_current = false, -- only show chunk scopes in the current window
        priority = 900,
        hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
        char = {
            corner_top = "┌",
            corner_bottom = "└",
            -- corner_top = "╭",
            -- corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = ">",
        },
    },
    blank = {
        char = " ",
        hl = "SnacksIndentBlank", ---@type string|string[] hl group for blank spaces
    },
    -- filter for buffers to enable indent guides
    filter = function(buf)
        return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
    end,
}

--- @class scratch
local scratch = {
    enabled = vim.g.scratch,
    name = "Scratch",
    ft = function()
        if vim.bo.buftype == "" and vim.bo.filetype ~= "" then
            return vim.bo.filetype
        end
        return "markdown"
    end,
    ---@type string|string[]?
    icon = nil, -- `icon|{icon, icon_hl}`. defaults to the filetype icon
    root = vim.fn.stdpath("config") .. "/scratch",
    autowrite = true, -- automatically write when the buffer is hidden
    -- unique key for the scratch file is based on:
    -- * name
    -- * ft
    -- * vim.v.count1 (useful for keymaps)
    -- * cwd (optional)
    -- * branch (optional)
    filekey = {
        cwd = true, -- use current working directory
        branch = true, -- use current branch name
        count = true, -- use vim.v.count1
    },
    win = { style = "scratch" },
    win_by_ft = {
        lua = {
            keys = {
                ["source"] = {
                    "<cr>",
                    function(self)
                        local name = "scratch." .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ":e")
                        require("snacks").debug.run({ buf = self.buf, name = name })
                    end,
                    desc = "Source buffer",
                    mode = { "n", "x" },
                },
            },
        },
    },
}

--- @class snacks_scroll
local scroll = {
    enabled = vim.g.snacks_scroll,
    animate = {
        duration = { step = 15, total = 250 },
        easing = "linear",
    },
    -- faster animation when repeating scroll after delay
    animate_repeat = {
        delay = 100, -- delay in ms before using the repeat animation
        duration = { step = 5, total = 50 },
        easing = "linear",
    },
    -- what buffers to animate
    filter = function(buf)
        return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
    end,
}

snacks.setup({
    animate = animate,
    bigfile = bigfile,
    -- bufdelete
    -- dashboard
    -- debug
    -- dim
    -- git
    -- gitbrowse,
    indent = indent,
    -- input
    -- lazygit
    notifier = notifier,
    -- notify
    -- profiler
    -- quickfile
    -- rename
    -- scope
    scratch = scratch,
    scroll = scroll,
    -- statuscolumn,
    -- terminal
    -- toggle
    -- util
    -- win
    -- words
    -- zen
})

