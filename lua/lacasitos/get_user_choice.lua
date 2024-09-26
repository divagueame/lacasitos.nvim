vim.api.nvim_command('highlight AAABoomFloatingWindowBorder guifg=#ff0000 guibg=#ffffff') -- Example: Red border on white background
vim.api.nvim_command('highlight AAABoomFloatingWindowContent guifg=#000000 guibg=NONE') -- Black text on white background

local function create_floating_window(content)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)

  for i = 0, #content - 1 do
    vim.api.nvim_buf_add_highlight(buf, -1, "AAABoomFloatingWindowContent", i, 0, -1)
  end

  local width = 40
  local height = #content + 2
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = (vim.o.columns - width) / 2,
    row = (vim.o.lines - height) / 2,
    style = 'minimal',
    border = 'rounded',
  }

  local win_id = vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_win_set_option(win_id, 'winhl', 'Normal:AAABoomFloatingWindowContent,FloatBorder:AAABoomFloatingWindowBorder')

  return win_id
end

local get_user_choice = function(args, callback)

  local options = {}
  local display_content = {}
  for i, file in ipairs(args) do
    local letter = string.char(96 + i)
    options[letter] = file
    table.insert(display_content, string.format("%s: %s", letter, file))
  end

  local win_id = create_floating_window(display_content)

  vim.defer_fn(function()
    local char = vim.fn.getchar()
    local key = vim.fn.nr2char(char)
    print("User input: " .. key)

    vim.api.nvim_win_close(win_id, true)

    callback(key)
  end, 100)

end

return get_user_choice
