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
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    -- {
    --   '<leader>b',
    --   function()
    --     require('dap').toggle_breakpoint()
    --   end,
    --   desc = 'Debug: Toggle Breakpoint',
    -- },
    -- {
    --   '<leader>B',
    --   function()
    --     require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    --   end,
    --   desc = 'Debug: Set Breakpoint',
    -- },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
    {
      '<leader>ll',
      function(opts)
        local xcodebuild = require 'xcodebuild.integrations.dap'
        xcodebuild.debug_without_build(opts)
      end,
      desc = 'Build & Debug',
    },
    {
      '<leader>ld',
      function(opts)
        local xcodebuild = require 'xcodebuild.integrations.dap'
        xcodebuild.debug_without_build(opts)
      end,
      desc = '[D]ebug Without Building',
    },
    {
      '<leader>lt',
      function()
        local xcodebuild = require 'xcodebuild.integrations.dap'
        xcodebuild.debug_tests()
      end,
      desc = 'Debug [T]ests',
    },
    {
      '<leader>lT',
      function()
        local xcodebuild = require 'xcodebuild.integrations.dap'
        xcodebuild.debug_class_tests()
      end,
      desc = 'Debug Class [T]ests',
    },
    {
      '<leader>lb',
      function()
        local xcodebuild = require 'xcodebuild.integrations.dap'
        xcodebuild.toggle_breakpoint()
      end,
      desc = 'Toggle [B]reakpoint',
    },
    {
      '<leader>lB',
      function()
        local xcodebuild = require 'xcodebuild.integrations.dap'
        xcodebuild.toggle_message_breakpoint()
      end,
      desc = 'Toggle Message [B]reakpoint',
    },
    {
      '<leader>lx',
      function()
        local xcodebuild = require 'xcodebuild.integrations.dap'
        xcodebuild.terminate_session()
      end,
      desc = 'Terminate Debugger',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    local xcodebuild = require 'xcodebuild.integrations.dap'
    local codelldbPath = os.getenv 'HOME' .. '/.tools/codelldb-darwin-x64/extension/adapter/codelldb'
    xcodebuild.setup(codelldbPath)

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
    -- For more information, see |:help nvim-dap-ui|
    -- dapui.setup {
    --   -- Set icons to characters that are more likely to work in every terminal.
    --   --    Feel free to remove or use ones that you like more! :)
    --   --    Don't feel like these are good choices.
    --   icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    --   controls = {
    --     icons = {
    --       pause = '⏸',
    --       play = '▶',
    --       step_into = '⏎',
    --       step_over = '⏭',
    --       step_out = '⏮',
    --       step_back = 'b',
    --       run_last = '▶▶',
    --       terminate = '⏹',
    --       disconnect = '⏏',
    --     },
    --   },
    -- }

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
        {
          elements = {
            { id = 'stacks', size = 0.25 },
            { id = 'scopes', size = 0.25 },
            { id = 'breakpoints', size = 0.25 },
            { id = 'watches', size = 0.25 },
          },
          position = 'left',
          size = 60,
        },
        {
          elements = {
            { id = 'repl', size = 0.35 },
            { id = 'console', size = 0.65 },
          },
          position = 'bottom',
          size = 10,
        },
      },
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
