local main = require("lacasitos.main")
local config = require("lacasitos.config")

local Lacasitos = {}

--- Toggle the plugin by calling the `enable`/`disable` methods respectively.
function Lacasitos.toggle()
    if _G.Lacasitos.config == nil then
        _G.Lacasitos.config = config.options
    end

    main.toggle("public_api_toggle")
end

--- Initializes the plugin, sets event listeners and internal state.
function Lacasitos.enable(scope)
    if _G.Lacasitos.config == nil then
        _G.Lacasitos.config = config.options
    end

    main.toggle(scope or "public_api_enable")
end

--- Disables the plugin, clear highlight groups and autocmds, closes side buffers and resets the internal state.
function Lacasitos.disable()
    main.toggle("public_api_disable")
end

-- setup Lacasitos options and merge them with user provided ones.
function Lacasitos.setup(opts)
    _G.Lacasitos.config = config.setup(opts)
end

_G.Lacasitos = Lacasitos

return _G.Lacasitos
