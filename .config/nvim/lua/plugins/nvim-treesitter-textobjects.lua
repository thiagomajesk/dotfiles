return {
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
