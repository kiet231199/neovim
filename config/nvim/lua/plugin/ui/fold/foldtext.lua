local status_ok, foldtext = pcall(require, "foldtext")
if not status_ok then
	print("Error: foldtext")
	return
end

local per = 0.2
foldtext.setup({
	-- Ignore buffers with these buftypes.
    ignore_buftypes = {},
    -- Ignore buffers with these filetypes.
    ignore_filetypes = {},
	styles = {
		default = {
			{
				kind = "indent"
			},
			{
				kind = "section",
				output = function (_, win)
                    local w = vim.api.nvim_win_get_width(win);
                    local off = vim.fn.getwininfo(win)[1].textoff;
                    local rep = (w - off) / 2  * per
                    local text = string.rep("━", math.floor(rep)) .. " "

                    return { { text, "Comment" } }
                end,
				gradient_repeat = true
			},
			{
				kind = "section",
				output = function()
                    return { { " ", "Title" } }
				end,
			},
			{
				kind = "section",
				output = function()
                    return { { " Fold: ", "Title" } }
				end,
			},
			{
				kind = "fold_size",
				hl = "Title"
			},
			{
				kind = "section",
				output = function()
                    return { { " lines ", "Title" } }
				end,
			},
			{
				kind = "section",
				output = function()
					local text = "[" .. vim.v.foldstart .. "   " .. vim.v.foldend .. "]"
					return { { text, "Comment" } }
				end,
			},
			{
				kind = "section",
				output = function()
                    return { { "  ", "Title" } }
				end,
			},
			{
				kind = "section",
				output = function (_, win)
					local w = vim.api.nvim_win_get_width(win);
					local off = vim.fn.getwininfo(win)[1].textoff;
					local rep = (w - off) / 2  * per
					local text = " " .. string.rep("━", math.floor(rep))

					return { { text, "Comment" } }
				end,
				gradient_repeat = true
			},
		},
	},
})
