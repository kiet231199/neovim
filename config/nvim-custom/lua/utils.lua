local utils = {}
local merge_tb = vim.tbl_deep_extend

utils.load_config = function()
	local config = {}

	-- initial default config
	config.plugins = {}
	config.mappings = require("mappings")
	config.highlights = require("highlights")

	config.mappings.disabled = nil
	return config
end

utils.remove_disabled_keys = function(custom_mappings, default_mappings)
	if not custom_mappings then
		return default_mappings
	end

	-- store keys in a array with true value to compare
	local keys_to_disable = {}
	for _, mappings in pairs(custom_mappings) do
		for mode, section_keys in pairs(mappings) do
			if not keys_to_disable[mode] then
				keys_to_disable[mode] = {}
			end
			section_keys = (type(section_keys) == "table" and section_keys) or {}
			for k, _ in pairs(section_keys) do
				keys_to_disable[mode][k] = true
			end
		end
	end

	-- make a copy as we need to modify default_mappings
	for section_name, section_mappings in pairs(default_mappings) do
		for mode, mode_mappings in pairs(section_mappings) do
			mode_mappings = (type(mode_mappings) == "table" and mode_mappings) or {}
			for k, _ in pairs(mode_mappings) do
				-- if key if found then remove from default_mappings
				if keys_to_disable[mode] and keys_to_disable[mode][k] then
					default_mappings[section_name][mode][k] = nil
				end
			end
		end
	end

	return default_mappings
end

utils.load_mappings = function(section, mapping_opt)
	vim.schedule(function()
		local function set_section_map(section_values)
			if section_values.plugin then
				return
			end
			section_values.plugin = nil

			for mode, mode_values in pairs(section_values) do
				local default_opts = merge_tb("force", { mode = mode }, mapping_opt or {})
				for keybind, mapping_info in pairs(mode_values) do
					-- merge default + user opts
					local opts = merge_tb("force", default_opts, mapping_info.opts or {})

					mapping_info.opts, opts.mode = nil, nil
					opts.desc = mapping_info[2]

					vim.keymap.set(mode, keybind, mapping_info[1], opts)
				end
			end
		end

		local mappings = require("utils").load_config().mappings

		if type(section) == "string" then
			mappings[section]["plugin"] = nil
			mappings = { mappings[section] }
		end

		for _, sect in pairs(mappings) do
			set_section_map(sect)
		end
	end)
end

-- merge default/user plugin tables
utils.merge_plugins = function(default_plugins)
	local plugin_configs = utils.load_config().plugins
	local user_plugins = plugin_configs

	-- old plugin syntax for adding plugins
	if plugin_configs.user and type(plugin_configs.user) == "table" then
		user_plugins = plugin_configs.user
	end

	-- support old plugin removal syntax
	local remove_plugins = plugin_configs.remove
	if type(remove_plugins) == "table" then
		for _, v in ipairs(remove_plugins) do
			default_plugins[v] = nil
		end
	end

	default_plugins = merge_tb("force", default_plugins, user_plugins)

	local final_table = {}

	for key, val in pairs(default_plugins) do
		if val and type(val) == "table" then
			default_plugins[key] = val.rm_default_opts and user_plugins[key] or default_plugins[key]
			default_plugins[key][1] = key
			final_table[#final_table + 1] = default_plugins[key]
		end
	end

	return final_table
end

-- override plugin options table with custom ones
utils.load_override = function(options_table, name)
	local plugin_configs, plugin_options = utils.load_config().plugins, nil

	-- support old plugin syntax for override
	local user_override = plugin_configs.override and plugin_configs.override[name]
	if user_override and type(user_override) == "table" then
		plugin_options = user_override
	end

	-- if no old style plugin override is found, then use the new syntax
	if not plugin_options and plugin_configs[name] then
		local override_options = plugin_configs[name].override_options or {}
		if type(override_options) == "table" then
			plugin_options = override_options
		elseif type(override_options) == "function" then
			plugin_options = override_options()
		end
	end

	-- make sure the plugin options are a table
	plugin_options = type(plugin_options) == "table" and plugin_options or {}

	return merge_tb("force", options_table, plugin_options)
end

utils.load_highlights = function()
	local highlights = require("utils").load_config().highlights

	if type(highlights) == "table" then
		for _, options_table in pairs(highlights) do
			for name, options in pairs(options_table) do
				vim.api.nvim_set_hl(0, name, options)
			end
		end
	end
end

return utils
