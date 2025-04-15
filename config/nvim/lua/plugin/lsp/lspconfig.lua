-- LSP UI
vim.diagnostic.config({
    -- disable virtual text
    virtual_text = true,
    virtual_lines = false,
    -- show signs
    signs = {
    	text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN]  = '',
            [vim.diagnostic.severity.HINT]  = '',
            [vim.diagnostic.severity.INFO]  = '',
    	},
    	numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN]  = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.HINT]  = 'DiagnosticSignHint',
            [vim.diagnostic.severity.INFO]  = 'DiagnosticSignInfo',
        },
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
})

---------------------------------------------------------------------------------------------------

-- Server configuration based on https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
local servers = {
    clangd = {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        capabilities = {
            textDocument = {
                semanHighlighting = true,
            },
            offsetEncoding = { "utf-8" },
        },
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
    },
    lua_ls = {
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
    },
    diagnosticls = {},
    pyright = {},
    cmake = {},
    bashls = {},
    vimls = {
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
    },
}

for server, config in pairs(servers) do
	vim.lsp.config(server, config)
	vim.lsp.enable(server)
end

-- BUG: I don't know what diagnosticls is and what does it do. But vim.lsp.enable() does not work
require("lspconfig").diagnosticls.setup({})

---------------------------------------------------------------------------------------------------

-- Lsp format
local tabwidth = function() return vim.opt.shiftwidth:get() end
require("lsp-format").setup {
    bash   = { tab_width = tabwidth },
    c      = { tab_width = tabwidth },
    cmake  = { tab_width = tabwidth },
    lua    = { tab_width = tabwidth },
    python = { tab_width = tabwidth },
    vim    = { tab_width = tabwidth },
}

---------------------------------------------------------------------------------------------------

-- Auto command
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
    end
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = args.buf })

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = args.buf }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.rename,     bufopts)
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover,      bufopts)
  end,
})
