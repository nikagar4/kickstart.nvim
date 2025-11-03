return {
  'github/copilot.vim',
  cmd = 'Copilot',
  -- event = 'InsertEnter',
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    -- vim.g.copilot_filetypes = { ['*'] = false }
    -- disable automatic suggestions
    vim.g.copilot_enabled = false

    vim.keymap.set('i', '<M-C-S>', '<Plug>(copilot-suggest)', { desc = 'Trigger Copilot [S]uggestion' })
    vim.keymap.set('i', '<M-C-A>', 'copilot#Accept("")', {
      expr = true,
      replace_keycodes = false,
      silent = true,
      desc = '[A]ccept Copilot suggestion',
    })
    vim.keymap.set('i', '<M-NL>', '<Plug>(copilot-accept-line)', { silent = true, desc = 'Accept next Copilot line suggestion' })
    vim.keymap.set('i', '<M-C-L>', '<Plug>(copilot-accept-word)', { silent = true, desc = 'Accept next Copilot word suggestion' })

    vim.keymap.set('i', '<M-C-N>', '<Plug>(copilot-next)', { silent = true, desc = '[N]ext Copilot suggestion' })
    vim.keymap.set('i', '<M-C-P>', '<Plug>(copilot-previous)', { silent = true, desc = '[P]revious Copilot suggestion' })
    vim.keymap.set('i', '<M-C-D>', '<Plug>(copilot-dismiss)', { silent = true, desc = '[D]ismiss Copilot suggestion' })
  end,
}
