local status_ok, gitgraph = pcall(require, "gitgraph")
if not status_ok then
	print("Error: gitgraph")
	return
end

gitgraph.setup({
	symbols = {
		merge_commit = '●',
		commit = '○',
		merge_commit_end = '●',
		commit_end = '○',

		-- Advanced symbols
		GVER = '│',
		GHOR = '─',
		GCLD = '╮',
		GCRD = '╭',
		GCLU = '╯',
		GCRU = '╰',
		GLRU = '┴',
		GLRD = '┬',
		GLUD = '┤',
		GRUD = '├',
		GFORKU = '┼',
		GFORKD = '┼',
		GRUDCD = '├',
		GRUDCU = '├',
		GLUDCD = '┤',
		GLUDCU = '┤',
		GLRDCL = '┬',
		GLRDCR = '┬',
		GLRUCL = '┴',
		GLRUCR = '┴',
	},
	hooks = {
		-- Check diff of a commit
		on_select_commit = function(commit)
			vim.notify('DiffviewOpen ' .. commit.hash .. '^!')
			vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
		end,
		-- Check diff from commit a -> commit b
		on_select_range_commit = function(from, to)
			vim.notify('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
			vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
		end,
	},
	format = {
		timestamp = '(%A, %d-%m-%Y)',
		fields = { 'hash', 'author', 'timestamp', 'branch_name', 'tag', 'message' },
	},
})
