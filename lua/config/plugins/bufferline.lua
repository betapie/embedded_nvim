return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require("bufferline").setup {}

    vim.keymap.set("n", "]b", ":BufferLineCycleNext<CR>", { silent = true, desc = "Next buffer" })
    vim.keymap.set("n", "[b", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Prev buffer" })

    vim.keymap.set("n", "<leader>bo", ":BufferLineCloseOthers<CR>", { silent = true, desc = "Close other buffers" })
    vim.keymap.set("n", "<leader>ba", function()
      vim.cmd("BufferLineCloseOthers")
      vim.cmd("bdelete")
    end, { silent = true, desc = "Close all buffers" })

    vim.keymap.set("n", "<leader>bh", ":BufferLineMovePrev<CR>", { silent = true, desc = "Move buffer left" })
    vim.keymap.set("n", "<leader>bl", ":BufferLineMoveNext<CR>", { silent = true, desc = "Move buffer right" })
    vim.keymap.set("n", "<leader>bH", ":BufferLineMoveTo 1<CR>", { silent = true, desc = "Move buffer to first" })
    vim.keymap.set("n", "<leader>bL", ":BufferLineMoveTo -1<CR>", { silent = true, desc = "Move buffer to last" })
  end
}
