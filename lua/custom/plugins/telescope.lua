return {
  -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
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
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      defaults = {
        wrap_results = true,
        path_display = { shorten = 4 },
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
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
        marks = {
          initial_mode = 'normal',
        },
        find_files = {
          theme = 'ivy',
        },
        grep_string = {
          initial_mode = 'normal',
        },
        git_status = {
          initial_mode = 'normal',
        },
        diagnostics = {
          initial_mode = 'normal',
        },
        resume = {
          initial_mode = 'normal',
        },
        buffers = {
          initial_mode = 'normal',
          mappings = {
            n = {
              -- ['dd'] = function(prompt_bufnr)
              ['dd'] = function()
                -- this link might be useful: https://github.com/nvim-telescope/telescope.nvim/issues/2016
                local action_state = require 'telescope.actions.state'
                local selection = action_state.get_selected_entry()
                vim.api.nvim_buf_delete(selection.bufnr, {}) -- Close the Telescope picker
                -- local current_picker = action_state.get_current_picker(prompt_bufnr)
                -- current_picker:refresh()
                -- require('telescope.actions').close(prompt_bufnr)
              end,
            },
          },
        },
        lsp_references = {
          initial_mode = 'normal',
          show_line = false,
        },
        lsp_definitions = {
          initial_mode = 'normal',
          show_line = false,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'frecency')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = '[S]earch [M]arks' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>si', function()
      builtin.grep_string { search = vim.fn.input '>' }
    end, { desc = '[S]earch [I]nserted word' })
    vim.keymap.set('n', '<leader>sl', builtin.live_grep, { desc = '[S]earch by [L]ive grep' })
    vim.keymap.set('n', '<leader>sg', builtin.git_status, { desc = '[S]earch by [G]it' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    vim.keymap.set('n', '<leader>sb', function()
      builtin.grep_string {
        grep_open_files = true,
      }
    end, { desc = '[Search] current word in open [B]uffers' })
  end,
}
