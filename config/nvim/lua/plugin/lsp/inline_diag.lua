local status_ok, tiny_diag = pcall(require, "tiny-inline-diagnostic")
if not status_ok then
	print("Error: tiny-inline-diagnostic")
	return
end

tiny_diag.setup({
    -- Available: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
    preset = "powerline",
    transparent_bg = false,
    transparent_cursorline = true,
    hi = {
        error = "DiagnosticError",     -- Highlight for error diagnostics
        warn = "DiagnosticWarn",       -- Highlight for warning diagnostics
        info = "DiagnosticInfo",       -- Highlight for info diagnostics
        hint = "DiagnosticHint",       -- Highlight for hint diagnostics
        arrow = "NonText",             -- Highlight for the arrow pointing to diagnostic
        background = "CursorLine",     -- Background highlight for diagnostics
        mixing_color = "Normal",       -- Color to blend background with (or "None")
    },
    -- List of filetypes to disable the plugin for
    disabled_ft = {},
    options = {
        show_code = true,
        use_icons_from_diagnostic = true,
        set_arrow_to_diag_color = false,
        throttle = 20,
        softwrap = 30,
        add_messages = {
            messages = true,           -- Show full diagnostic messages
            display_count = false,     -- Show diagnostic count instead of messages when cursor not on line
            use_max_severity = false,  -- When counting, only show the most severe diagnostic
            show_multiple_glyphs = true, -- Show multiple icons for multiple diagnostics of same severity
        },
        multilines = {
            enabled = false,           -- Enable support for multiline diagnostic messages
            always_show = false,       -- Always show messages on all lines of multiline diagnostics
            trim_whitespaces = false,  -- Remove leading/trailing whitespace from each line
            tabstop = 4,               -- Number of spaces per tab when expanding tabs
            severity = nil,            -- Filter multiline diagnostics by severity (e.g., { vim.diagnostic.severity.ERROR })
          },
        show_all_diags_on_cursorline = true,
        show_diags_only_under_cursor = true,
        show_related = {
            enabled = true,           -- Enable displaying related diagnostics
            max_count = 3,             -- Maximum number of related diagnostics to show per diagnostic
        },
        enable_on_insert = false,
        enable_on_select = false,
        overflow = {
            mode = "wrap",             -- "wrap": split into lines, "none": no truncation, "oneline": keep single line
            padding = 2,               -- Extra characters to trigger wrapping earlier
        },
        break_line = {
            enabled = false,           -- Enable automatic line breaking
            after = 30,                -- Number of characters before inserting a line break
        },
    },
})
