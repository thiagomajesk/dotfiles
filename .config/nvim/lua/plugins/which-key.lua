return {
    name = 'which-key',
    src = 'https://github.com/folke/which-key.nvim',
    setup = {
        delay = 0,
        preset = 'classic',
        icons = { mappings = false },
        win = {
            title = false,
            wo = { winblend = 10 }
        }
    }
}
