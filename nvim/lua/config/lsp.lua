vim.lsp.enable('lua_ls')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('clangd')

-- LSP completion sırasında TAB ile seçim yapmak
vim.api.nvim_set_keymap('i', '<Tab>', [[pumvisible() ? "\<C-y>" : "\<Tab>"]], {expr = true, noremap = true})
vim.api.nvim_set_keymap('s', '<Tab>', [[pumvisible() ? "\<C-y>" : "\<Tab>"]], {expr = true, noremap = true})

vim.keymap.set('n', 'de', vim.diagnostic.open_float)
vim.keymap.set('n', 'db', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'dn', vim.diagnostic.goto_next)
vim.keymap.set('n', 'dq', vim.diagnostic.setloclist)

-- Inlay hints
vim.lsp.inlay_hint.enable(true)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end)
    end
  end,
})

-- Diagnostics
vim.diagnostic.config({
  virtual_text = {
    prefix = "",
    severity = { min = vim.diagnostic.severity.WARN },
  },
  float = {
    border = "rounded",
    source = "always",
    header = '',
    prefix = '',
  },
})

vim.lsp.config('rust_analyzer', {
    settings = {
        ["rust-analyzer"] = {
            cargo = { allFeatures = true }, -- important for dependencies
            checkOnSave = true,
        }
    }
})
