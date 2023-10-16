-- vim.keymap.set('n', '<space>df', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	-- vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
	-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wl', function()
	--    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)
	vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
	-- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	-- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	-- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

	require("lsp-format").on_attach(client)
end

-- LSP format range keymap
vim.keymap.set("x", "<space>f", ":lua require'lsp-range-format'.format()<CR>", { noremap = true, silent = true })

-- icon ⚠
local signs = {
	Error = "",
	Warn = "",
	Hint = "",
	Information = ""
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
--
-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
	-- add any options here, or leave empty to use the default settings
    library = { plugins = { "nvim-dap-ui" }, types = true },
})

vim.diagnostic.config({
	-- disable virtual text
	virtual_text = false,
	-- show signs
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
	width = 60,
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
	width = 60,
})

-- Lsp format
local tabwidth = function() return vim.opt.shiftwidth:get() end
require("lsp-format").setup {
	bash   = { tab_width = tabwidth },
	c      = { tab_width = tabwidth },
	cmake  = { tab_width = tabwidth },
	lua    = { tab_width = tabwidth },
	make   = { tab_width = tabwidth },
	python = { tab_width = tabwidth },
	vim    = { tab_width = tabwidth },
}

-- LSP Common configuration
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
	snippetSupport = true,
	resolveSupport = {
		properties = { "documentation", "detail", "additionalTextEdits" },
	},
}
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = { 'pyright', 'clangd', 'cmake', 'bashls', 'vimls', 'lua_ls', 'diagnosticls' }
for _, lsp in pairs(servers) do
	require('lspconfig')[lsp].setup
	{
		on_attach = on_attach,
		flags = {
			-- This is the default in Nvim 0.7+
			debounce_text_changes = 150,
		},
		capabilities = capabilities,
	}
end

-- LSP specific configuration
-- C
local clangd_capabilities = capabilities
clangd_capabilities.textDocument.semanHighlighting = true
clangd_capabilities.offsetEncoding = "utf-8"
require 'lspconfig'.clangd.setup {
	capabilities = clangd_capabilities,
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	cmd = {
		"clangd",
		"--background-index",
		"--pch-storage=memory",
		"--clang-tidy",
		"--cross-file-rename",
		"--completion-style=detailed",
	},
	init_options = {
		clangdFileStatus = true,
		usePlaceholders = true,
		completeUnimported = true,
		semanticHighlighting = true,
	},
    hint = { enable = true },
}

-- Lua
require 'lspconfig'.lua_ls.setup {
	settings = {
		Lua = {
			diagnostic = {
				-- Get the language server to recognize the `vim` global
				globals = {'vim'},
			},
			workspace = {
				-- Disable neodev modify workspace
				checkThirdParty = false,
			},
            hint = { enable = true },
		},
	},
}

-- Vim
require 'lspconfig'.vimls.setup {
	init_options = {
		diagnostic = {
			enable = true
		},
		indexes = {
			count = 3,
			gap = 100,
			projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
			runtimepath = true
		},
		isNeovim = true,
		iskeyword = "@,48-57,_,192-255,-#",
		runtimepath = "",
		suggest = {
			fromRuntimepath = true,
			fromVimruntime = true
		},
		vimruntime = ""
	}
}
