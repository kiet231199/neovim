local api = {}

api.getLargestWin = function()
	local largest_win_width = 0
	local largest_win_id = 0

	for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		local tmp_width = vim.api.nvim_win_get_width(winid)

		if tmp_width > largest_win_width then
			largest_win_width = tmp_width
			largest_win_id = winid
		end
	end

	return largest_win_id
end

api.isValid_mapping_TB = function(tbl)
	if type(tbl) ~= "table" or #vim.tbl_keys(tbl) == 0 then
		return false
	end

	return true
end

api.bufilter = function()
	local bufs = vim.t.bufs or nil

	if not bufs then
		return {}
	end

	for i, nr in ipairs(bufs) do
		if not vim.api.nvim_buf_is_valid(nr) then
			table.remove(bufs, i)
		end
	end

	vim.t.bufs = bufs
	return bufs
end

api.getBufIndex = function(bufnr)
	for i, value in ipairs(api.bufilter()) do
		if value == bufnr then
			return i
		end
	end
end

api.close_buffer = function(bufnr)
	if vim.bo.buftype == "terminal" then
		vim.cmd(vim.bo.buflisted and "set nobl | enew" or "hide")
	else
		if not vim.t.bufs then
			vim.cmd "bd"
			return
		end

		bufnr = bufnr or vim.api.nvim_get_current_buf()
		local curBufIndex = api.getBufIndex(bufnr)
		local bufhidden = vim.bo.bufhidden

		-- force close floating wins
		if bufhidden == "wipe" then
			vim.cmd "bw"
			return

			-- handle listed bufs
		elseif curBufIndex and #vim.t.bufs > 1 then
			local newBufIndex = curBufIndex == #vim.t.bufs and -1 or 1
			vim.cmd("b" .. vim.t.bufs[curBufIndex + newBufIndex])

			-- handle unlisted
		elseif not vim.bo.buflisted then
			local tmpbufnr = vim.t.bufs[1]

			if vim.g.nv_previous_buf and vim.api.nvim_buf_is_valid(vim.g.nv_previous_buf) then
				tmpbufnr = vim.g.nv_previous_buf
			end

			vim.cmd("b" .. tmpbufnr .. " | bw" .. bufnr)
			return
		else
			vim.cmd "enew"
		end

		if not (bufhidden == "delete") then
			vim.cmd("confirm bd" .. bufnr)
		end
	end

	vim.cmd "redrawtabline"
end

return api
