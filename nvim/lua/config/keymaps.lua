local map = vim.keymap.set

map("n", "<leader>ct", vim.lsp.buf.type_definition, { desc = "Type Definition", noremap = true, silent = true })
map("n", "<leader>ci", vim.lsp.buf.implementation, { desc = "Implementation", noremap = true, silent = true })
map("n", "<leader>cr", vim.lsp.buf.references, { desc = "References", noremap = true, silent = true })
map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", noremap = true, silent = true })
map("n", "<leader>cn", vim.lsp.buf.rename, { desc = "Rename Symbol", noremap = true, silent = true })

vim.keymap.del("n", "gcc")

