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

--- @class indent
local indent = {
    enabled = vim.g.snacks_indent,
    indent = {
        priority = 1,
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
        priority = 200,
        char = "▏",
        underline = false, -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
    },
    chunk = {
        enabled = false,
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
    -- gitbrowse
    indent = indent,
    -- input
    -- lazygit
    -- notifier
    -- notify
    -- profiler
    -- quickfile
    -- rename
    -- scope
    -- scratch
    scroll = scroll,
    -- statuscolum
    -- terminal
    -- toggle
    -- util
    -- win
    -- words
    -- zen
})
