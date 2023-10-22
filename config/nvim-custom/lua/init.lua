-- Load options
require("options")

-- Load autocmd
require("autocmd")

-- Load plugins
require("plugin")

-- Load users define functions
require("udf")

-- Load keymaps
require("utils").load_mappings()

-- Override highlights
require("utils").load_highlights()
