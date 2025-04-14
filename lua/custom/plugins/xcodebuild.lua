return {
  'wojciech-kulik/xcodebuild.nvim',
  -- dir = vim.fn.expand '$HOME' .. '/Developer/lua/xcodebuild.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'MunifTanjim/nui.nvim',
    -- 'folke/snacks.nvim',
  },
  config = function()
    require('xcodebuild').setup {
      integrations = {
        neo_tree = {
          enabled = false,
        },
        oil_nvim = {
          enabled = true,
        },
      },
      logs = {
        logs_formatter = nil,
        show_warnings = true,
      },
      quickfix = {
        show_errors_on_quickfixlist = true, -- add build/test errors to quickfix list
        show_warnings_on_quickfixlist = false, -- add build warnings to quickfix list
      },
      code_coverage = {
        enabled = true,
      },
    }

    vim.keymap.set('n', '<leader>xl', '<cmd>XcodebuildToggleLogs<cr>', { desc = 'Toggle Xcodebuild [L]ogs' })
    vim.keymap.set('n', '<leader>pbb', '<cmd>XcodebuildBuild<cr>', { desc = '[B]uild' })
    vim.keymap.set('n', '<leader>pbr', '<cmd>XcodebuildBuildRun<cr>', { desc = '[B]uild & [R]un' })
    vim.keymap.set('n', '<leader>pbc', '<cmd>XcodebuildCancel<cr>', { desc = '[B]uild [C]ancel' })
    vim.keymap.set('n', '<leader>pr', '<cmd>XcodebuildRun<cr>', { desc = '[R]un' })
    vim.keymap.set('n', '<leader>ptr', '<cmd>XcodebuildTest<cr>', { desc = '[T]ests [R]un' })
    vim.keymap.set('n', '<leader>xT', '<cmd>XcodebuildTestClass<cr>', { desc = 'Run [T]his Test Class' })
    vim.keymap.set('n', '<leader>xa', '<cmd>XcodebuildPicker<cr>', { desc = 'Show All [X]codebuild Actions' })
    vim.keymap.set('n', '<leader>psd', '<cmd>XcodebuildSelectDevice<cr>', { desc = '[S]elect [D]evice' })
    vim.keymap.set('n', '<leader>xp', '<cmd>XcodebuildPreviewToggle<cr>', { desc = 'Toggle [P]review' })
    vim.keymap.set('n', '<leader>xP', '<cmd>XcodebuildSelectTestPlan<cr>', { desc = 'Select Test [P]lan' })
    -- vim.keymap.set('n', '<leader>xc', '<cmd>XcodebuildToggleCodeCoverage<cr>', { desc = 'Toggle Code [C]overage' })
    vim.keymap.set('n', '<leader>xC', '<cmd>XcodebuildShowCodeCoverageReport<cr>', { desc = 'Show Code [C]overage Report' })
    vim.keymap.set('n', '<leader>xq', '<cmd>Telescope quickfix<cr>', { desc = 'Show [Q]uickFix List' })
    vim.keymap.set('n', '<leader>xS', '<cmd>XcodebuildSetup<cr>', { desc = 'Run [X]codebuild [S]etup' })
    -- vim.keymap.set('n', '<leader>xx', '<cmd>XcodebuildCancel<cr>', { desc = '[X]codebuild terminate command' })
  end,
}
