vim.cmd.colorscheme 'rose-pine-dawn'

vim.api.nvim_create_autocmd('ColorScheme', {
  desc = 'Reset highlights after colorscheme loads',
  group = vim.api.nvim_create_augroup('nika-highlight-colorscheme', { clear = true }),
  callback = function()
    vim.cmd.hi 'Comment gui=none'
    vim.cmd.hi 'Normal guibg=none ctermbg=none'
    -- vim.api.nvim_set_hl(0, 'Comment', { gui = 'none' })
    -- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none', ctermbg = 'none' })
  end,
})
