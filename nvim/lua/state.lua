local state = {}

state.state = {
	profiles = {},
	current_profile = {
		name = "",
		path = "",
		init = "",
	},
}

function state.set(opts)
	state.state = vim.tbl_deep_extend("force", state.state, opts or {})
end

return state
