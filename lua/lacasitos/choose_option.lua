vim.api.nvim_command('highlight LacasitosFloatingWindowBorder guifg=#3f3f0f guibg=#cdcdcd') 
vim.api.nvim_command('highlight LacasitosFloatingWindowContent guifg=#cdcdcd guibg=NONE')
vim.api.nvim_command('highlight LacasitosFloatingWindowPrefix guifg=#F38795 guibg=NONE')

local function create_floating_window(content, window_config)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)

  for i = 0, #content - 1 do
    vim.api.nvim_buf_add_highlight(buf, -1, "LacasitosFloatingWindowPrefix", i, 1, 2)
    vim.api.nvim_buf_add_highlight(buf, -1, "LacasitosFloatingWindowContent", i, 2, -1)
  end

  local max_width = 0
  for _, line in ipairs(content) do
    max_width = math.max(max_width, #line)
  end

  local padding = 2
  local width = max_width + padding
  local height = #content

  local win_config = {
    width = width,
    height = height,
    col = (vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2,
    -- style = 'minimal',
    -- relative = 'editor',
    -- border = "rounded",
    -- title = { {" Choose ", "Label"} },
    -- title_pos = 'left',
  }

  local config = _G.Lacasitos.config.window
  config = vim.tbl_extend("force", config, win_config)
  config = vim.tbl_extend("force", config, window_config or {})
  if config.title and type(config.title) == "string" then
    config.title = { {config.title, "Label"} }
  end

  return vim.api.nvim_open_win(buf, true, config)
end


local choose_option = function(args, window_config)
  if next(args) == nil then
    return nil
  end
  local custom_chars = {
    'f', 'd', 's', 'a', 'r', 'e', 't', 'w', 'q',
    'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p',
    'z', 'x', 'c', 'v', 'b', 'n', 'm',
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
    '`', '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')',
    '-', '_', '=', '+', '[', ']', '{', '}', ';', ':',
    '\'', '"', ',', '.', '<', '>', '/', '?', '\\'
  }
  local options = {}
  local display_content = {}
  for i, file in ipairs(args) do
    local letter = custom_chars[i]
    options[letter] = file
    table.insert(display_content, string.format(" %s %s", letter, file))
  end

  local win_id = create_floating_window(display_content, window_config)
  vim.cmd("redraw")

  local char = vim.fn.getchar()
  local key = vim.fn.nr2char(char)
  vim.api.nvim_win_close(win_id, true)

  return options[key] or nil
end

return choose_option
