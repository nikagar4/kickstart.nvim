-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Keybinds to jump in the quickfix buffer
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Jump to the next item in quickfix' })
vim.keymap.set('n', '[q', vim.cmd.cprevious, { desc = 'Jump to the previous item in quickfix' })

-- Keybind to open project netrw
-- Disabled since Oil is enabled
-- vim.keymap.set('n', '<leader>ex', vim.cmd.Ex, { desc = 'Open project netrw' })

-- Keybinds to move selection up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '>-2<CR>gv=gv")

-- Register keymaps
-- Paste without overwriting register
-- vim.keymap.set('x', '<leader>p', '"_dP')
-- Yank into system clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')

-- Preview current buffer in glow (needs glow and tmux to be installed)
vim.keymap.set('n', '<leader>mo', function()
  local buffer_type = vim.api.nvim_get_option_value('filetype', {})
  local buffer = vim.api.nvim_buf_get_name(0)
  if buffer_type == 'markdown' then
    vim.cmd(':silent ! tmux neww glow -t ' .. buffer)
  else
    print('The file: ' .. buffer .. 'is not a markdown file')
  end
end, { desc = '[M]arkdown [O]pen' })

vim.keymap.set('n', '<leader>mp', function()
  local buffer_type = vim.api.nvim_get_option_value('filetype', {})
  local buffer = vim.api.nvim_buf_get_name(0)
  if buffer_type == 'markdown' then
    vim.cmd(':silent ! tmux split-pane -h glow -t ' .. buffer)
  else
    print('The file: ' .. buffer .. 'is not a markdown file')
  end
end, { desc = '[M]arkdown [P]review' })

-- Buffers
vim.keymap.set('n', ']b', '<cmd>bnext<CR>', { desc = 'Next Buffer' })
vim.keymap.set('n', '[b', '<cmd>bprev<CR>', { desc = 'Previous Buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR>', { desc = '[B]uffer [D]elete' })
vim.keymap.set('n', '<leader>bS', '<cmd>mks! .session.nvim<CR>', { desc = '[B]uffers [S]ave' })
vim.keymap.set('n', '<leader>bL', '<cmd>so .session.nvim<CR>', { desc = '[B]uffers [L]oad' })
vim.keymap.set('n', '<leader>br', '<cmd>e<CR>', { desc = '[B]uffers [R]eload' })
vim.keymap.set('n', '<leader>bp', function()
  print(vim.api.nvim_buf_get_name(0))
end, { desc = '[B]uffers [P]ath' })
vim.keymap.set('n', '<leader>bo', '<cmd>%bd|e#<CR>', { desc = '[B]uffer Delete [O]thers' })

-- Open
vim.keymap.set('n', '<leader>od', function()
  vim.diagnostic.open_float(nil, { focus = false })
end, { desc = '[O]pen [D]iagnostics' })
vim.keymap.set('n', '<leader>or', '<cmd>reg<CR>', { desc = '[O]pen [R]egister' })
-- lua/custom/plugins/harpoon.lua - <leader>oh open harpoon
-- lua/custom/plugins/which-key.lua - <leader>ow open which-key

-- Keybinds for cursor movement
-- vim.keymap.set('n', '^', '0')
-- vim.keymap.set('n', '0', '^')
