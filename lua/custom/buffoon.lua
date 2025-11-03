local function get_buffers(opts)
  local bufnrs = vim.tbl_filter(function(bufnr)
    if 1 ~= vim.fn.buflisted(bufnr) then
      return false
    end

    return true
  end, vim.api.nvim_list_bufs())

  local buffers = {}
  for _, bufnr in ipairs(bufnrs) do
    local flag = bufnr == vim.fn.bufnr '' and '%' or (bufnr == vim.fn.bufnr '#' and '#' or ' ')

    local element = {
      bufnr = bufnr,
      flag = flag,
      info = vim.fn.getbufinfo(bufnr)[1],
    }

    table.insert(buffers, element)
  end

  local max_bufnr = math.max(unpack(bufnrs))
  opts.bufnr_width = #tostring(max_bufnr)

  return bufnrs
  -- return buffers
end

local function open_buffer_list_window()
  -- Get the list of all current buffers
  -- local buffers = vim.api.nvim_list_bufs()
  local buffers = get_buffers {}

  -- Create a new floating window for buffer list
  -- local width = math.floor(vim.o.columns * 0.6) -- 60% width of editor
  -- local height = math.floor(vim.o.lines * 0.4) -- 40% height of editor
  -- local row = math.floor((vim.o.lines - height) / 2) -- Centered vertically
  -- local col = math.floor((vim.o.columns - width) / 2) -- Centered horizontally
  local width = math.floor(vim.o.columns * 0.25) -- 60% width of editor
  local height = math.floor(vim.o.lines * 0.4) -- 40% height of editor
  local row = 0
  local col = vim.o.columns - width
  -- local width = 50
  -- local height = vim.o.lines
  -- local row = 0
  -- local col = vim.o.columns - width

  local window_buffer = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer

  -- Create the floating window and configure it
  local win = vim.api.nvim_open_win(window_buffer, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded', -- Nice rounded borders
  })

  -- Populate the buffer list into the window
  for _, buffer in ipairs(buffers) do
    local buf_name = vim.api.nvim_buf_get_name(buffer)
    buf_name = buf_name == '' and '[No Name]' or buf_name -- Display "[No Name]" for unnamed buffers
    -- local line = string.format('%d: %s\n', buffer, buf_name)
    local line = string.format('%d: %s', buffer, buf_name)
    vim.api.nvim_buf_set_lines(window_buffer, -1, -1, false, { line })
  end

  -- Make the buffer interactive: Add key mappings
  local function close_window()
    vim.api.nvim_win_close(win, true)
  end

  -- Close the window
  vim.api.nvim_buf_set_keymap(window_buffer, 'n', '<Esc>', '', {
    noremap = true,
    silent = true,
    callback = close_window,
  })

  -- vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', '', {
  -- COMMANDENSITIVE
  -- })
end

vim.keymap.set('n', '<leader>ob', open_buffer_list_window, { desc = '[O]pen [B]uffers' })
