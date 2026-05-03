return {
  -- Command and arguments to start the server.
  cmd = { 'buf', 'lsp', 'serve' },
  -- Filetypes to automatically attach to.
  filetypes = { 'proto', 'buf-config' },
  -- Set the workspace for the LSP to the directory of the first matching file.
  root_markers = { 'buf.yaml', '.git' },
}
