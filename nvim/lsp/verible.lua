return {
  filetypes = { 'verilog', 'systemverilog' },
  cmd = {
    'verible-verilog-ls',
    '--rules_config_search',
    '--rules=-line-length,-no-tabs,-parameter-name-style,-macro-name-style',
  },
}
