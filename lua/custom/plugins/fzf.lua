return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  -- dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- or if using mini.icons/mini.nvim
  dependencies = { 'nvim-mini/mini.icons' },
  config = function()
    local fzf = require 'fzf-lua'
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
          -- ['ctrl-q'] = function(selected, all)
          --   fzf.actions.exec_menu()
          --   print(vim.inspect(selected))
          --   print(vim.inspect(all))
          -- end,
        },
      },
      files = {
        profile = 'ivy',
      },
      grep = {
        actions = {
          ['enter'] = function(selected, opts)
            local oopts = vim.tbl_deep_extend('force', {}, opts, {
              copen = false,
            })
            fzf.actions.file_edit_or_qf(selected, oopts)
          end,
        },
      },
      helptags = {
        actions = {
          ['enter'] = fzf.actions.file_vsplit,
        },
      },
      -- actions = {
      --   files = {
      --     ['enter'] = function(selected, opts)
      --       local oopts = vim.tbl_deep_extend('force', {}, opts, {
      --         copen = false,
      --       })
      --       fzf.actions.file_edit_or_qf(selected, oopts)
      --     end,
      --   },
      -- },
    }

    vim.keymap.set('n', '<leader>Sh', fzf.helptags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>Sm', fzf.marks, { desc = '[S]earch [M]arks' })
    vim.keymap.set('n', '<leader>Sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>Sf', fzf.files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>Ss', fzf.builtin, { desc = '[S]earch [S]elect Fzf' })
    vim.keymap.set('n', '<leader>Sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('v', '<leader>Sw', fzf.grep_visual, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>Si', fzf.grep, { desc = '[S]earch [I]nserted word' })
    vim.keymap.set('n', '<leader>Sl', fzf.live_grep, { desc = '[S]earch by [L]ive grep' })
    vim.keymap.set('n', '<leader>Sg', fzf.git_status, { desc = '[S]earch by [G]it' })
    vim.keymap.set('n', '<leader>Sd', fzf.diagnostics_workspace, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>Sq', fzf.quickfix, { desc = '[S]earch [Q]uickfix' })
    vim.keymap.set('n', '<leader>Sr', fzf.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>S.', fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>Sc', fzf.commands, { desc = '[S]earch [C]ommands' })
    -- vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>Sb', fzf.buffers, { desc = '[Search] current word in open [B]uffers' })
  end,
}
