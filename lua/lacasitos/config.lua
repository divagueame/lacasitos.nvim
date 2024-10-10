local log = require("lacasitos.util.log")

local Lacasitos = {}

--- Lacasitos configuration with its default values.
---
---@type table
--- Default values:
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
Lacasitos.options = {
  -- Prints useful logs about what event are triggered, and reasons actions are executed.
  debug = false,
  window ={
    style = 'minimal',
    relative = 'editor',
    border = "rounded",
    title = { {" Choose ", "Label"} },
    title_pos = 'left'
  }
}

---@private
local defaults = vim.deepcopy(Lacasitos.options)

--- Defaults Lacasitos options by merging user provided options with the default plugin values.
---
---@param options table Module config table. See |Lacasitos.options|.
---
---@private
function Lacasitos.defaults(options)
    Lacasitos.options =
        vim.deepcopy(vim.tbl_deep_extend("keep", options or {}, defaults or {}))

    -- let your user know that they provided a wrong value, this is reported when your plugin is executed.
    assert(
        type(Lacasitos.options.debug) == "boolean",
        "`debug` must be a boolean (`true` or `false`)."
    )

    return Lacasitos.options
end

--- Define your lacasitos setup.
---
---@param options table Module config table. See |Lacasitos.options|.
---
---@usage `require("lacasitos").setup()` (add `{}` with your |Lacasitos.options| table)
function Lacasitos.setup(options)
    Lacasitos.options = Lacasitos.defaults(options or {})

    log.warn_deprecation(Lacasitos.options)

    return Lacasitos.options
end

return Lacasitos
