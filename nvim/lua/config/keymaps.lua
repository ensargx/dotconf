local map = vim.keymap.set

map("n", "<leader>ct", vim.lsp.buf.type_definition, { desc = "Type Definition", noremap = true, silent = true })
map("n", "<leader>ci", vim.lsp.buf.implementation, { desc = "Implementation", noremap = true, silent = true })
map("n", "<leader>cr", vim.lsp.buf.references, { desc = "References", noremap = true, silent = true })
map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", noremap = true, silent = true })
map("n", "<leader>cn", vim.lsp.buf.rename, { desc = "Rename Symbol", noremap = true, silent = true })

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Splitting & Resizing
map("n", "<leader>t,", ":vsplit<CR><C-w>l<CR>", { desc = "Split window vertically" })
map("n", "<leader>t.", ":split<CR><C-w>j<CR>", { desc = "Split window horizontally" })
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines up/down
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
map("v", "ö", "<gv", { desc = "Indent left and reselect" })
map("v", "ç", ">gv", { desc = "Indent right and reselect" })

-- Normal mode mappings
map("n", "<leader>cc", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Function to open file in new tab
local function open_file_in_tab()
  vim.ui.input({ prompt = 'File to open in new tab: ', completion = 'file' }, function(input)
    if input and input ~= '' then
      vim.cmd('tabnew ' .. input)
    end
  end)
end

-- Function to duplicate current tab
local function duplicate_tab()
  local current_file = vim.fn.expand('%:p')
  if current_file ~= '' then
    vim.cmd('tabnew ' .. current_file)
  else
    vim.cmd('tabnew')
  end
end

-- Function to close tabs to the right
local function close_tabs_right()
  local current_tab = vim.fn.tabpagenr()
  local last_tab = vim.fn.tabpagenr('$')

  for i = last_tab, current_tab + 1, -1 do
    vim.cmd(i .. 'tabclose')
  end
end

-- Function to close tabs to the left
local function close_tabs_left()
  local current_tab = vim.fn.tabpagenr()

  for i = current_tab - 1, 1, -1 do
    vim.cmd('1tabclose')
  end
end

-- enhanced keybindings
map('n', '<leader>to', open_file_in_tab, { desc = 'open file in new tab' })
map('n', '<leader>td', duplicate_tab, { desc = 'duplicate current tab' })
-- vim.keymap.set('n', '<leader>tr', close_tabs_right, { desc = 'close tabs to the right' })
-- vim.keymap.set('n', '<leader>tl', close_tabs_left, { desc = 'close tabs to the left' })

-- alternative navigation (more intuitive)
map('n', '<leader>tn', ':tabnew<cr>', { desc = 'new tab' })
map('n', '<leader>tx', ':tabclose<cr>', { desc = 'close tab' })

-- tab moving
map('n', '<leader>tm', ':tabmove<cr>', { desc = 'move tab' })
map('n', '<leader>t>', ':tabmove +1<cr>', { desc = 'move tab right' })
map('n', '<leader>t<', ':tabmove -1<cr>', { desc = 'move tab left' })

-- alt switch tabs
map('n', '<a-h>',  ':tabprevious<cr>', { desc = 'previous tab' })
map('n', '<a-l>', ':tabnext<cr>',     { desc = 'next tab' })

for i = 1, 9 do
  map('n', '<a-' .. i .. '>', ':tabn ' .. i .. '<cr>')
end

-- function to close buffer but keep tab if it's the only buffer in tab
local function smart_close_buffer()
  local buffers_in_tab = #vim.fn.tabpagebuflist()
  if buffers_in_tab > 1 then
    vim.cmd('bdelete')
  else
    -- if it's the only buffer in tab, close the tab
    vim.cmd('tabclose')
  end
end

map('n', '<leader>bd', smart_close_buffer, { desc = 'smart close buffer/tab' })

