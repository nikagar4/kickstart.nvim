return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    -- basic telescope configuration
    -- NOTE: This is not original, I changed it to fit mine
    local conf = require('telescope.config').values
    local function toggle_telescope(lists)
      local harpoon_items = {}
      for _, list in ipairs(lists) do
        for i, item in ipairs(list.items) do
          table.insert(harpoon_items, { file_path = item.value, list_name = list.name, index = i })
        end
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = harpoon_items,
            entry_maker = function(item)
              return {
                value = item.file_path,
                display = item.file_path .. ' - List [ ' .. string.upper(item.list_name) .. ' ]:' .. item.index,
                ordinal = item.file_path,
              }
            end,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
          initial_mode = 'normal',
        })
        :find()
    end

    local selected_list = 'q'
    local function open_and_select_list(list_name)
      harpoon.ui:close_menu()
      selected_list = list_name
      harpoon.ui:toggle_quick_menu(harpoon:list(selected_list), { title = 'Harpoon - [ ' .. string.upper(selected_list) .. ' ]' })
    end

    vim.keymap.set('n', '<M-C-T>', function()
      harpoon:list(selected_list):add()
    end, { desc = 'Harpoon Add' })
    vim.keymap.set('n', '<leader>oh', function()
      toggle_telescope {
        harpoon:list 'q',
        harpoon:list 'w',
        harpoon:list 'e',
      }
    end, { desc = '[O]pen All of [H]arpoon lists' })

    vim.keymap.set('n', '<M-C-H>', function()
      harpoon:list(selected_list):select(1)
    end, { desc = 'Item 1 in harpoon' })
    vim.keymap.set('n', '<M-NL>', function()
      harpoon:list(selected_list):select(2)
    end, { desc = 'Item 2 in harpoon' })
    vim.keymap.set('n', '<M-C-K>', function()
      harpoon:list(selected_list):select(3)
    end, { desc = 'Item 3 in harpoon' })
    vim.keymap.set('n', '<M-C-L>', function()
      harpoon:list(selected_list):select(4)
    end, { desc = 'Item 4 in harpoon' })

    vim.keymap.set('n', '<M-C-Q>', function()
      open_and_select_list 'q'
    end, { desc = 'Harpoon select or open list [Q]' })
    vim.keymap.set('n', '<M-C-W>', function()
      open_and_select_list 'w'
    end, { desc = 'Harpoon select or open list [W]' })
    vim.keymap.set('n', '<M-C-E>', function()
      open_and_select_list 'e'
    end, { desc = 'Harpoon select or open list [E]' })
    -- vim.keymap.set('n', '<M-C-A>', function()
    --   harpoon:list('refs'):select(4)
    -- end, { desc = '[H]arpoon open ref [4]' })
    -- vim.keymap.set('n', '<M-C-S>', function()
    --   harpoon:list('refs'):select(5)
    -- end, { desc = '[H]arpoon open ref [5]' })
    -- vim.keymap.set('n', '<M-C-D>', function()
    --   harpoon:list('refs'):select(6)
    -- end, { desc = '[H]arpoon open ref [6]' })
    -- vim.keymap.set('n', '<M-C-Z>', function()
    --   harpoon:list('refs'):select(7)
    -- end, { desc = '[H]arpoon open ref [7]' })
    -- vim.keymap.set('n', '<M-C-X>', function()
    --   harpoon:list('refs'):select(8)
    -- end, { desc = '[H]arpoon open ref [8]' })
    -- vim.keymap.set('n', '<M-C-C>', function()
    --   harpoon:list('refs'):select(9)
    -- end, { desc = '[H]arpoon open ref [9]' })
  end,
}
