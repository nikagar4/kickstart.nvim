return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
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
      -- natural_order = true, -- even the config I copied from says he doesn't know what it does
      -- is_always_hidden = function(name, _)
      --   return name == '..' or name == '.git'
      -- end,
    },
  },
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  init = function()
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = '[O]il Open parent directory' })
  end,
}
