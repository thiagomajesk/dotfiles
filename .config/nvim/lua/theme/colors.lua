local utils       = require('theme.utils')

local colors      = {}

--
-- Base colors
--
colors.accent     = '#9ccfd8'
colors.primary    = '#6e6a86'
colors.secondary  = '#908caa'

colors.info       = '#c4a7e7'
colors.warn       = '#f6c177'
colors.error      = '#eb6f92'

colors.foreground = '#e0def4'
colors.background = '#191724'

--
-- Code colors
--
colors.keyword    = colors.primary
colors.entity     = colors.secondary
colors.func       = utils.tint(colors.primary, 0.7)
colors.string     = utils.tint(colors.foreground, 0.7)
colors.comment    = utils.tint(colors.background, 0.2)
colors.parameter  = utils.shade(colors.primary, 0.2)
colors.variable   = utils.shade(colors.foreground, 0.1)
colors.muted      = utils.shade(colors.foreground, 0.7)
colors.constant   = utils.shade(colors.foreground, 0.3)
colors.identifier = utils.shade(colors.accent, 0.2)

--
-- UI colors
--
colors.cursor     = colors.accent
colors.link       = colors.primary
colors.highlight  = colors.accent
colors.title      = utils.tint(colors.foreground, 0.4)
colors.panel      = utils.tint(colors.background, 0.02)
colors.border     = utils.tint(colors.background, 0.1)
colors.search     = utils.mix(colors.accent, colors.background, 0.4)
colors.selection  = utils.mix(colors.secondary, colors.background, 0.2)

return colors
