vim.cmd("set langmenu=en_US")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set signcolumn=number")
vim.cmd("set clipboard+=unnamedplus") -- copy to system clipboard
vim.cmd("set noequalalways") -- disable split window resize 
vim.g.mapleader = " "

-- Creates a new split window
function split_clean(cmd)
    vim.cmd(cmd)
    vim.cmd('wincmd w')
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_set_current_buf(buf)
end

function _G.goto_tab(tab_num)
    local function print_error(message)
        print(message)
    end

    -- Check if the tab_num is a number
    if type(tab_num) ~= "number" then
        return print_error("Invalid input: Tab number must be a number.")
    end

    local tab_count = vim.fn.tabpagenr('$')

    -- Check if the specified tab exists
    if tab_num > tab_count then
        return print_error("Tab does not exist.")
    end

    -- Switch to the specified tab
    vim.cmd('tabnext ' .. tab_num)
end

-- Mapping for <C-w> followed by a number
for i = 1, 9 do
    vim.api.nvim_set_keymap('n', '<leader>w' .. i, ':lua goto_tab(' .. i .. ')<CR>', { noremap = true, silent = true })
end

-- Set split window re-maps
vim.api.nvim_set_keymap('n', '<leader>,', ':lua split_clean(\'vsplit\')<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>.', ':lua split_clean(\'split\')<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>c', ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>d', ':close<CR>',  { noremap = true, silent = true })

-- Set mapping for resizing
vim.api.nvim_set_keymap('n', '<leader>h', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', ':resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', ':resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', ':vertical resize +2<CR>', { noremap = true, silent = true })

-- Set leader key mappings for window navigation
vim.api.nvim_set_keymap("n", "<leader><Up>", ":wincmd k<CR>", { noremap = true, silent = true })   -- Move up
vim.api.nvim_set_keymap("n", "<leader><Down>", ":wincmd j<CR>", { noremap = true, silent = true }) -- Move down
vim.api.nvim_set_keymap("n", "<leader><Left>", ":wincmd h<CR>", { noremap = true, silent = true }) -- Move left
vim.api.nvim_set_keymap("n", "<leader><Right>", ":wincmd l<CR>", { noremap = true, silent = true }) -- Move right

-- Create a mapping for <leader>T to move the current window to a new tab
vim.api.nvim_set_keymap("n", "<leader>T", "<C-w>T", { noremap = true, silent = true })

