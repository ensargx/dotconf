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
vim.api.nvim_set_keymap('n', '<leader>w,', ':lua split_clean(\'vsplit\')<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>w.', ':lua split_clean(\'split\')<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>wn', ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>wd', ':close<CR>',  { noremap = true, silent = true })

