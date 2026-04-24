vim.keymap.set('n', 'de', vim.diagnostic.open_float)
vim.keymap.set('n', 'db', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'dn', vim.diagnostic.goto_next)
vim.keymap.set('n', 'dq', vim.diagnostic.setloclist)

-- Inlay hints
vim.lsp.inlay_hint.enable(true)

-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
--       vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--       vim.keymap.set('i', '<C-Space>', function()
--         vim.lsp.completion.get()
--       end)
--     end
--   end,
-- })

-- Diagnostics
vim.diagnostic.config({
  virtual_text = {
    prefix = "",
    severity = { min = vim.diagnostic.severity.WARN },
  },
  float = {
    border = "rounded",
    source = true,
    header = '',
    prefix = '',
  },
})

-- Language server configurations

vim.lsp.config('lua_ls', {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".emmyrc.json", ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the 'vim' global
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})
vim.lsp.enable('lua_ls')

vim.lsp.config('clangd', {
  cmd = { 'clangd', '--background-index' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt' },
  filetypes = { 'c', 'cpp', 'proto' }
})
vim.lsp.enable('clangd')

vim.lsp.config('rust_analyzer', {
    settings = {
        ["rust-analyzer"] = {
            cargo = { allFeatures = true }, -- important for dependencies
            checkOnSave = true,
        }
    }
})
vim.lsp.enable('rust_analyzer')

vim.lsp.config('basedpyright', {
  cmd = { 'basedpyright-langserver', '--stdio' },
  root_markers = { 'pyproject.toml', 'setup.py', '.git' },
  filetypes = { 'python' },
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",
      },
    },
  },
})
vim.lsp.enable('basedpyright')

vim.lsp.config('verible', {
  filetypes = { 'verilog', 'systemverilog' },
  cmd = {
    'verible-verilog-ls',
    '--rules_config_search',
    '--rules=-line-length,-no-tabs,-parameter-name-style,-macro-name-style',
  },
})
vim.lsp.enable('verible')
vim.filetype.add({
  extension = {
    v = 'verilog',
    sv = 'systemverilog'
  }
})
