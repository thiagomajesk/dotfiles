-- ------------------------------------------------------------------------
-- PLUGINS
-- ------------------------------------------------------------------------
vim.pack.add {
  { src = 'https://github.com/catppuccin/nvim' },
  { src = 'https://github.com/echasnovski/mini-git' },
  { src = 'https://github.com/echasnovski/mini.ai' },
  { src = 'https://github.com/echasnovski/mini.comment' },
  { src = 'https://github.com/echasnovski/mini.completion' },
  { src = 'https://github.com/echasnovski/mini.diff' },
  { src = 'https://github.com/echasnovski/mini.files' },
  { src = 'https://github.com/echasnovski/mini.surround' },
  { src = 'https://github.com/folke/which-key.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/NMAC427/guess-indent.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
  { src = 'https://github.com/stevearc/quicker.nvim' }
}

-- ------------------------------------------------------------------------
-- SETUP
-- ------------------------------------------------------------------------

-- Theme
require('catppuccin').setup({
  flavour = 'mocha',
  no_italic = true,
  term_colors = true,
  transparent_background = true
})

vim.cmd.colorscheme('catppuccin')

-- Guess indent
require('guess-indent').setup()

-- Mini AI (Around/ Inside)
require('guess-indent').setup()

-- Mini Surround
require('mini.surround').setup()

-- Mini Comment
require('mini.comment').setup()

-- Mini Completion
require('mini.completion').setup()

-- Mini Git
require('mini.git').setup()

-- Mini Diff
require('mini.diff').setup({
  view = { signs = { add = "+", change = "~", delete = "-" } }
})

-- Mini Files
require('mini.files').setup({
  options = { use_as_default_explorer = false }
})

-- Lualine
require('lualine').setup({
  options = {
    theme = 'catppuccin',
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
})

-- Quicker (Quickfix QoL)
require("quicker").setup({
  keys = {
    {
      "+",
      function()
        require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
      end,
      desc = "Expand quickfix context",
    },
    {
      "-",
      function()
        require("quicker").collapse()
      end,
      desc = "Collapse quickfix context",
    },
  },
})

-- Telescope
require('telescope').setup()

-- Which Key
require('which-key').setup({
  delay = 0,
  preset = 'classic',
  icons = { mappings = false },
  win = {
    title = false,
    border = "rounded",
    wo = { winblend = 0 }
  }
})

-- Treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'lua', 'elixir', 'heex', 'html', 'javascript', 'css', 'json', 'markdown' },
  auto_install = true,
  indent = { enable = true },
  highlight = { enable = true },
})

-- Elixir Language Server
local elixirls_path = vim.fn.trim(vim.fn.system("which elixir-ls"))
vim.lsp.config('elixirls', { cmd = { elixirls_path } })

vim.lsp.enable('elixirls')

-- ------------------------------------------------------------------------
-- OPTIONS
-- ------------------------------------------------------------------------

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable Nerd Font support
vim.g.have_nerd_font = true

vim.opt.termguicolors = true

-- Disable netrw so it doesn't open by default
-- Also prevents mini.files from opening on directories
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Transparency effects
-- vim.opt.winblend = 10
-- vim.opt.pumblend = 10

-- Show line numbers
vim.opt.number = true

-- Enable mouse mode (useful for resizing splits)
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live
vim.opt.inccommand = 'split'

-- Show which line the cursor is on
vim.opt.cursorline = true

-- Enable relative line numbers
vim.opt.relativenumber = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Raise a dialog asking if the current file(s) should be saved when
-- performing an operation that would fail due to unsaved changes in the buffer
vim.opt.confirm = true

-- ------------------------------------------------------------------------
-- KEYMAP
-- ------------------------------------------------------------------------

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

-- ------------------------------------------------------------------------
-- UTILITIES
-- ------------------------------------------------------------------------

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Sync clipboard between OS and Neovim.
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

-- Basic configuration to show LSP diagnostics
-- Holding off to see the need to use trouble.nvim
vim.diagnostic.config(
  {
    underline = false,
    severity_sort = true,
    update_in_insert = false,
    virtual_text = { spacing = 2, prefix = "●" },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = " ",
        [vim.diagnostic.severity.INFO] = " ",
      },
    },
  }
)
