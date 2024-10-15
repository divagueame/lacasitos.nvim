<p align="center">lacasitos.nvim</p>
<p align="center">Simple and quick picker. <b>Single Stroke</b> UI selector for Neovim.</p>
<div align="center">
  <img src="./doc/demo.png" alt="Demo">
</div>

## ⚡️ Features

- Take user input fast with a single keystroke
- Lightweight and easy to integrate
- Perfect for plugin developers and custom Neovim configurations
- Minimal UI that doesn't disrupt your focus

## 📋 Installation

Using Lazy:
```lua
return {
	"divagueame/lacasitos.nvim",
	config = function()
		require("lacasitos").setup()
	end,
}
```

## ☄ Usage
```lua
local lacasitos = require("lacasitos")
local animals = { "cat", "dog", "mouse"}
selected_option = lacasitos.choose_option(animals)
```

## Examples

In your plugin or Neovim config:
```lua
-- Example: Quick theme switcher
local themes = { "gruvbox", "nord", "tokyonight" }
local selected_theme = lacasitos.choose_option(themes)
vim.cmd("colorscheme " .. selected_theme)
```


Instead of an table of strings, you can pass a table instead of a string for each option, when the displayed text and the returned value are not expected to be the same.

```lua
local themes = {
    { label= "Gruvbox Material", value = "gruvbox-material" },
    { label= "Kanagawa Dragon", value = "kanagawa-dragon"}
}
local selected_theme = lacasitos.choose_option(themes)
vim.cmd("colorscheme " .. selected_theme)
```

## config

You can pass a config table to setup or to choose_option to override the default values for all windows or for a single one:
```lua
local lacasitos = require("lacasitos")

lacasitos.setup({
    window  = {
        title = "My common custom title"
    }
})

vim.api.nvim_set_hl(0, 'MyCustomHighlight', { fg = '#FFD700', bg = '#005f87', bold = true })

local animals = { "cat", "dog", "mouse"}

local opts = {
    title = {{"Unique colored title", "MyCustomHighlight"}} -- With your own highlight
    -- title = "My unique title"
}
local selected_option = lacasitos.choose_option(animals, opts)

print('Your animal is ' .. selected_option)
```

## ⌨ Contributing

PRs and issues are always welcome. Make sure to provide as much context as possible when opening one.

## 📜 License
Distributed under the MIT License. See LICENSE for more information.

