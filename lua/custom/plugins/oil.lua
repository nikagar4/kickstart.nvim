return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    -- default_file_explorer = false,
    columns = {
      'icon',
      -- 'permissions',
      -- 'size',
      -- 'mtime',
    },
    keymaps = {
      ['<Esc><Esc>'] = { 'actions.close', mode = 'n' },
    },
    -- -- EXPERIMENTAL support for performing file operations with git
    -- git = {
    --   -- Return true to automatically git add/mv/rm files
    --   add = function(path)
    --     return false
    --   end,
    --   mv = function(src_path, dest_path)
    --     return false
    --   end,
    --   rm = function(path)
    --     return false
    --   end,
    -- },
    view_options = {
      show_hidden = true,
    },
  },
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  init = function()
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    vim.keymap.set('n', '<leader>oo', '<CMD>Oil --float<CR>', { desc = 'Open parent directory in floating window' })
  end,
}
