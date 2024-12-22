return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.

      if os.execute '[ -d ./*.xcodeproj ]' == 0 then
        vim.cmd.colorscheme 'xcodehc'
      else
        vim.cmd.colorscheme 'tokyonight'
      end

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
  },
  {
    'arzg/vim-colors-xcode',
  },
  --{
  --  'folke/styler.nvim',
  --  config = function()
  --    require('styler').setup {
  --      themes = {
  --        swift = { colorscheme = 'catppuccin-macchiato' },
  --      },
  --    }
  --  end,
  --},
}
