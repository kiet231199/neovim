local status_ok, easyread = pcall(require, "easyread")
if not status_ok then
	print("Error: easyread")
	return
end

easyread.setup({
	hlValues = {
		['1'] = 1,
		['2'] = 1,
		['4'] = 2,
		['3'] = 2,
		['fallback'] = 0.2,
	},
	hlgroupOptions = { link = 'Bold' },
	fileTypes = { 'text', 'log' },
	saccadeInterval = 0,
	saccadeReset = false,
	updateWhileInsert = true,
})
