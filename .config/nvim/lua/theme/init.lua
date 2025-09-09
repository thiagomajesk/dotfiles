local M      = {}

local utils  = require('theme.utils')
local colors = require('theme.colors')

local hl     = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

function M.setup(opts)
    vim.cmd("hi clear")
    vim.g.colors_name = "monovoid"

    opts = opts or {}

    local transparent = opts.transparent or false
    local background = transparent and "NONE" or colors.background

    hl("Normal", { fg = colors.foreground, bg = background })
    hl("NormalNC", { fg = colors.muted })
    hl("NonText", { fg = colors.muted })
    hl("CursorLine", { bg = colors.selection })
    hl("CursorLineNr", { fg = colors.accent })
    hl("LineNr", { fg = colors.muted })
    hl("Visual", { bg = colors.selection })
    hl("StatusLine", { fg = colors.foreground, bg = colors.panel })
    hl("StatusLineNC", { fg = colors.muted, bg = colors.panel })
    hl("VertSplit", { fg = colors.border })
    hl("Pmenu", { fg = colors.foreground, bg = colors.panel })
    hl("PmenuSel", { fg = colors.background, bg = colors.primary })
    hl("MatchParen", { fg = colors.foreground, bg = colors.selection })
    hl("Search", { fg = colors.background, bg = colors.search })
    hl("IncSearch", { fg = colors.background, bg = colors.func })
    hl("Cursor", { fg = colors.background, bg = colors.cursor })

    hl("Comment", { fg = colors.comment, italic = true })
    hl("Constant", { fg = colors.constant })
    hl("String", { fg = colors.string })
    hl("Number", { fg = colors.string })
    hl("Boolean", { fg = colors.string })
    hl("Identifier", { fg = colors.identifier })
    hl("Function", { fg = colors.func })
    hl("Statement", { fg = colors.keyword })
    hl("Keyword", { fg = colors.keyword })
    hl("Type", { fg = colors.entity })
    hl("Special", { fg = colors.identifier })
    hl("Operator", { fg = colors.keyword })

    -- Treesitter
    hl("@variable", { fg = colors.variable })
    hl("@punctuation", { fg = colors.muted })

    -- Treesitter - Elixir
    hl("@constant.builtin.elixir", { link = "Constant" })
    hl("@punctuation.special.elixir", { fg = colors.muted })
    hl("@tag.heex", { fg = colors.secondary })
    hl("@function.heex", { fg = colors.secondary })
    hl("@tag.delimiter.heex", { fg = colors.muted })

    -- Forces markdown syntax inside comments to be colored like comments
    -- This is specially useful for heredocs that support markdown (eg: elixir's)
    hl("@markup.raw.markdown_inline", { link = "Comment" })
    hl("@markup.list.markdown", { link = "Comment" })

    -- Diagnostics
    hl("DiagnosticError", { fg = colors.error })
    hl("DiagnosticWarn", { fg = colors.warn })
    hl("DiagnosticInfo", { fg = colors.info })
    hl("DiagnosticHint", { fg = colors.primary })

    -- Misc UI
    hl("Title", { fg = colors.primary })
    hl("Directory", { fg = colors.link })
    hl("ErrorMsg", { fg = colors.error })
    hl("WarningMsg", { fg = colors.warn })
    hl("MoreMsg", { fg = colors.accent })
    hl("Question", { fg = colors.accent })
    hl("NormalFloat", { bg = colors.panel })

    -- Telescope
    hl("TelescopeNormal", { fg = colors.foreground, bg = background })
    hl("TelescopeBorder", { fg = colors.border, bg = background })
    hl("TelescopePromptNormal", { fg = colors.foreground, bg = background })
    hl("TelescopePromptBorder", { fg = colors.border, bg = background })
    hl("TelescopePromptTitle", { fg = colors.title, bold = true })
    hl("TelescopePreviewTitle", { fg = colors.title, bold = true })
    hl("TelescopeResultsTitle", { fg = colors.title, bold = true })
    hl("TelescopeSelection", { fg = colors.foreground, bg = colors.selection, bold = true })
    hl("TelescopeSelectionCaret", { fg = colors.accent })
    hl("TelescopeMatching", { fg = colors.accent, bold = true })
end

return M
