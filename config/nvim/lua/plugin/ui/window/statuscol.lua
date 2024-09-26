local status_ok, statuscol = pcall(require, "statuscol")
if not status_ok then
	print("Error: statuscol")
	return
end

local builtin = require("statuscol.builtin")
statuscol.setup({
    setopt = true, -- Whether to set the 'statuscolumn' option, may be set to false for those who
                   -- want to use the click handlers in their own 'statuscolumn': _G.Sc[SFL]a().
                   -- Although I recommend just using the segments field below to build your
                   -- statuscolumn to benefit from the performance optimizations in this plugin.
                   -- builtin.lnumfunc number string options
    thousands = false,  -- or line number thousands separator string ("." / ",")
    relculright = true, -- whether to right-align the cursor line number with 'relativenumber' set
    -- Builtin 'statuscolumn' options
    ft_ignore = nil,   -- Lua table with 'filetype' values for which 'statuscolumn' will be unset
    bt_ignore = nil,   -- Lua table with 'buftype' values for which 'statuscolumn' will be unset
    -- Default segments (fold -> sign -> line number + separator), explained below
    segments = {
        { text = { "%C" }, click = "v:lua.ScFa" },
        { text = { "%s" }, click = "v:lua.ScSa" },
        {
            text = { builtin.lnumfunc, },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
        },
        {
            text = {
				function(args)
					local current_row = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())[1]
					if args.lnum == current_row then
					    return ""
					else
					    return " "
					end
				end,
				" ",
            },
        },
    },
    clickmod = "c", -- modifier used for certain actions in the builtin clickhandlers:
    -- "a" for Alt, "c" for Ctrl and "m" for Meta.
    clickhandlers = { -- builtin click handlers, keys are pattern matched
        Lnum                   = builtin.lnum_click,
        FoldClose              = builtin.foldclose_click,
        FoldOpen               = builtin.foldopen_click,
        FoldOther              = builtin.foldother_click,
        DapBreakpointRejected  = builtin.toggle_breakpoint,
        DapBreakpoint          = builtin.toggle_breakpoint,
        DapBreakpointCondition = builtin.toggle_breakpoint,
        ["diagnostic/signs"]   = builtin.diagnostic_click,
        gitsigns               = builtin.gitsigns_click,
    },
})
