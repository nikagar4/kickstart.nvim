return {
  -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    ---@diagnostic disable-next-line: missing-fields
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    ---@diagnostic disable-next-line: missing-fields
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting correct suggestions based on usage
    ---@diagnostic disable-next-line: missing-fields
    { 'nvim-telescope/telescope-frecency.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    ---@diagnostic disable-next-line: missing-fields
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      defaults = {
        wrap_results = true,
        path_display = { shorten = 4 },
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
          },
        },
        mappings = {
          i = {
            ['<c-q>'] = 'send_to_qflist',
            ['<c-j>'] = 'move_selection_next',
            ['<c-k>'] = 'move_selection_previous',
          },
          n = {
            ['<c-q>'] = 'send_to_qflist',
            ['<c-j>'] = 'move_selection_next',
            ['<c-k>'] = 'move_selection_previous',
          },
        },
      },
      pickers = {
        help_tags = {
          theme = 'ivy',
          mappings = {
            i = {
              ['<CR>'] = 'select_vertical',
            },
            n = {
              ['<CR>'] = 'select_vertical',
            },
          },
        },
        find_files = {
          theme = 'ivy',
        },
        lsp_references = {
          show_line = false,
          layout_strategy = 'vertical',
          layout_config = {
            width = 0.8,
            height = 0.8,
            prompt_position = 'top',
            mirror = true,
          },
        },
        lsp_definitions = {
          show_line = false,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_cursor(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'frecency')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>Sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>Sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>Ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set({ 'n', 'v' }, '<leader>Sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>Si', function()
      local search_term = vim.fn.input '>'
      if search_term ~= '' then
        builtin.grep_string { search = search_term }
      end
    end, { desc = '[S]earch [I]nserted word' })
    vim.keymap.set('n', '<leader>Sl', builtin.live_grep, { desc = '[S]earch by [L]ive grep' })
    vim.keymap.set('n', '<leader>Sg', builtin.git_status, { desc = '[S]earch by [G]it' })
    vim.keymap.set('n', '<leader>Sq', builtin.quickfix, { desc = '[S]earch [Q]uickfix' })
    vim.keymap.set('n', '<leader>Sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>Sc', builtin.commands, { desc = '[S]earch [C]ommands' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })
  end,
}
