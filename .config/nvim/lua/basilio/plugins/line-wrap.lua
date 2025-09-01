local M = {}

function M.wrap_long_line()
  local line = vim.api.nvim_get_current_line()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local wrap_width = vim.o.textwidth > 0 and vim.o.textwidth or 80
  
  if #line <= wrap_width then
    return
  end
  
  local wrapped_lines = {}
  local current_line = ""
  local words = {}
  
  -- Better word splitting that respects shell arguments
  local temp_line = line
  while temp_line ~= "" do
    local word = temp_line:match("^%S+")
    if word then
      table.insert(words, word)
      temp_line = temp_line:sub(#word + 1):gsub("^%s+", "")
    else
      break
    end
  end
  
  for i, word in ipairs(words) do
    local test_line = current_line == "" and word or current_line .. " " .. word
    
    if #test_line > wrap_width - 2 and current_line ~= "" then
      table.insert(wrapped_lines, current_line)
      current_line = word
    else
      current_line = test_line
    end
  end
  
  if current_line ~= "" then
    table.insert(wrapped_lines, current_line)
  end
  
  -- Add backslashes to all lines except the last one and indent continuation lines
  local indent = string.rep(" ", vim.o.shiftwidth)
  for i = 1, #wrapped_lines do
    if i > 1 then
      -- Indent continuation lines with shiftwidth spaces
      wrapped_lines[i] = indent .. wrapped_lines[i]
    end
    if i < #wrapped_lines then
      -- Add backslash to all lines except the last
      wrapped_lines[i] = wrapped_lines[i] .. " \\"
    end
  end
  
  if #wrapped_lines > 1 then
    vim.api.nvim_buf_set_lines(0, cursor_pos[1] - 1, cursor_pos[1], false, wrapped_lines)
  end
end

function M.wrap_visual_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2] - 1
  local end_line = end_pos[2] - 1
  
  local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line + 1, false)
  local all_lines = {}
  
  for i, line in ipairs(lines) do
    local clean_line = line:gsub("%s*\\%s*$", "")
    if clean_line ~= "" then
      table.insert(all_lines, clean_line)
    end
  end
  
  local combined = table.concat(all_lines, " ")
  local wrap_width = vim.o.textwidth > 0 and vim.o.textwidth or 80
  
  if #combined <= wrap_width then
    vim.api.nvim_buf_set_lines(0, start_line, end_line + 1, false, {combined})
    return
  end
  
  local wrapped_lines = {}
  local current_line = ""
  local words = {}
  
  -- Better word splitting that respects shell arguments
  local temp_line = combined
  while temp_line ~= "" do
    local word = temp_line:match("^%S+")
    if word then
      table.insert(words, word)
      temp_line = temp_line:sub(#word + 1):gsub("^%s+", "")
    else
      break
    end
  end
  
  for i, word in ipairs(words) do
    local test_line = current_line == "" and word or current_line .. " " .. word
    
    if #test_line > wrap_width - 2 and current_line ~= "" then
      table.insert(wrapped_lines, current_line)
      current_line = word
    else
      current_line = test_line
    end
  end
  
  if current_line ~= "" then
    table.insert(wrapped_lines, current_line)
  end
  
  -- Add backslashes to all lines except the last one and indent continuation lines
  local indent = string.rep(" ", vim.o.shiftwidth)
  for i = 1, #wrapped_lines do
    if i > 1 then
      -- Indent continuation lines with shiftwidth spaces
      wrapped_lines[i] = indent .. wrapped_lines[i]
    end
    if i < #wrapped_lines then
      -- Add backslash to all lines except the last
      wrapped_lines[i] = wrapped_lines[i] .. " \\"
    end
  end
  
  vim.api.nvim_buf_set_lines(0, start_line, end_line + 1, false, wrapped_lines)
end

function M.align_backslashes()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2] - 1
  local end_line = end_pos[2] - 1
  
  local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line + 1, false)
  local max_length = 0
  
  for _, line in ipairs(lines) do
    local clean_line = line:gsub("%s*\\%s*$", "")
    if #clean_line > max_length then
      max_length = #clean_line
    end
  end
  
  for i, line in ipairs(lines) do
    if line:match("\\%s*$") then
      local clean_line = line:gsub("%s*\\%s*$", "")
      local padding = string.rep(" ", max_length - #clean_line + 1)
      lines[i] = clean_line .. padding .. "\\"
    end
  end
  
  vim.api.nvim_buf_set_lines(0, start_line, end_line + 1, false, lines)
end

function M.unwrap_lines()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2] - 1
  local end_line = end_pos[2] - 1
  
  local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line + 1, false)
  local unwrapped = ""
  
  for _, line in ipairs(lines) do
    local clean_line = line:gsub("%s*\\%s*$", "")
    if unwrapped == "" then
      unwrapped = clean_line
    else
      unwrapped = unwrapped .. " " .. clean_line:gsub("^%s*", "")
    end
  end
  
  vim.api.nvim_buf_set_lines(0, start_line, end_line + 1, false, {unwrapped})
end

vim.keymap.set('n', '<leader>lw', M.wrap_long_line, { desc = 'Wrap long line with backslashes' })
vim.keymap.set('v', '<leader>lw', M.wrap_visual_selection, { desc = 'Wrap selected lines with backslashes' })
vim.keymap.set('v', '<leader>la', M.align_backslashes, { desc = 'Align backslashes in selection' })
vim.keymap.set('v', '<leader>lu', M.unwrap_lines, { desc = 'Unwrap lines (remove backslashes)' })

return {}