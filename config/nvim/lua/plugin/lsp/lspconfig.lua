-- LSP UI
local signs = { Error = "", Warn = "", Hint = "", Information = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

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
        source = true,
        header = "",
        prefix = "",
    },
})

---------------------------------------------------------------------------------------------------

-- LSP Common configuration
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition,      bufopts)
    vim.keymap.set('n', 'gf', vim.lsp.buf.references,      bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'gk', vim.diagnostic.goto_prev,    bufopts)
    vim.keymap.set('n', 'gj', vim.diagnostic.goto_next,    bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.rename,          bufopts)
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover,           bufopts)

    -- Auto format on saving
    -- require("lsp-format").on_attach(client)
end

local handlers = {
    ["textDocument/hover"]         = vim.lsp.with(vim.lsp.handlers.hover, { width = 60, border = "rounded" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { width = 60, border = "rounded" }),
}

local completeionItem = {
    snippetSupport = true,
    resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits" },
    },
}

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
    -- Merge capabilities with blink.cmp
    local capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)

    -- Override capabilities
    capabilities.textDocument.completion.completeionItem = completeionItem

    -- Setup LSP
    require('lspconfig')[server].setup({
        capabilities = capabilities,
        handler      = handlers,
        on_attach    = on_attach,
    })
end

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
