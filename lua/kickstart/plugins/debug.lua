-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well.

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',

    -- XCodeBuild
    'wojciech-kulik/xcodebuild.nvim',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    local xcodebuild = require 'xcodebuild.integrations.dap'
    local codelldbPath = os.getenv 'HOME' .. '/.tools/codelldb-darwin/extension/adapter/codelldb'
    xcodebuild.setup(codelldbPath)

    -- [[ Default keymaps ]]
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    -- vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    -- vim.keymap.set('n', '<leader>B', function()
    --   dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    -- end, { desc = 'Debug: Set Breakpoint' })
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    -- [[ Xcodebuild keymaps ]]
    vim.keymap.set('n', '<leader>pD', xcodebuild.build_and_debug, { desc = 'Build & Debug' })
    vim.keymap.set('n', '<leader>pd', xcodebuild.debug_without_build, { desc = '[D]ebug Without Building' })
    vim.keymap.set('n', '<leader>lt', xcodebuild.debug_tests, { desc = 'Debug [T]ests' })
    vim.keymap.set('n', '<leader>lT', xcodebuild.debug_class_tests, { desc = 'Debug Class [T]ests' })
    vim.keymap.set('n', '<leader>lb', xcodebuild.toggle_breakpoint, { desc = 'Toggle [B]reakpoint' })
    vim.keymap.set('n', '<leader>lB', xcodebuild.toggle_message_breakpoint, { desc = 'Toggle Message [B]reakpoint' })
    vim.keymap.set('n', '<leader>lx', xcodebuild.terminate_session, { desc = 'Terminate Debugger' })

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- Dap UI setup
    -- Fr more information, see |:help nvim-dap-ui|

    ---@diagnostic disable-next-line: missing-fields
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        element = 'repl',
        enabled = true,
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
      floating = {
        border = 'single',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      layouts = {
        -- {
        --   elements = {
        --     { id = 'stacks', size = 0.25 },
        --     { id = 'scopes', size = 0.25 },
        --     { id = 'breakpoints', size = 0.25 },
        --     { id = 'watches', size = 0.25 },
        --   },
        --   position = 'right',
        --   size = 60,
        -- },
        {
          elements = {
            { id = 'console', size = 0.65 },
            { id = 'repl', size = 0.35 },
          },
          position = 'bottom',
          size = 10,
        },
      },
      -- controls = {
      --   element = 'repl',
      --   enabled = true,
      -- },
      -- floating = {
      --   border = 'single',
      --   mappings = {
      --     close = { 'q', '<Esc>' },
      --   },
      -- },
      -- icons = { collapsed = '', expanded = '', current_frame = '' },
      -- layouts = {
      --   {
      --     elements = {
      --       { id = 'stacks', size = 0.25 },
      --       { id = 'scopes', size = 0.25 },
      --       { id = 'breakpoints', size = 0.25 },
      --       { id = 'watches', size = 0.25 },
      --     },
      --     position = 'left',
      --     size = 60,
      --   },
      --   {
      --     elements = {
      --       { id = 'repl', size = 0.35 },
      --       { id = 'console', size = 0.65 },
      --     },
      --     position = 'bottom',
      --     size = 10,
      --   },
      -- },
    }

    -- Change breakpoint icons
    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    -- local breakpoint_icons = vim.g.have_nerd_font
    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    -- for type, icon in pairs(breakpoint_icons) do
    --   local tp = 'Dap' .. type
    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    -- end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end,
}
