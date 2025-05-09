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
          enabled = false,
        },
      },
      logs = {
        logs_formatter = nil,
      },
      code_coverage = {
        enabled = true,
      },
    }

    vim.keymap.set('n', '<leader>xl', '<cmd>XcodebuildToggleLogs<cr>', { desc = 'Toggle Xcodebuild [L]ogs' })
    vim.keymap.set('n', '<leader>pb', '<cmd>XcodebuildBuild<cr>', { desc = '[B]uild' })
    vim.keymap.set('n', '<leader>px', '<cmd>XcodebuildBuildRun<cr>', { desc = 'Build & Run' })
    vim.keymap.set('n', '<leader>pr', '<cmd>XcodebuildRun<cr>', { desc = '[R]un' })
    vim.keymap.set('n', '<leader>xt', '<cmd>XcodebuildTest<cr>', { desc = 'Run [T]ests' })
    vim.keymap.set('n', '<leader>xT', '<cmd>XcodebuildTestClass<cr>', { desc = 'Run [T]his Test Class' })
    vim.keymap.set('n', '<leader>xa', '<cmd>XcodebuildPicker<cr>', { desc = 'Show All [X]codebuild Actions' })
    vim.keymap.set('n', '<leader>xd', '<cmd>XcodebuildSelectDevice<cr>', { desc = 'Select [D]evice' })
    vim.keymap.set('n', '<leader>xp', '<cmd>XcodebuildPreviewToggle<cr>', { desc = 'Toggle [P]review' })
    vim.keymap.set('n', '<leader>xP', '<cmd>XcodebuildSelectTestPlan<cr>', { desc = 'Select Test [P]lan' })
    -- vim.keymap.set('n', '<leader>xc', '<cmd>XcodebuildToggleCodeCoverage<cr>', { desc = 'Toggle Code [C]overage' })
    vim.keymap.set('n', '<leader>xc', '<cmd>XcodebuildCancel<cr>', { desc = '[C]ancel Build' })
    vim.keymap.set('n', '<leader>xC', '<cmd>XcodebuildShowCodeCoverageReport<cr>', { desc = 'Show Code [C]overage Report' })
    vim.keymap.set('n', '<leader>xq', '<cmd>Telescope quickfix<cr>', { desc = 'Show [Q]uickFix List' })
    vim.keymap.set('n', '<leader>xS', '<cmd>XcodebuildSetup<cr>', { desc = 'Run [X]codebuild [S]etup' })
    -- vim.keymap.set('n', '<leader>xx', '<cmd>XcodebuildCancel<cr>', { desc = '[X]codebuild terminate command' })
  end,
}
