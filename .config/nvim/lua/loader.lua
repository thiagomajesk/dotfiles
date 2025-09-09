local M = {}

local configs = {}

--
-- Add a plugin config to be loaded.
--
function M.add(name)
    local config = require('plugins.' .. name)

    -- If the content of a file is empty, Lua's require will return a boolean.
    -- When that happens, we likely just want to ignore that plugin and move on.
    if type(config) == "boolean" then return end

    assert(type(config) == 'table',
        string.format("'%s' should return a table, got %s", name, type(config)))

    assert(type(config.src) == "string",
        string.format("'%s' should have a string 'src' field, got %s", name, type(config.src)))

    assert(type(config.name) == "string",
        string.format("'%s' should have a string 'name' field, got %s", name, type(config.name)))

    table.insert(configs, config)
end

--
-- Load all plugins configs added.
--
function M.load()
    vim.notify(string.format("Loading %d plugin(s)...", #configs), vim.log.levels.INFO)

    for _, config in ipairs(configs) do
        -- The vim.pack.add function expects a list, so we wrap the config.
        -- (Hopefully calling vim.pack.add multiple times doesn't cause issues).
        vim.pack.add({ { name = config.name, src = config.src } })

        if config.require ~= false then
            local module = require(config.name)

            if type(config.setup) == 'table' then
                module.setup(config.setup)
            elseif type(config.setup) == 'function' then
                config.setup(module)
            elseif type(config.setup) ~= 'false' then
                module.setup()
            end
        end
    end

    -- Clears lingering message after the setup is completed
    vim.defer_fn(function() vim.api.nvim_echo({ { "", "Normal" } }, false, {}) end, 1000)
end

_G.Loader = M
