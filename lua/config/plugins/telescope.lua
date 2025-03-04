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
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.6,
            results_width = 0.4,
          },
          width = 0.9,
          height = 0.8,
        },
      }
    }
    local builtin = require('telescope.builtin')
    vim.keymap.set("n", "<leader>ff", builtin.find_files)
    vim.keymap.set("n", "<leader>fF", function()
      builtin.find_files { hidden = true }
    end)
    vim.keymap.set("n", "<leader>fb", builtin.buffers)
    vim.keymap.set("n", "<leader>fw", builtin.live_grep)
    vim.keymap.set("n", "<leader>fc", builtin.grep_string)
    vim.keymap.set("n", "<leader>fr", builtin.lsp_references)
  end,
}
