return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>ff',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
    {
      '<leader>ft',
      function()
        -- If autoformat is currently disabled for this buffer,
        -- then enable it, otherwise disable it
        if vim.b.disable_autoformat then
          vim.cmd 'FormatEnable'
          vim.notify 'Enabled autoformat for current buffer'
        else
          vim.cmd 'FormatDisable!'
          vim.notify 'Disabled autoformat for current buffer'
        end
      end,
      desc = '[F]ormatter [T]oggle for current buffer',
    },
    {
      '<leader>fT',
      function()
        -- If autoformat is currently disabled globally,
        -- then enable it globally, otherwise disable it globally
        if vim.g.disable_autoformat then
          vim.cmd 'FormatEnable'
          vim.notify 'Enabled autoformat globally'
        else
          vim.cmd 'FormatDisable'
          vim.notify 'Disabled autoformat globally'
        end
      end,
      desc = '[F]ormatter [T]oggle globally',
    },
  },
  opts = {
    notify_on_error = false,
    autoformat = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true, markdown = true, swift = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- swift = { 'swiftformat' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
  config = function(_, opts)
    require('conform').setup(opts)

    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- :FormatDisable! disables autoformat for this buffer only
        vim.b.disable_autoformat = true
      else
        -- :FormatDisable disables autoformat globally
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true, -- allows the ! variant
    })

    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })
  end,
}
