return {
    {
        name = 'nvim-treesitter',
        src = 'https://github.com/nvim-treesitter/nvim-treesitter',
        setup = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { 'lua', 'elixir', 'heex', 'html', 'javascript', 'css', 'json', 'markdown' },
                auto_install = true,
                indent = { enable = true },
                highlight = { enable = true }
            })
        end
    },
    {
        name = 'nvim-treesitter-textobjects',
        src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
        setup = function()
            require('nvim-treesitter.configs').setup {
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ap'] = '@parameter.outer',
                            ['ip'] = '@parameter.inner',
                        },
                    }
                },
            }
        end
    }
}
