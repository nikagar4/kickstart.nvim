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
    { '\\', ':Neotree left<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>nn', ':Neotree float<CR>', desc = '[N]eotree reveal in center', silent = true },
    { '<leader>nb', ':Neotree buffers float<CR>', desc = '[N]eotree [B]uffers in center', silent = true },
    { '<leader>ns', ':Neotree git_status float<CR>', desc = '[N]eotree git [S]tatus in center', silent = true },
  },
  opts = {
    filesystem = {
      enable_git_status = true,
      follow_current_file = true,
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
      default_component_configs = {
        name = {
          use_git_status_colors = true,
          highlight = 'NeoTreeFileName',
        },
      },
    },
  },
}
