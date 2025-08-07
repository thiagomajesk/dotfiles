local M = {}

local function push(table1, table2)
    if #table2 == 0 then
        table.insert(table1, table2)
    else
        for _, item in ipairs(table2) do
            table.insert(table1, item)
        end
    end
end

local function extract_configs(files)
    local extracted = {}

    for _, file in ipairs(files) do
        -- Extract the plugin name from the file path
        -- (eg: "lua/plugins/foo.lua" -> "plugins.foo")
        local name = file:match(".*/lua/(.*)%.lua$"):gsub("/", ".")

        local config_or_configs = require(name)

        -- If multiple configs are returned flattens the
        -- table to preserve order plugins will be required
        push(extracted, config_or_configs)
    end

    return extracted
end

local function setup_plugins(configs)
    local specs = {}

    for _, config in ipairs(configs) do
        assert(type(config) == 'table',
            string.format("'%s' should return a table, got %s", name, type(config)))

        assert(type(config.src) == "string",
            string.format("'%s' should have a string 'src' field, got %s", name, type(config.src)))

        assert(type(config.name) == "string",
            string.format("'%s' should have a string 'name' field, got %s", name, type(config.name)))

        table.insert(specs, { src = config.src, name = config.name })
    end

    vim.pack.add(specs)

    for _, config in ipairs(configs) do
        if config.require ~= false then
            local module = require(config.name)

            if type(config.setup) == 'function' then
                config.setup()
            elseif type(config.setup) == 'table' then
                module.setup(config.setup)
            elseif type(config.setup) ~= 'false' then
                module.setup()
            end
          end
    end
end

-- Loads and sets up Neovim plugins from the specified directory.
-- Relies on the native `vim.pack` plugin manager to handle specifications.
--
-- Each plugin file should return a table with the following options:
--  - name: (Required) The module name used for require() calls
--  - src: (Required) Plugin source URL (usually a GitHub repository)
--  - require: (Optional) Boolean indicating whether to require the plugin (defaults to true)
--  - setup: (Optional) Configuration table passed to plugin.setup() containing plugin-specific options
--
function M.setup(directory)
    local config_dir = vim.fn.stdpath('config')
    local plugins_dir = vim.fs.joinpath(config_dir, 'lua', directory)
    local plugin_files = vim.fn.glob(plugins_dir .. '/*.lua', false, true)

    vim.notify(string.format("Loading %d plugin(s)...", #plugin_files), vim.log.levels.INFO)

    setup_plugins(extract_configs(plugin_files))

    -- Clears lingering message after the setup is completed
    vim.defer_fn(function() vim.api.nvim_echo({ { "", "Normal" } }, false, {}) end, 1000)
end

function M.cleanup()
    local names = {}

    for _, plugin in ipairs(vim.pack.get()) do
        if not plugin.active then
            table.insert(names, plugin.spec.name)
        end
    end

    vim.notify(string.format("Cleaning %d plugin(s)...", #names), vim.log.levels.INFO)

    vim.pack.del(names)
end

return M
