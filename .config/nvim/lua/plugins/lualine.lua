return {
    name = 'lualine',
    src = 'https://github.com/nvim-lualine/lualine.nvim',
    setup = {
        options = {
            section_separators = '',
            component_separators = '',
        },
        sections = {
            lualine_a = { 'mode' },
            -- lualine_b = { 'branch', 'diff', 'diagnostics' },
            -- lualine_c = { 'filename' },
            -- lualine_x = { 'filetype' },
            -- lualine_y = { 'progress' },
            -- lualine_z = { 'location' }
        },
    }
}
