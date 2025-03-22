return {
  -- 'mfussenegger/nvim-dap',
  -- dependencies = {
  --   -- Creates a beautiful debugger UI
  --   'rcarriga/nvim-dap-ui',

  --   -- Required dependency for nvim-dap-ui
  --   'nvim-neotest/nvim-nio',

  --   -- Installs the debug adapters for you
  --   'williamboman/mason.nvim',
  --   'jay-babu/mason-nvim-dap.nvim',

  --   -- Add your own debuggers here
  --   'leoluz/nvim-dap-go',

  --   -- XCodeBuild
  --   'wojciech-kulik/xcodebuild.nvim',
  -- },
  -- config = function()
  --   local xcodebuild = require 'xcodebuild.integrations.dap'
  --   local codelldbPath = os.getenv 'HOME' .. '/.tools/codelldb-darwin/extension/adapter/codelldb'
  --   xcodebuild.setup(codelldbPath)

  --   vim.keymap.set('n', '<leader>ll', xcodebuild.debug_without_build, { desc = 'Build & Debug' })
  --   vim.keymap.set('n', '<leader>ld', xcodebuild.debug_without_build, { desc = '[D]ebug Without Building' })
  --   vim.keymap.set('n', '<leader>lt', xcodebuild.debug_tests, { desc = 'Debug [T]ests' })
  --   vim.keymap.set('n', '<leader>lT', xcodebuild.debug_class_tests, { desc = 'Debug Class [T]ests' })
  --   vim.keymap.set('n', '<leader>lb', xcodebuild.toggle_breakpoint, { desc = 'Toggle [B]reakpoint' })
  --   vim.keymap.set('n', '<leader>lB', xcodebuild.toggle_message_breakpoint, { desc = 'Toggle Message [B]reakpoint' })
  --   vim.keymap.set('n', '<leader>lx', xcodebuild.terminate_session, { desc = 'Terminate Debugger' })
  -- end,
}
