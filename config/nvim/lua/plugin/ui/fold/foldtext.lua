local status_ok, foldtext = pcall(require, "foldtext")
if not status_ok then
	print("Error: foldtext")
	return
end

local per = 0.2
foldtext.setup({
    default = {
		{
			type = "indent"
		},
		{
			type = "raw",
			text = function (win)
				local w = vim.api.nvim_win_get_width(win);
				local off = vim.fn.getwininfo(win)[1].textoff;
				local rep = (w - off) / 2  * per

				return string.rep("━", math.floor(rep)) .. " "
			end,
			hl = "Comment",
			gradient_repeat = true
		},
		{
			type = "raw",
			text = " ",
			hl = "Title"
		},
		{
			type = "raw",
			text = " Fold: ",
			hl = "Title"
		},
		{
			type = "fold_size",
			hl = "Title"
		},
		{
			type = "raw",
			text = " lines ",
			hl = "Title"
		},
		{
			type = "raw",
			text = function()
				return "[" .. vim.v.foldstart .. "   " .. vim.v.foldend .. "]"
			end,
			hl = "Comment",
		},
		{
			type = "raw",
			text = "  ",
			hl = "Title"
		},
		{
			type = "raw",
			text = function (win)
				local w = vim.api.nvim_win_get_width(win);
				local off = vim.fn.getwininfo(win)[1].textoff;
				local rep = (w - off) / 2  * per

				return " " .. string.rep("━", math.floor(rep))
			end,
			hl = "Comment",
			gradient_repeat = true
		},
    },
})
