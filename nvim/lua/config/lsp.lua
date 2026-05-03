vim.lsp.enable('rust_analyzer')
vim.lsp.enable('lua_ls')
vim.lsp.enable('clangd')
vim.lsp.enable('basedpyright')
vim.lsp.enable('buf')
vim.lsp.enable('verible')
vim.filetype.add({
  extension = {
    v = 'verilog',
    sv = 'systemverilog'
  }
})

vim.keymap.set('n', 'dk', vim.diagnostic.open_float)
vim.keymap.set('n', 'dq', vim.diagnostic.setloclist)

vim.keymap.set('n', 'dü', function()
  vim.diagnostic.jump({
    count = 1,
    on_jump = function()
      vim.diagnostic.open_float({ focus = false })
    end
  })
end, { desc = "Sonraki uyarıya git" })

vim.keymap.set('n', 'dğ', function()
  vim.diagnostic.jump({
    count = -1,
    on_jump = function()
      vim.diagnostic.open_float({ focus = false })
    end
  })
end, { desc = "Önceki uyarıya git" })

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
})
