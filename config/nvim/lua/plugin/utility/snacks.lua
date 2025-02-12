local snacks_status, snacks = pcall(require, "snacks")
if not snacks_status then
    print("Error: blink")
    return
end

--- @class animate
local animate = {
    enabled = vim.g.snacks_animate,
    duration = 20, -- ms per step
    easing = "linear",
    fps = 60, -- frames per second. Global setting for all animations
}

--- @class dashboard
local dashboard = {
    enabled = vim.g.snacks_dashboard,
    width = 60,
    formats = {
        key = function(item)
            return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
        end,
    },
    preset = {
        pick = "fzf-lua",
        keys = {
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "w", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
    },
    sections = {
        {
            align = "center",
            text = {
                [[
██████╗   ████████╗        ████████╗ ███████╗    ███╗     ████████╗ ██╗   ██╗ ██████╗   ███████╗
██╔═══██╗ ╚════██╔╝        ██╔═════╝ ██╔════╝  ██═══██╗   ╚══██╔══╝ ██║   ██║ ██╔═══██╗ ██╔════╝
██████══╝   ╔██╔═╝  █████╗ ██████╗   █████╗   █████████╗     ██║    ██║   ██║ ██████══╝ █████╗  
██╔══██╗  ╔██╔═╝    ╚════╝ ██╔═══╝   ██╔══╝   ██╔════██║     ██║    ██║   ██║ ██╔══██╗  ██╔══╝  
██║   ██╗ ████████╗        ██║       ███████╗ ██║    ██║     ██║    ╚██████╔╝ ██║   ██╗ ███████╗
╚═╝   ╚═╝ ╚═══════╝        ╚═╝       ╚══════╝ ╚═╝    ╚═╝     ╚═╝     ╚═════╝  ╚═╝   ╚═╝ ╚══════╝
                ]],
                hl = "SnacksDashboardHeader",
            },
            padding = 2,
        },
        { title = "  Ultility", padding = 1 },
        { section = "keys", gap = 0, padding = 2 },
        { title = "  Recent files", padding = 1 },
        { section = "recent_files", limit = 8, padding = 3 },
        {
            align = "center",
            text = {
                [[
██╗   ██╗ ██╗ ███████╗ ████████╗   ███████╗  ██╗   ██╗    ███╗    ███╗   ███╗
██║ ██╔═╝ ██║ ██╔════╝ ╚══██╔══╝   ██║   ██╗ ██║   ██║  ██═══██╗  ████╗ ████║
████══╝   ██║ █████╗      ██║      ██████╔═╝ ████████║ █████████╗ ██╔████╔██║
██╔═██╗   ██║ ██╔══╝      ██║      ██╔═══╝   ██╔═══██║ ██╔════██║ ██║╚██╔╝██║
██║ ╚═██╗ ██║ ███████╗    ██║      ██║       ██║   ██║ ██║    ██║ ██║ ╚═╝ ██║
╚═╝   ╚═╝ ╚═╝ ╚══════╝    ╚═╝      ╚═╝       ╚═╝   ╚═╝ ╚═╝    ╚═╝ ╚═╝     ╚═╝
                ]],
                hl = "SnacksDashboardKey",
            },
        },
        { section = "startup" },
    },
}

--- @class bigfile
local bigfile = {
    enabled = vim.g.snacks_bigfile,
    notify = true, -- show notification when big file detected
    size = 1.5 * 1024 * 1024, -- 1.5MB
}

--- @class explorer
local explorer = {
    enabled = vim.g.snacks_explorer,
    replace_netrw = true,
}

--- @class notifier
local notifier = {
    enabled = vim.g.snacks_notifier,
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

--- @class picker
local picker = {
    enabled = vim.g.snacks_picker,
    prompt = " ",
    sources = {
        explorer = {
            supports_live = true,
            follow_file = true,
            auto_close = false,
            win = {
                list = {
                    keys = {
                        ["<BS>"] = "explorer_up",
                        ["l"] = "confirm",
                        ["h"] = "explorer_close", -- close directory
                        ["a"] = "explorer_add",
                        ["d"] = "explorer_del",
                        ["r"] = "explorer_rename",
                        ["c"] = "explorer_copy",
                        ["m"] = "explorer_move",
                        ["o"] = "explorer_open", -- open with system application
                        ["P"] = "toggle_preview",
                        ["y"] = "explorer_yank",
                        ["u"] = "explorer_update",
                        ["<c-c>"] = "explorer_cd",
                        ["."] = "explorer_focus",
                        ["I"] = "toggle_ignored",
                        ["H"] = "toggle_hidden",
                        ["Z"] = "explorer_close_all",
                        ["]g"] = "explorer_git_next",
                        ["[g"] = "explorer_git_prev",
                    },
                },
            },
        }
    },
    layout = {
        cycle = true,
        --- Use the default layout or vertical if the window is too narrow
        preset = function()
            return vim.o.columns >= 120 and "default" or "vertical"
        end,
    },
    ---@class snacks.picker.matcher.Config
    matcher = {
        fuzzy = true,      -- use fuzzy matching
        smartcase = true,  -- use smartcase
        ignorecase = true, -- use ignorecase
        sort_empty = false, -- sort results when the search string is empty
        filename_bonus = true, -- give bonus for matching file names (last part of the path)
        file_pos = true,   -- support patterns like `file:line:col` and `file:line`
    },
    sort = {
        -- default sort is by score, text length and index
        fields = { "score:desc", "#text", "idx" },
    },
    ui_select = true, -- replace `vim.ui.select` with the snacks picker
    ---@class snacks.picker.formatters.Config
    formatters = {
        file = {
            filename_first = false, -- display filename before the file path
        },
        selected = {
            show_always = false, -- only show the selected column when there are multiple selections
            unselected = true, -- use the unselected icon for unselected items
        },
    },
    ---@class snacks.picker.previewers.Config
    previewers = {
        git = {
            native = false, -- use native (terminal) or Neovim for previewing git diffs and commits
        },
        file = {
            max_size = 1024 * 1024, -- 1MB
            max_line_length = 500, -- max line length
            ft = nil, ---@type string? filetype for highlighting. Use `nil` for auto detect
        },
        man_pager = nil, ---@type string? MANPAGER env to use for `man` preview
    },
    ---@class snacks.picker.jump.Config
    jump = {
        jumplist = true, -- save the current position in the jumplist
        tagstack = false, -- save the current position in the tagstack
        reuse_win = false, -- reuse an existing window if the buffer is already open
    },
    win = {
        -- input window
        input = {
            keys = {
                ["<Esc>"] = "close",
                ["<CR>"] = { "confirm", mode = { "n", "i" } },
                ["G"] = "list_bottom",
                ["gg"] = "list_top",
                ["j"] = "list_down",
                ["k"] = "list_up",
                ["/"] = "toggle_focus",
                ["q"] = "close",
                ["?"] = "toggle_help",
                ["<a-i>"] = { "inspect", mode = { "n", "i" } },
                ["<c-a>"] = { "select_all", mode = { "n", "i" } },
                ["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },
                ["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
                ["<C-Up>"] = { "history_back", mode = { "i", "n" } },
                ["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
                ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
                ["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
                ["<Down>"] = { "list_down", mode = { "i", "n" } },
                ["<Up>"] = { "list_up", mode = { "i", "n" } },
                ["<c-j>"] = { "list_down", mode = { "i", "n" } },
                ["<c-k>"] = { "list_up", mode = { "i", "n" } },
                ["<c-n>"] = { "list_down", mode = { "i", "n" } },
                ["<c-p>"] = { "list_up", mode = { "i", "n" } },
                ["<a-h>"] = { "preview_scroll_left", mode = { "i", "n" } },
                ["<a-l>"] = { "preview_scroll_right", mode = { "i", "n" } },
                ["<a-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
                ["<a-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
                ["<a-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
                ["<c-d>"] = { "list_scroll_down", mode = { "i", "n" } },
                ["<a-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
                ["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
                ["<c-u>"] = { "list_scroll_up", mode = { "i", "n" } },
                ["<ScrollWheelDown>"] = { "list_scroll_wheel_down", mode = { "i", "n" } },
                ["<ScrollWheelUp>"] = { "list_scroll_wheel_up", mode = { "i", "n" } },
                ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
                ["<c-s>"] = { "edit_split", mode = { "i", "n" } },
                ["<c-q>"] = { "qflist", mode = { "i", "n" } },
            },
            b = {
                minipairs_disable = true,
            },
        },
        -- result list window
        list = {
            keys = {
                ["<CR>"] = "confirm",
                ["gg"] = "list_top",
                ["G"] = "list_bottom",
                ["i"] = "focus_input",
                ["j"] = "list_down",
                ["k"] = "list_up",
                ["q"] = "close",
                ["<Tab>"] = "select_and_next",
                ["<S-Tab>"] = "select_and_prev",
                ["<Down>"] = "list_down",
                ["<Up>"] = "list_up",
                ["<a-i>"] = "inspect",
                ["<c-d>"] = "list_scroll_down",
                ["<c-u>"] = "list_scroll_up",
                ["zt"] = "list_scroll_top",
                ["zb"] = "list_scroll_bottom",
                ["zz"] = "list_scroll_center",
                ["/"] = "toggle_focus",
                ["<ScrollWheelDown>"] = "list_scroll_wheel_down",
                ["<ScrollWheelUp>"] = "list_scroll_wheel_up",
                ["<c-a>"] = "select_all",
                ["<a-d>"] = "preview_scroll_down",
                ["<a-u>"] = "preview_scroll_up",
                ["<a-j>"] = "preview_scroll_down",
                ["<a-k>"] = "preview_scroll_up",
                ["<a-h>"] = "preview_scroll_right",
                ["<a-l>"] = "preview_scroll_left",
                ["<c-v>"] = "edit_vsplit",
                ["<c-s>"] = "edit_split",
                ["<c-j>"] = "list_down",
                ["<c-k>"] = "list_up",
                ["<Esc>"] = "close",
            },
        },
        -- preview window
        preview = {
            keys = {
                ["<Esc>"] = "close",
                ["q"] = "close",
                ["i"] = "focus_input",
                ["<ScrollWheelDown>"] = "list_scroll_wheel_down",
                ["<ScrollWheelUp>"] = "list_scroll_wheel_up",
            },
        },
    },
    ---@class snacks.picker.icons
    icons = {
        files = {
            enabled = true, -- show file icons
        },
        indent = {
            vertical = "│ ",
            middle   = "├╴",
            last     = "└╴",
        },
        undo = {
            saved = " ",
        },
        ui = {
            live       = "󰐰 ",
            hidden     = "h",
            ignored    = "i",
            follow     = "f",
            selected   = "● ",
            unselected = "○ ",
            -- selected = " ",
        },
        git = {
            enabled   = true,
            commit    = "󰜘 ",
            staged    = "● ",  -- staged changes. always overrides the type icons
            added     = " ",
            deleted   = " ",
            ignored   = " ",
            modified  = " ",
            renamed   = " ",
            unmerged  = " ",
            untracked = "? ",
        },
        diagnostics = {
            Error = " ",
            Warn  = " ",
            Hint  = " ",
            Info  = " ",
        },
        kinds = {
            Array         = " ",
            Boolean       = "󰨙 ",
            Class         = " ",
            Color         = " ",
            Control       = " ",
            Collapsed     = " ",
            Constant      = "󰏿 ",
            Constructor   = " ",
            Copilot       = " ",
            Enum          = " ",
            EnumMember    = " ",
            Event         = " ",
            Field         = " ",
            File          = " ",
            Folder        = " ",
            Function      = "󰊕 ",
            Interface     = " ",
            Key           = " ",
            Keyword       = " ",
            Method        = "󰊕 ",
            Module        = " ",
            Namespace     = "󰦮 ",
            Null          = " ",
            Number        = "󰎠 ",
            Object        = " ",
            Operator      = " ",
            Package       = " ",
            Property      = " ",
            Reference     = " ",
            Snippet       = "󱄽 ",
            String        = " ",
            Struct        = "󰆼 ",
            Text          = " ",
            TypeParameter = " ",
            Unit          = " ",
            Unknown       = " ",
            Value         = " ",
            Variable      = "󰀫 ",
        },
    },
    ---@class snacks.picker.debug
    debug = {
        scores = false, -- show scores in the list
        leaks = false, -- show when pickers don't get garbage collected
    },
}

--- @class scratch
local scratch = {
    enabled = vim.g.snacks_scratch,
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
    dashboard = dashboard,
    -- debug
    -- dim
    explorer = explorer,
    -- git
    -- gitbrowse,
    indent = indent,
    -- input
    -- lazygit
    notifier = notifier,
    -- notify
    -- profiler
    picker = picker,
    -- quickfile
    -- rename
    -- scope
    scratch = scratch,
    scroll = scroll,
    -- statuscolumn,
    -- terminal,
    -- toggle
    -- util
    -- win
    -- words
    -- zen
})

