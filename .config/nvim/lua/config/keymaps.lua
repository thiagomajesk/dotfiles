-- Disable arrow keys on insert mode
vim.keymap.set('i', '<Up>', '<Nop>', { noremap = true, silent = false })
vim.keymap.set('i', '<Down>', '<Nop>', { noremap = true, silent = false })
vim.keymap.set('i', '<Left>', '<Nop>', { noremap = true, silent = false })
vim.keymap.set('i', '<Right>', '<Nop>', { noremap = true, silent = false })

-- Disable arrow keys on normal mode
vim.keymap.set('n', '<Up>', '<Nop>', { noremap = true, silent = false })
vim.keymap.set('n', '<Down>', '<Nop>', { noremap = true, silent = false })
vim.keymap.set('n', '<Left>', '<Nop>', { noremap = true, silent = false })
vim.keymap.set('n', '<Right>', '<Nop>', { noremap = true, silent = false })

-- Keybinds to make split navigation easier (CTRL+<hjkl> to switch between windows)
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Map Ctrl+h/j/k/l to navigate in insert mode
vim.keymap.set('i', '<C-h>', '<Left>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-j>', '<Down>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-k>', '<Up>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-l>', '<Right>', { noremap = true, silent = true })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier to discover
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keymap to move selected block of text vertically
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })

-- Keymap to open the mini.files popup
vim.keymap.set('n', '<leader>e', function()
    require('mini.files').open()
end, { desc = 'Open file [e]xplorer' })

vim.keymap.set('n', '<leader>q', function()
    require('quicker').toggle()
end, { desc = 'Toggle quickfix list' })

vim.keymap.set('n', '<leader>l', function()
    require('quicker').toggle({ loclist = true })
end, { desc = 'Toggle loclist' })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Helpers to copy buffer paths to clipboard
vim.keymap.set('n', '<leader>bp', function()
    vim.fn.setreg('+', vim.fn.expand('%:p:.'))
end, { desc = 'Copy file path' })

vim.keymap.set('n', '<leader>bd', function()
    vim.fn.setreg('+', vim.fn.expand('%:h'))
end, { desc = 'Copy directory path' })

vim.keymap.set('n', '<leader>bf', function()
    vim.fn.setreg('+', vim.fn.expand('%:t:r'))
end, { desc = 'Copy file name' })

-- Format the current buffer
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
