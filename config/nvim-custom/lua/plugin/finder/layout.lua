local api = {}

api.get_layout = function(picker)
    local border = {
        results = {
            top_left = "┌",
            top = "─",
            top_right = "┬",
            right = "│",
            bottom_right = "",
            bottom = "",
            bottom_left = "",
            left = "│",
        },
        results_patch = {
            minimal = {
                top_left = "┌",
                top_right = "┐",
            },
            horizontal = {
                top_left = "┌",
                top_right = "┬",
            },
            vertical = {
                top_left = "├",
                top_right = "┤",
            },
        },
        prompt = {
            top_left = "├",
            top = "─",
            top_right = "┤",
            right = "│",
            bottom_right = "┘",
            bottom = "─",
            bottom_left = "└",
            left = "│",
        },
        prompt_patch = {
            minimal = {
                bottom_right = "┘",
            },
            horizontal = {
                bottom_right = "┴",
            },
            vertical = {
                bottom_right = "┘",
            },
        },
        preview = {
            top_left = "┌",
            top = "─",
            top_right = "┐",
            right = "│",
            bottom_right = "┘",
            bottom = "─",
            bottom_left = "└",
            left = "│",
        },
        preview_patch = {
            minimal = {},
            horizontal = {
                bottom = "─",
                bottom_left = "",
                bottom_right = "┘",
                left = "",
                top_left = "",
            },
            vertical = {
                bottom = "",
                bottom_left = "",
                bottom_right = "",
                left = "│",
                top_left = "┌",
            },
        },
    }
    -- Layout config for results
    local results = require("nui.popup")({
        focusable = false,
        border = {
            style = border.results,
            text = {
                top = picker.results_title,
                top_align = "center",
            },
        },
        win_options = {
            winhighlight = "Normal:Normal",
        },
    })
    -- Layout config for prompt
    local prompt = require("nui.popup")({
        enter = true,
        border = {
            style = border.prompt,
            text = {
                top = picker.prompt_title,
                top_align = "center",
            },
        },
        win_options = {
            winhighlight = "Normal:Normal",
        },
    })
    -- Layout config for preview
    local preview = require("nui.popup")({
        focusable = false,
        border = {
            style = border.preview,
            text = {
                top = picker.preview_title,
                top_align = "center",
            },
        },
    })
    -- Change layout by size
    local box_by_kind = {
        vertical = require("nui.layout").Box({
            require("nui.layout").Box(preview, { grow = 1 }),
            require("nui.layout").Box(results, { grow = 1 }),
            require("nui.layout").Box(prompt, { size = 3 }),
        }, { dir = "col" }),
        horizontal = require("nui.layout").Box({
            require("nui.layout").Box({
                require("nui.layout").Box(results, { grow = 1 }),
                require("nui.layout").Box(prompt, { size = 3 }),
            }, { dir = "col", size = "50%" }),
            require("nui.layout").Box(preview, { size = "50%" }),
        }, { dir = "row" }),
        minimal = require("nui.layout").Box({
            require("nui.layout").Box(results, { grow = 1 }),
            require("nui.layout").Box(prompt, { size = 3 }),
        }, { dir = "col" }),
    }
    -- Utilities
    local function get_box()
        local height, width = vim.o.lines, vim.o.columns
        local box_kind = "horizontal"
        if width < 100 then
            box_kind = "vertical"
            if height < 40 then
                box_kind = "minimal"
            end
        elseif width < 120 then
            box_kind = "minimal"
        end
        return box_by_kind[box_kind], box_kind
    end
    local function prepare_layout_parts(layout, box_type)
        layout.results = require("telescope.pickers.layout").Window(results)
        results.border:set_style(border.results_patch[box_type])

        layout.prompt = require("telescope.pickers.layout").Window(prompt)
        prompt.border:set_style(border.prompt_patch[box_type])

        if box_type == "minimal" then
            layout.preview = nil
        else
            layout.preview = require("telescope.pickers.layout").Window(preview)
            preview.border:set_style(border.preview_patch[box_type])
        end
    end
    local box, box_kind = get_box()
    local layout = require("nui.layout")({
        relative = "editor",
        position = "50%",
        size = {
            height = "60%",
            width = "90%",
        },
    }, box)
    layout.picker = picker

    prepare_layout_parts(layout, box_kind)
    local layout_update = layout.update
    function layout:update()
        local box, box_kind = get_box()
        prepare_layout_parts(layout, box_kind)
        layout_update(box)
    end

    return layout
end

return api

