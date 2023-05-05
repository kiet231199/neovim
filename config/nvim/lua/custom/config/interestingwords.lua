local status_ok, interestingwords = pcall(require, "interestingwords")
if not status_ok then
	print("Error: interestingwords")
	return
end

interestingwords.setup({
	colors = { '#aeee00', '#ff0000', '#0000ff', '#b88823', '#ffa724', '#ff2c4b' },
	search_count = false,
	navigation = false,
	search_key = "<space>n",
	cancel_search_key = "<space>N",
	color_key = "<space>m",
	cancel_color_key = "<space>M",
})
