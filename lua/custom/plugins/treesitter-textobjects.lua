return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  lazy = true,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup {
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- ['if'] = { query = '@call.inner', desc = 'Select inner part of a function call' },
            -- ['af'] = { query = '@call.outer', desc = 'Select outer part of a function call' },

            ['if'] = { query = '@function.inner', desc = 'Select inner part of a function' },
            ['af'] = { query = '@function.outer', desc = 'Select outer part of a function' },

            ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class' },
            ['ac'] = { query = '@class.outer', desc = 'Select outer part of a class' },

            -- ['ac'] = { query = '@comment.outer', desc = 'Select inner part of a comment' },

            -- ['ip'] = { query = '@parameter.inner', desc = 'Select outer part of a parameter' },
            -- ['ap'] = { query = '@parameter.outer', desc = 'Select outer part of a parameter' },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>na'] = '@parameter.outer',
            ['<leader>nf'] = '@function.outer',
          },
          swap_previous = {
            ['<leader>nA'] = '@parameter.outer',
            ['<leader>nF'] = '@function.outer',
          },
        },
        move = {
          enable = true,
          set_jumps = false,
          goto_next_start = {
            [']f'] = { query = '@function.outer', desc = 'Next function def start' },
          },
          goto_previous_start = {
            ['[f'] = { query = '@function.outer', desc = 'Next function def start' },
          },
        },
      },
    }
  end,
}
