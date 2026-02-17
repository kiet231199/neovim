-- Load options
require("options")

-- Load autocmd
require("autocmd")

-- Load plugins
require("plugin")

-- Load keymaps
require("utils").load_mappings()

-- Override highlights
require("utils").load_highlights()

-- Load cheatsheet
require("cheatsheet")
