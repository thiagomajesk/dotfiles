require('loader').setup('plugins')

require('config.options')
require('config.keymaps')
require('config.utilities')

-- Custom theme configuration
require('theme').setup({ transparent = true })

-- Elixir Language Server
local elixirls_path = vim.fn.trim(vim.fn.system("which elixir-ls"))
vim.lsp.config('elixirls', { cmd = { elixirls_path } })

vim.lsp.enable('elixirls')

-- vim.cmd.colorscheme 'kanagawa'

-- Create a command to cleanup inactive plugins
vim.api.nvim_create_user_command("LoaderCleanup", function()
    require("loader").cleanup()
end, { desc = "Remove inactive plugins" })
