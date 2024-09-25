-- You can use this loaded variable to enable conditional parts of your plugin.
if _G.LacasitosLoaded then
    return
end

_G.LacasitosLoaded = true

-- Useful if you want your plugin to be compatible with older (<0.7) neovim versions
if vim.fn.has("nvim-0.7") == 0 then
    vim.cmd("command! Lacasitos lua require('lacasitos').toggle()")
else
    vim.api.nvim_create_user_command("Lacasitos", function()
        require("lacasitos").toggle()
    end, {})
end
