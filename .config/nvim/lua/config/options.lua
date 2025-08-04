-- Enable Nerd Font support
vim.g.have_nerd_font = true

-- Disable netrw so it doesn't open by default
-- Also prevents mini.files from opening on directories
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.termguicolors = true

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

-- Remove tilde char as a filler for empty docs
vim.opt.fillchars:append { eob = " " }

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

--
-- Indentation settings
--
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.tabstop = 2           -- Display tabs as 2 spaces
vim.opt.shiftwidth = 2        -- Use 2 spaces for indentation
vim.opt.softtabstop = 2       -- Make backspace treat 2 spaces as a tab
vim.opt.autoindent = true     -- Copy indent from current line
vim.opt.smartindent = true    -- Smart indentation for programming
vim.opt.smarttab = true       -- Smart tab behavior
vim.opt.shiftround = true     -- Round indent to multiple of shiftwidth
vim.opt.breakindent = true    -- Maintain indent when wrapping lines
