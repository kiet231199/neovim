local status_ok, cokeline = pcall(require, "cokeline")
if not status_ok then
    print("Error: cokeline")
    return
end

local get_hex = require('cokeline/utils').get_hex

local my_color = {
    focus = {
        fg = "#15161e",
        bg = "#7aa2f7",
    },
    non_focus = {
        fg = "#5c87eb",
        bg = "#3b4261",
    },
    normal = {
        bg = "#13141c",
    },
}

cokeline.setup({
    show_if_buffers_are_at_least = 1,
    buffers = {
        focus_on_delete = 'prev',
        new_buffers_position = 'next',
        delete_on_right_click = true,
    },
    rendering = {
        max_buffer_width = 60,
    },

    default_hl = {
        fg = function(buffer)
            return
                buffer.is_focused
                and my_color.focus.fg
                or my_color.non_focus.fg
        end,
        bg = function(buffer)
            return
                buffer.is_focused
                and my_color.focus.bg
                or my_color.non_focus.bg
        end,
    },

    components = {
        {
            text = '',
            fg = function(buffer)
                return
                    buffer.is_focused
                    and my_color.focus.bg
                    or my_color.non_focus.bg
            end,
            bg = my_color.normal.bg
        },
        {
            text = ' ',
        },
        {
            text = function(buffer)
                return buffer.devicon.icon
            end,
            fg = function(buffer)
                if buffer.is_focused then
                    return my_color.focus.fg
                else
                    return buffer.devicon.color
                end
            end,
        },
        {
            text = ' ',
        },
        {
            text = function(buffer) return buffer.index .. ':' end,
            style = function(buffer)
                return buffer.is_focused and 'bold' or nil
            end,
        },
        {
            text = function(buffer) return buffer.filename end,
            style = function(buffer)
                return buffer.is_focused and 'bold' or nil
            end,
        },
        {
            text = ' ',
        },
        {
            text = function(buffer)
                if buffer.is_modified then
                    return ' ' .. ''
                else
                    return ''
                end
            end,
            style = function(buffer)
                return buffer.is_focused and 'bold' or nil
            end,
        },
        {
            text = ' ',
        },
        {
            text = '',
            on_click = function(_, _, _, _, buffer)
                buffer:delete()
            end,
        },
        {
            text = ' ',
        },
        {
            text = '',
            fg = function(buffer)
                return
                    buffer.is_focused
                    and my_color.focus.bg
                    or my_color.non_focus.bg
            end,
            bg = my_color.normal.bg
        },
        {
            text = ' ',
            bg = my_color.normal.bg,
        },
    },

    rhs = {},

    tabs = {
        placement = "right",
        components = {
            {
                text = ' ',
                bg = my_color.normal.bg,
            },
            {
                text = '',
                fg = my_color.non_focus.bg,
                bg = my_color.normal.bg,
            },
            {
                text = function()
                    local counts = { 0, 0, 0, 0, }
                    for _, d in pairs(vim.diagnostic.get(0)) do
                        counts[d.severity] = counts[d.severity] + 1
                    end
                    if counts[1] ~= 0 then
                        return ' :' .. counts[1] .. ' '
                    else
                        if counts[2] ~= 0 then
                            return ' :' .. counts[2] .. ' '
                        else
                            return ' '
                        end
                    end
                end,
                fg = function()
                    local counts = { 0, 0, 0, 0, }
                    for _, d in pairs(vim.diagnostic.get(0)) do
                        counts[d.severity] = counts[d.severity] + 1
                    end
                    if counts[1] ~= 0 then
                        return get_hex('DiagnosticError', 'fg')
                    else
                        if counts[2] ~= 0 then
                            return get_hex('DiagnosticWarning', 'fg')
                        end
                    end
                end,
            },
            {
                text = '',
                fg = my_color.focus.bg,
                bg = my_color.non_focus.bg,
            },
            {
                text = function()
                    if vim.fn.winwidth(0) > 100 then
                        return ' 󰃰 ' .. vim.fn.strftime('%H:%M - %a, %d/%m/%Y') .. ' '
                    else
                        return ' 󰃰 ' .. vim.fn.strftime('%H:%M - %D') .. ' '
                    end
                end,
                style = 'bold',
                fg = my_color.focus.fg,
                bg = my_color.focus.bg,
            },
            {
                text = '',
                fg = my_color.focus.bg,
                bg = my_color.normal.bg,
            },
        },
    },
})

