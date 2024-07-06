local status_ok, tinyinlinediagnostic = pcall(require, "tiny-inline-diagnostic")
if not status_ok then
	print("Error: tiny-inline-diagnostic")
	return
end
-- Default configuration
tinyinlinediagnostic.setup({
        signs = {
            left = "",
            right = "",
            diag = " ●",
            arrow = "    ",
            up_arrow = "    ",
            vertical = " │",
            vertical_end = " └"
        },
        hi = {
            error = "DiagnosticError",
            warn = "DiagnosticWarn",
            info = "DiagnosticInfo",
            hint = "DiagnosticHint",
            arrow = "NonText",
            background = "CursorLine", -- Can be a highlight or a hexadecimal color (#RRGGBB)
            mixing_color = "None",  -- Can be None or a hexadecimal color (#RRGGBB). Used to blend the background color with the diagnostic background color with another color.
        },
        blend = {
            factor = 0.27,
        },
        options = {
            -- The minimum length of the message, otherwise it will be on a new line.
            softwrap = 0,

            --- When overflow="wrap", when the message is too long, it is then displayed on multiple lines.
            overflow = "wrap",

            --- Enable it if you want to always have message with `after` characters length.
            break_line = {
                enabled = false,
                after = 30,
            }
        }
})
