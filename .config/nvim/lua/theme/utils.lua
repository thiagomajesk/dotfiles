-- Utilities for color manipulation and blending
-- Inspired by the Vesper theme's color utilities
-- See: https://github.com/datsfilipe/vesper.nvim
--------------------------------------------------

local M = {}

---Convert a hexadecimal color string to RGB values
---@param hex string The hex color code (format: #RRGGBB)
---@return table RGB values as a table {r, g, b} with values from 0-255
local function hex_to_rgb(hex)
    local hex_type = '[abcdef0-9][abcdef0-9]'
    local pat = '^#(' .. hex_type .. ')(' .. hex_type .. ')(' .. hex_type .. ')$'
    hex = string.lower(hex)

    assert(string.find(hex, pat) ~= nil, 'hex_to_rgb: invalid hex: ' .. tostring(hex))

    local red, green, blue = string.match(hex, pat)
    return { tonumber(red, 16), tonumber(green, 16), tonumber(blue, 16) }
end

---Blend two colors together based on a specified percentage
---@param color1 string The first hex color (#RRGGBB)
---@param color2 string The second hex color (#RRGGBB)
---@param percentage number The percentage of color1 to use (0.0 to 1.0)
---@return string A hex color string representing the blended result
function M.mix(color1, color2, percentage)
    assert(type(color1) == 'string', string.format('color1 must be a string, got %s', type(color1)))
    assert(type(color2) == 'string', string.format('color2 must be a string, got %s', type(color2)))

    local rgb1 = hex_to_rgb(color1)
    local rgb2 = hex_to_rgb(color2)

    local blendChannel = function(i)
        local ret = (percentage * rgb1[i] + ((1 - percentage) * rgb2[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format('#%02X%02X%02X', blendChannel(1), blendChannel(2), blendChannel(3))
end

---Lighten a color by mixing it with white
---@param color string The hex color to lighten (#RRGGBB)
---@param value number How much white to mix in (0.0 to 1.0)
---@return string A lightened hex color string
function M.tint(color, value)
    return M.mix("#ffffff", color, math.abs(value))
end

---Darken a color by mixing it with black
---@param color string The hex color to darken (#RRGGBB)
---@param value number How much black to mix in (0.0 to 1.0)
---@return string A darkened hex color string
function M.shade(color, value)
    return M.mix("#000000", color, math.abs(value))
end

return M
