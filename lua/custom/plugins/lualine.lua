local function xcodebuild_device()
  if vim.g.xcodebuild_platform == 'macOS' then
    return ' macOS'
  end

  local deviceIcon = ''
  if vim.g.xcodebuild_platform:match 'watch' then
    deviceIcon = '􀟤'
  elseif vim.g.xcodebuild_platform:match 'tv' then
    deviceIcon = '􀡴 '
  elseif vim.g.xcodebuild_platform:match 'vision' then
    deviceIcon = '􁎖 '
  end

  if vim.g.xcodebuild_os then
    return deviceIcon .. ' ' .. vim.g.xcodebuild_device_name .. ' (' .. vim.g.xcodebuild_os .. ')'
  end

  return deviceIcon .. ' ' .. vim.g.xcodebuild_device_name
end

return {
  'nvim-lualine/lualine.nvim',
  -- dir = vim.fn.expand '$HOME' .. '/Developer/Lua/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'rose-pine',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      always_show_tabline = true,
      globalstatus = false,
      refresh = {
        statusline = 100,
        tabline = 100,
        winbar = 100,
      },
    },
    sections = {
      lualine_a = { 'searchcount', 'mode' },
      lualine_b = { 'diff', 'diagnostics' },
      lualine_c = { 'buffers' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {
      lualine_c = {
        { "'󰣪 ' .. vim.g.xcodebuild_last_status", color = { fg = 'Gray' } },
        { "'󰙨 ' .. vim.g.xcodebuild_test_plan", color = { fg = '#a6e3a1', bg = '#161622' } },
        { "' ' .. vim.g.xcodebuild_scheme", color = { fg = 'Gray' } },
        { xcodebuild_device, color = { fg = '#f9e2af' } },
      },
    },
    inactive_winbar = {},
    extensions = {},
  },
}
