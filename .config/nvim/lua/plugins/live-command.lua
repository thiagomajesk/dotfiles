return {
  name = 'live-command',
  src = 'https://github.com/smjonas/live-command.nvim',
  setup = function(module)
    module.setup({ commands = { Norm = { cmd = 'norm' } } })
    vim.cmd("cnoreabbrev norm Norm")
  end
}
