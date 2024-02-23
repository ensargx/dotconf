return {{
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
        require("mason").setup()
    end
},
{
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
        auto_install = true
    },
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = { "pyright", "clangd" }
        })
    end
},
{
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
        local lspconfig = require("lspconfig"),
        vim.keymap.set('n', 'de', vim.diagnostic.open_float)
        vim.keymap.set('n', 'db', vim.diagnostic.goto_prev)
        vim.keymap.set('n', 'dn', vim.diagnostic.goto_next)
        vim.keymap.set('n', 'dq', vim.diagnostic.setloclist)

        lspconfig.pyright.setup({})
        lspconfig.clangd.setup({})

        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', 'gh', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<leader>df', function()
              vim.lsp.buf.format { async = true }
            end, opts)
          end,
        })

    end
}
}
