return {
    name = 'nvim-treesitter.configs',
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    setup = {
        ensure_installed = { 'lua', 'elixir', 'heex', 'html', 'javascript', 'css', 'json', 'markdown' },
        auto_install = true,
        indent = { enable = true },
        highlight = { enable = true },
    }
}
