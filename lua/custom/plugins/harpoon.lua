return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = '[H]arpoon [A]dd' })
    vim.keymap.set('n', '<leader>oh', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = '[O]pen [H]arpoon' })

    vim.keymap.set('n', '<M-C-H>', function()
      harpoon:list():select(1)
    end, { desc = 'Item 1 in harpoon' })
    vim.keymap.set('n', '<M-NL>', function()
      harpoon:list():select(2)
    end, { desc = 'Item 2 in harpoon' })
    vim.keymap.set('n', '<M-C-K>', function()
      harpoon:list():select(3)
    end, { desc = 'Item 3 in harpoon' })
    vim.keymap.set('n', '<M-C-L>', function()
      harpoon:list():select(4)
    end, { desc = 'Item 4 in harpoon' })

    -- [[ Marks ]]
    -- vim.keymap.set('n', '<leader>hm', function()
    --   harpoon:list('marks'):add()
    -- end, { desc = '[H]arpoon [M]ark' })
    -- vim.keymap.set('n', '<leader>hom', function()
    --   harpoon.ui:toggle_quick_menu(harpoon:list 'marks', { title = 'Marks' })
    -- end, { desc = '[O]pen [M]arks' })

    -- [[ Refs ]]
    vim.keymap.set('n', '<M-C-T>', function()
      harpoon:list('refs'):add()
    end, { desc = '[H]arpoon [R]eference' })
    vim.keymap.set('n', '<M-C-R>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list 'refs', { title = 'References' })
    end, { desc = '[O]pen [R]efs' })

    vim.keymap.set('n', '<M-C-Q>', function()
      harpoon:list('refs'):select(1)
    end, { desc = '[H]arpoon open ref [1]' })
    vim.keymap.set('n', '<M-C-W>', function()
      harpoon:list('refs'):select(2)
    end, { desc = '[H]arpoon open ref [2]' })
    vim.keymap.set('n', '<M-C-E>', function()
      harpoon:list('refs'):select(3)
    end, { desc = '[H]arpoon open ref [3]' })
    vim.keymap.set('n', '<M-C-A>', function()
      harpoon:list('refs'):select(4)
    end, { desc = '[H]arpoon open ref [4]' })
    vim.keymap.set('n', '<M-C-S>', function()
      harpoon:list('refs'):select(5)
    end, { desc = '[H]arpoon open ref [5]' })
    vim.keymap.set('n', '<M-C-D>', function()
      harpoon:list('refs'):select(6)
    end, { desc = '[H]arpoon open ref [6]' })
    vim.keymap.set('n', '<M-C-Z>', function()
      harpoon:list('refs'):select(7)
    end, { desc = '[H]arpoon open ref [7]' })
    vim.keymap.set('n', '<M-C-X>', function()
      harpoon:list('refs'):select(8)
    end, { desc = '[H]arpoon open ref [8]' })
    vim.keymap.set('n', '<M-C-C>', function()
      harpoon:list('refs'):select(9)
    end, { desc = '[H]arpoon open ref [9]' })
  end,
}
