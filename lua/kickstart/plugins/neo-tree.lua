-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree left<CR>', desc = '[O]pen [N]eotree', silent = true },
    { '<leader>nb', ':Neotree buffers right<CR>', desc = 'NeoTree reveal buffers', silent = true },
  },
  opts = {
    filesystem = {
      enable_git_status = true,
      follow_current_file = {
        enabled = true,
      },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      window = {
        -- position = 'left',
        -- width = 40,
        mappings = {
          ['\\'] = 'close_window',
          ['<leader>on'] = 'close_window',
        },
      },
      default_component_configs = {
        name = {
          use_git_status_colors = true,
          highlight = 'NeoTreeFileName',
        },
      },
    },
    buffers = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
