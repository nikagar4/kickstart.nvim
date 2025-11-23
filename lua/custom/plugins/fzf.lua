return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  -- dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- or if using mini.icons/mini.nvim
  dependencies = { 'nvim-mini/mini.icons' },
  config = function()
    local fzf = require 'fzf-lua'
    fzf.register_ui_select()

    fzf.setup {
      keymap = {
        builtin = {
          ['<C-u>'] = 'preview-half-page-up',
          ['<C-d>'] = 'preview-half-page-down',
          ['<C-b>'] = 'preview-page-up',
          ['<C-f>'] = 'preview-page-down',
        },
        fzf = {
          ['ctrl-q'] = 'select-all+accept',
        },
      },
      files = {
        profile = 'ivy',
        previewer = 'builtin',
        fzf_opts = {
          ['--layout'] = 'default',
        },
        fzf_colors = {
          ['gutter'] = '0',
        },
        winopts = {
          preview = {
            delay = 0,
            vertical = 'up:70%',
          },
        },
      },
      lsp = {
        profile = 'ivy',
        includeDeclaration = false,
        fzf_opts = {
          ['--layout'] = 'default',
        },
        fzf_colors = {
          ['gutter'] = '0',
        },
        winopts = {
          preview = {
            vertical = 'up:70%',
          },
        },
      },
      grep = {
        profile = 'ivy',
        input_prompt = '❯ ',
        actions = {
          ['enter'] = function(selected, opts)
            local oopts = vim.tbl_deep_extend('force', {}, opts, {
              copen = 'copen | wincmd p',
            })
            fzf.actions.file_edit_or_qf(selected, oopts)
          end,
        },
        fzf_opts = {
          ['--layout'] = 'default',
        },
        fzf_colors = {
          ['gutter'] = '0',
        },
        winopts = {
          preview = {
            delay = 0,
            vertical = 'up:70%',
          },
        },
      },
      helptags = {
        actions = {
          ['enter'] = fzf.actions.file_vsplit,
        },
      },
      actions = {
        files = {
          ['enter'] = function(selected, opts)
            local oopts = vim.tbl_deep_extend('force', {}, opts, {
              copen = 'copen | wincmd p',
            })
            fzf.actions.file_edit_or_qf(selected, oopts)
          end,
        },
      },
      winopts = {
        backdrop = 90,
      },
    }

    vim.keymap.set('n', '<leader>sh', fzf.helptags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', fzf.builtin, { desc = '[S]earch [S]elect Fzf' })
    vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('v', '<leader>sw', fzf.grep_visual, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>si', fzf.grep, { desc = '[S]earch [I]nserted word' })
    vim.keymap.set('n', '<leader>sl', fzf.live_grep, { desc = '[S]earch by [L]ive grep' })
    vim.keymap.set('n', '<leader>sg', fzf.git_status, { desc = '[S]earch by [G]it' })
    vim.keymap.set('n', '<leader>sq', fzf.quickfix, { desc = '[S]earch [Q]uickfix' })
    vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>sc', fzf.commands, { desc = '[S]earch [C]ommands' })
    vim.keymap.set('n', '<leader>sb', fzf.buffers, { desc = '[Search] current word in open [B]uffers' })
  end,
}
