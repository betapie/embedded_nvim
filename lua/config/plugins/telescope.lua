return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  -- or                              , branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<C-j>'] = require('telescope.actions').select_default,
          },
        },
        sorting_strategy = 'ascending',
        layout_config = {
          vertical = { width = 0.5 },
        },
      }
    }
    local builtin = require('telescope.builtin')
    vim.keymap.set("n", "<leader>ff", builtin.find_files)
    vim.keymap.set("n", "<leader>fb", builtin.buffers)
    vim.keymap.set("n", "<leader>fw", builtin.live_grep)
    vim.keymap.set("n", "<leader>fc", builtin.grep_string)
    vim.keymap.set("n", "<leader>fr", builtin.lsp_references)
  end,
}
