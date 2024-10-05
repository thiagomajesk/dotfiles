-- ------------------------------------------------------------------------
-- PLUGIN MANAGER
-- Note: https://github.com/echasnovski/mini.deps
-- ------------------------------------------------------------------------

local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'

if not (vim.uv or vim.loop).fs_stat(mini_path) then
  vim.cmd('echo "Installing mini.nvim" | redraw')
  local mini_repo = 'https://github.com/echasnovski/mini.nvim'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', mini_repo, mini_path })
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed mini.nvim" | redraw')
end

require('mini.deps').setup({ path = { package = path_package } })

-- ------------------------------------------------------------------------
-- PLUGINS
-- ------------------------------------------------------------------------

MiniDeps.add({ source = 'echasnovski/mini.icons', checkout = 'stable' })
MiniDeps.add({ source = 'echasnovski/mini.comment', checkout = 'stable' })
MiniDeps.add({ source = 'echasnovski/mini.indentscope', checkout = 'stable' })

MiniDeps.add({ source = 'tpope/vim-sleuth', checkout = 'stable' })
MiniDeps.add({ source = 'folke/which-key.nvim', checkout = 'stable' })
MiniDeps.add({ source = 'nvim-lualine/lualine.nvim', checkout = 'master', depends = { 'mini.icons' } })
MiniDeps.add({ source = 'catppuccin/nvim', checkout = 'stable' })

-- ------------------------------------------------------------------------
-- PLUGIN SETUP
-- ------------------------------------------------------------------------

require('mini.icons').setup()
require('mini.comment').setup()
require('mini.indentscope').setup()

require('which-key').setup({ icons = { mappings = false } })
require('lualine').setup()
require('catppuccin').setup({ transparent_background = true })

vim.cmd.colorscheme('catppuccin-mocha')
-- ------------------------------------------------------------------------
-- OPTIONS
-- ------------------------------------------------------------------------

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.relativenumber = true

-- ------------------------------------------------------------------------
-- KEYMAP
-- ------------------------------------------------------------------------

-- Disable arrow keys
vim.api.nvim_set_keymap('i', '<Up>', '<Nop>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('i', '<Down>', '<Nop>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('i', '<Left>', '<Nop>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('i', '<Right>', '<Nop>', { noremap = true, silent = false })

vim.api.nvim_set_keymap('n', '<Up>', '<Nop>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<Down>', '<Nop>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', { noremap = true, silent = false })

-- Map Ctrl+h/j/k/l to navigate in insert mode
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', { noremap = true, silent = true })

-- Keybinds to make split navigation easier (CTRL+<hjkl> to switch between windows)
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- ------------------------------------------------------------------------
-- UTILITIES
-- ------------------------------------------------------------------------

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- Sync clipboard between OS and Neovim.
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)
